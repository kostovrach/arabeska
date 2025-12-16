import type { IUser } from '~~/interfaces/entities/user';
import { checkUser } from '~~/server/services/checkUser';
import { getDirectusItem, updateDirectusItem } from '~~/server/services/serverCms';

export default defineEventHandler(
    async (event): Promise<{ status: number; message?: string; success: boolean }> => {
        const { status, message, data: userData } = checkUser(event);
        if (!userData) return { status, message, success: false };

        try {
            const user = await getDirectusItem<IUser>('users', userData.id);
            if (!user) return { status: 404, message: 'User not found', success: false };

            const updateCart = await updateDirectusItem<IUser>('users', userData.id, { cart: [] });
            if (!updateCart) return { status: 500, message: 'Server error', success: false };

            return { status: 200, success: true };
        } catch (err) {
            return { status: 500, message: `${err}`, success: false };
        }
    }
);
