import type { ICartItem } from '~~/interfaces/entities/cart-item';
import type { IUser } from '~~/interfaces/entities/user';

import { checkUser } from '~~/server/services/checkUser';
import { getDirectusItem } from '~~/server/services/serverCms';

export default defineEventHandler(
    async (event): Promise<{ status: number; message?: string; cart: ICartItem[] }> => {
        const { status, message, data: userData } = checkUser(event);

        if (!userData) return { status, message, cart: [] };

        try {
            const user = await getDirectusItem<IUser>('users', userData.id);

            if (!user) {
                return { status: 404, message: 'User not found', cart: [] };
            }

            return { status: 200, cart: user.cart };
        } catch (err) {
            return { status: 401, message: 'Invalid or expired token', cart: [] };
        }
    }
);
