import { parsePhoneNumberWithError } from 'libphonenumber-js';
import jwt from 'jsonwebtoken';
import {
    getDirectusCollection,
    createDirectusItem,
    updateDirectusItem,
    deleteDirectusItem,
} from '~~/server/services/serverCms';

// types
import type { IUser } from '~~/interfaces/entities/user';
import type { IOtp } from '~~/interfaces/entities/otp';
import type { IJwtPayload } from '~~/interfaces/jwt-payload';
import type { PhoneNumber, CountryCode } from 'libphonenumber-js';

const config = useRuntimeConfig();

const jwtSecret = config.jwt.secret;
const jwtExpiration = '7d';
const maxAttemps: number = 3;

const phoneCountry = config.smsru.phoneCountry as CountryCode;
const phoneFormat = config.smsru.phoneFormat as
    | 'NATIONAL'
    | 'INTERNATIONAL'
    | 'E.164'
    | 'RFC3966'
    | 'IDD';

export default defineEventHandler(
    async (event): Promise<{ status: number; error?: string; success: boolean; user?: IUser }> => {
        const { phone, code } = await readBody<IOtp>(event);

        let parsedPhone: PhoneNumber;

        try {
            parsedPhone = parsePhoneNumberWithError(phone, phoneCountry);
            if (!parsedPhone.isValid()) {
                return { status: 400, error: 'Invalid phone number', success: false };
            }
        } catch {
            return { status: 500, error: 'Phone validation error', success: false };
        }

        const formattedPhone = parsedPhone.format(phoneFormat);

        // Find OTP
        const otps = await getDirectusCollection<IOtp[]>('otp_codes', {
            filter: { phone: { _eq: formattedPhone } },
            sort: '-date_created',
            limit: 1,
        });
        const otp = Array.isArray(otps) ? otps[0] : null;
        if (
            !otp ||
            new Date(otp.expires_at + (otp.expires_at.endsWith('Z') ? '' : 'Z')) < new Date() ||
            otp.code !== code
        ) {
            if (otp) {
                const newAttempts = otp.attempts++;
                const updatedOtp = await updateDirectusItem<IOtp>('otp_codes', otp.id, {
                    attempts: newAttempts,
                });
                if (!updatedOtp) {
                    return { status: 500, error: 'Failed to update attempts', success: false };
                }
                if (newAttempts >= maxAttemps) {
                    const deleted = await deleteDirectusItem('otp_codes', otp.id);
                    if (!deleted) {
                        return {
                            status: 500,
                            error: 'Failed to delete OTP after max attempts',
                            success: false,
                        };
                    }
                    return { status: 429, error: 'Max attempts reached', success: false };
                }
            }
            return { status: 403, error: 'Invalid or expired code', success: false };
        }

        // Find/create user
        const users = await getDirectusCollection<IUser[]>('users', {
            filter: { phone: { _eq: formattedPhone } },
            limit: 1,
        });
        let user = Array.isArray(users) ? users[0] : null;

        if (!user) {
            user = await createDirectusItem<IUser>(
                'users',
                {
                    phone: formattedPhone,
                    addresses: [],
                    cart: [],
                },
                {
                    checkFilter: { phone: { _eq: formattedPhone } },
                }
            );
            if (!user) {
                return { status: 500, error: 'Failed to create user', success: false };
            }
        }

        // JWT
        const token = jwt.sign(
            { id: user.id, phone: user.phone, role: 'client' } as Partial<IJwtPayload>,
            jwtSecret,
            {
                expiresIn: jwtExpiration,
            }
        );

        setCookie(event, 'authorization', token, {
            httpOnly: true,
            secure: false,
            sameSite: 'strict',
            maxAge: 60 * 60 * parseInt(jwtExpiration),
            path: '/',
        });

        return { status: 200, success: true, user };
    }
);
