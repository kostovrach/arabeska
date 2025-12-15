import type { IUser } from '~~/interfaces/entities/user';
import { checkUser } from '~~/server/services/checkUser';
import { getDirectusItem } from '~~/server/services/serverCms';

export default defineEventHandler(
    async (
        event
    ): Promise<{
        status: number;
        success: boolean;
        message?: string;
        user: Omit<IUser, 'password'> | null;
    }> => {
        const { status, message, data: userData } = checkUser(event);

        if (!userData) return { status, message, user: null, success: false };

        try {
            const user = await getDirectusItem<IUser>('users', userData.id);

            if (!user) {
                return { status: 404, message: 'User not found', user: null, success: false };
            }

            const { password: _, ...userWithoutPassword } = user;

            return { status: 200, user: userWithoutPassword, success: true };
        } catch (err) {
            console.error(err);
            return { status: 401, message: 'Invalid or expired token', user: null, success: false };
        }
    }
);
