import validator from 'validator';
import jwt from 'jsonwebtoken';
import {
    getDirectusCollection,
    updateDirectusItem,
    deleteDirectusItem,
} from '~~/server/services/serverCms';

// types
import type { IUser } from '~~/interfaces/entities/user';
import type { IResetOtp } from '~~/interfaces/entities/reset-otp';
import type { IJwtPayload } from '~~/interfaces/jwt-payload';

const config = useRuntimeConfig();
const isDev = config.public.appEnv === 'dev';

const JWT_SECRET = config.jwt.secret;
const MAX_ATTEMPTS: number = 3;
const JWT_EXPIRATION = '10m';

export default defineEventHandler(
    async (event): Promise<{ status: number; message?: string; success: boolean }> => {
        const { email, code } = await readBody<{ email: string; code: string }>(event);

        if (!validator.isEmail(email)) {
            return { status: 400, message: 'Некорректный e-mail', success: false };
        }

        const users = await getDirectusCollection<IUser[]>('users', {
            filter: { email: { _eq: email } },
            limit: 1,
        });
        const user = Array.isArray(users) ? users[0] : null;

        if (!user) {
            return {
                status: 403,
                message: 'Некорректный токен: начните сброс с начала',
                success: false,
            };
        }

        // Find OTP
        const otps = await getDirectusCollection<IResetOtp[]>('password_reset_otps', {
            filter: { user_id: { _eq: user.id } },
            sort: '-date_created',
            limit: 1,
        });
        const otp = Array.isArray(otps) ? otps[0] : null;

        if (!otp || new Date(otp.expires_at + (otp.expires_at.endsWith('Z') ? '' : 'Z')) < new Date() || otp.code !== code) {
            if (otp) {
                const newAttempts = otp.attempts++;
                await updateDirectusItem<IResetOtp>('password_reset_otps', otp.id, {
                    attempts: newAttempts,
                });
                if (newAttempts >= MAX_ATTEMPTS) {
                    await deleteDirectusItem('password_reset_otps', otp.id);
                    return {
                        status: 429,
                        message: 'Достигнуто максимальное количество попыток. Пожалуйста, свяжитесь с поддержкой',
                        success: false,
                    };
                }
            }
            return {
                status: 403,
                message: 'Некорректный токен: начните сброс с начала',
                success: false,
            };
        }

        // Gen temp token
        const resetToken = jwt.sign({ id: user.id } as Partial<IJwtPayload>, JWT_SECRET, {
            expiresIn: JWT_EXPIRATION,
        });

        await deleteDirectusItem('password_reset_otps', otp.id);

        setCookie(event, 'reset-password', resetToken, {
            httpOnly: true,
            secure: !isDev,
            sameSite: 'strict',
            maxAge: 60 * 60 * parseInt(JWT_EXPIRATION),
            path: '/',
        });

        return { status: 200, success: true };
    }
);
