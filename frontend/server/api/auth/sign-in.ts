import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import { parsePhoneNumberWithError } from 'libphonenumber-js';
import { getDirectusCollection, updateDirectusItem } from '~~/server/services/serverCms';

// types
import type { IUser } from '~~/interfaces/entities/user';
import type { PhoneNumber, CountryCode } from 'libphonenumber-js';
import type { IJwtPayload } from '~~/interfaces/jwt-payload';

const config = useRuntimeConfig();

const JWT_SECRET = config.jwt.secret;
const JWT_EXPIRATION = '7d';
const MAX_ATTEMPTS = 3;
const COOLDOWN_MINUTES = 2;
const PHONE_COUNTRY = config.auth.phoneCountry as CountryCode;
const PHONE_FORMAT = config.auth.phoneFormat as
    | 'NATIONAL'
    | 'INTERNATIONAL'
    | 'E.164'
    | 'RFC3966'
    | 'IDD';

export default defineEventHandler(
    async (
        event
    ): Promise<{
        status: number;
        message?: string;
        success: boolean;
        user: Omit<IUser, 'password'> | null;
    }> => {
        const { phone, password } = await readBody<{
            phone: IUser['phone'];
            password: IUser['password'];
        }>(event);

        let parsedPhone: PhoneNumber;

        try {
            parsedPhone = parsePhoneNumberWithError(phone, PHONE_COUNTRY);

            if (!parsedPhone.isValid()) {
                return { status: 400, message: 'Invalid phone number', success: false, user: null };
            }
        } catch {
            return { status: 500, message: 'Phone validation error', success: false, user: null };
        }

        const formattedPhone = parsedPhone.format(PHONE_FORMAT);

        // Find user
        const users = await getDirectusCollection<IUser[]>('users', {
            filter: { phone: { _eq: formattedPhone } },
            limit: 1,
        });
        const user = Array.isArray(users) ? users[0] : null;

        if (!user) {
            return { status: 401, message: 'Invalid credentials', success: false, user: null };
        }

        // Check cooldown
        if (user.login_attempts >= MAX_ATTEMPTS && user.last_login_attempt) {
            const lastAttemptTime = new Date(user.last_login_attempt).getTime();
            const cooldownEnd = lastAttemptTime + COOLDOWN_MINUTES * 60 * 1000;

            if (Date.now() < cooldownEnd) {
                return {
                    status: 429,
                    message: 'Too many attempts, please wait',
                    success: false,
                    user: null,
                };
            } else {
                await updateDirectusItem<IUser>('users', user.id, {
                    login_attempts: 0,
                    last_login_attempt: null,
                });
            }
        }

        // Verify password
        const passwordMatch = await bcrypt.compare(password, user.password);
        if (!passwordMatch) {
            const newAttempts = (user.login_attempts || 0) + 1;
            await updateDirectusItem<IUser>('users', user.id, {
                login_attempts: newAttempts,
                last_login_attempt: new Date().toISOString(),
            });

            return { status: 401, message: 'Invalid credentials', success: false, user: null };
        }

        await updateDirectusItem<IUser>('users', user.id, {
            login_attempts: 0,
            last_login_attempt: null,
        });

        const token = jwt.sign(
            { id: user.id, phone: user.phone, role: 'client' } as Partial<IJwtPayload>,
            JWT_SECRET,
            {
                expiresIn: JWT_EXPIRATION,
            }
        );

        setCookie(event, 'authorization', token, {
            httpOnly: true,
            secure: false,
            sameSite: 'strict',
            maxAge: 60 * 60 * parseInt(JWT_EXPIRATION),
            path: '/',
        });

        const { password: _, ...userWithoutPassword } = user;

        return { status: 200, success: true, user: userWithoutPassword };
    }
);
