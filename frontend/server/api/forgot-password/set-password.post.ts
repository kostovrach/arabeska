import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import { getDirectusItem, updateDirectusItem } from '~~/server/services/serverCms';

// types
import type { IUser } from '~~/interfaces/entities/user';
import type { IJwtPayload } from '~~/interfaces/jwt-payload';

const config = useRuntimeConfig();
const isDev = config.public.appEnv === 'dev';

const JWT_SECRET = config.jwt.secret;
const JWT_EXPIRATION = '7d';
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
        const { password: new_password } = await readBody<{ password: string }>(event);
        const reset_token = getCookie(event, 'reset-password');
        if (!reset_token) {
            return {
                status: 403,
                message: 'Некорректный токен: начните сброс с начала',
                success: false,
                user: null,
            };
        }

        if (new_password.length < 10) {
            return {
                status: 400,
                message: 'Пароль должен содержать не менее 10 символов',
                success: false,
                user: null,
            };
        }

        // Verify reset_token
        let decoded: IJwtPayload;
        try {
            decoded = jwt.verify(reset_token, JWT_SECRET) as IJwtPayload;
        } catch {
            return {
                status: 403,
                message: 'Некорректный токен: начните сброс с начала',
                success: false,
                user: null,
            };
        }

        const userId = decoded.id;
        if (!userId) {
            return { status: 403, message: 'Некорректный токен', success: false, user: null };
        }

        // Find user
        const user = await getDirectusItem<IUser>('users', userId);
        if (!user) {
            return { status: 404, message: 'Пользователь не найден', success: false, user: null };
        }

        const hashedPassword = await bcrypt.hash(new_password, SALT_ROUNDS);

        // Update user
        const updUser = await updateDirectusItem<IUser>('users', user.id, {
            password: hashedPassword,
            login_attempts: 0,
        });
        if (!updUser) {
            return {
                status: 500,
                message: 'Произошла непредвиденная ошибка, попробуйте повторить попытку позже',
                success: false,
                user: null,
            };
        }

        // Login
        const authToken = jwt.sign(
            { id: user.id, phone: user.phone, role: 'client' } as Partial<IJwtPayload>,
            JWT_SECRET,
            { expiresIn: JWT_EXPIRATION }
        );

        setCookie(event, 'authorization', authToken, {
            httpOnly: true,
            secure: !isDev,
            sameSite: 'strict',
            maxAge: 60 * 60 * parseInt(JWT_EXPIRATION),
            path: '/',
        });

        deleteCookie(event, 'reset-password', {
            path: '/',
            sameSite: 'strict',
        });

        const { password: _, ...userWithoutPassword } = user;

        return { status: 200, success: true, user: userWithoutPassword };
    }
);
