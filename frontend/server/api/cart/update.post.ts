import { checkUser } from '~~/server/services/checkUser';
import { getDirectusItem, updateDirectusItem } from '~~/server/services/serverCms';

import type { ICartItem } from '~~/interfaces/entities/cart-item';
import type { IUser } from '~~/interfaces/entities/user';

export default defineEventHandler(
    async (event): Promise<{ status: number; message?: string; success: boolean }> => {
        const { status, message, data: userData } = checkUser(event);
        if (!userData) return { status, message, success: false };

        const { product_id, modifier, quantity } = await readBody<ICartItem>(event);
        if (!product_id || !modifier)
            return { status: 400, message: 'Invalid parameters', success: false };

        try {
            const user = await getDirectusItem<IUser>('users', userData.id);
            if (!user) return { status: 404, message: 'User not found', success: false };

            const cart = user.cart;
            const key = cartKeyBuilder([product_id, modifier]);
            const existingIdx = cart.findIndex(
                (el) => cartKeyBuilder([el.product_id, el.modifier]) === key
            );

            if (existingIdx !== -1) {
                cart[existingIdx]!.quantity = quantity;
                const res = await updateDirectusItem<IUser>('users', userData.id, { cart });

                if (res) {
                    return { status: 200, success: true };
                } else return { status: 500, message: 'Server error', success: false };
            } else return { status: 404, message: 'Item not found in user cart', success: false };
        } catch (err) {
            return { status: 500, message: `${err}`, success: false };
        }
    }
);
