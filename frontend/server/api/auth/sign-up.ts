import { parsePhoneNumberWithError } from 'libphonenumber-js';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import validator from 'validator';
import { getDirectusCollection, createDirectusItem } from '~~/server/services/serverCms';

// types
import type { IUser } from '~~/interfaces/entities/user';
import type { IJwtPayload } from '~~/interfaces/jwt-payload';
import type { PhoneNumber, CountryCode } from 'libphonenumber-js';

const config = useRuntimeConfig();
const isDev = config.public.appEnv === 'dev';

const JWT_SECRET = config.jwt.secret;
const JWT_EXPIRATION = '7d';
const PHONE_COUNTRY = config.auth.phoneCountry as CountryCode;
const PHONE_FORMAT = config.auth.phoneFormat as
    | 'NATIONAL'
    | 'INTERNATIONAL'
    | 'E.164'
    | 'RFC3966'
    | 'IDD';
const SALT_ROUNDS = 12;

export default defineEventHandler(
    async (
        event
    ): Promise<{
        status: number;
        message?: string;
        success: boolean;
        user: Omit<IUser, 'password'> | null;
    }> => {
        const { phone, password, email } = await readBody<{
            phone: IUser['phone'];
            password: IUser['password'];
            email: IUser['email'];
        }>(event);

        if (!validator.isEmail(email)) {
            return { status: 400, message: 'Invalid email', success: false, user: null };
        }

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

        // Check existing phone
        const existingPhones = await getDirectusCollection<IUser[]>('users', {
            filter: { phone: { _eq: formattedPhone } },
            limit: 1,
        });
        if (existingPhones.length > 0) {
            return { status: 409, message: 'User already exists', success: false, user: null };
        }

        // Check existing email
        const existingEmails = await getDirectusCollection<IUser[]>('users', {
            filter: { email: { _eq: email } },
            limit: 1,
        });
        if (existingEmails.length > 0) {
            return { status: 409, message: 'User already exists', success: false, user: null };
        }

        const hashedPassword = await bcrypt.hash(password, SALT_ROUNDS);

        // Create user
        const user = await createDirectusItem<IUser>(
            'users',
            {
                phone: formattedPhone,
                password: hashedPassword,
                email,
                notifications: true,
                promo_subscribe: false,
                orders: [],
                addresses: [],
                cart: [],
                login_attempts: 0,
            },
            {
                checkFilter: { phone: { _eq: formattedPhone } },
            }
        );
        if (!user) {
            return { status: 500, message: 'Failed to create user', success: false, user: null };
        }

        const token = jwt.sign(
            { id: user.id, phone: user.phone, role: 'client' } as Partial<IJwtPayload>,
            JWT_SECRET,
            {
                expiresIn: JWT_EXPIRATION,
            }
        );

        setCookie(event, 'authorization', token, {
            httpOnly: true,
            secure: !isDev,
            sameSite: 'strict',
            maxAge: 60 * 60 * parseInt(JWT_EXPIRATION),
            path: '/',
        });

        const { password: _, ...userWithoutPassword } = user;

        return { status: 200, success: true, user: userWithoutPassword };
    }
);
