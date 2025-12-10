import type { ICartItem } from '~~/interfaces/entities/cart-item';
import type { IUser } from '~~/interfaces/entities/user';

import { checkUser } from '~~/server/services/checkUser';
import { getDirectusItem, updateDirectusItem } from '~~/server/services/serverCms';
import { cartKeyBuilder } from '~~/server/utils/cartKeyBuilder';

export default defineEventHandler(
    async (event): Promise<{ status: number; message?: string; success: boolean }> => {
        const { status, message, data: userData } = checkUser(event);

        if (!userData) return { status, message, success: false };

        const newItem = await readBody<ICartItem>(event);
        const user = await getDirectusItem<IUser>('users', userData.id);
        const cart = user?.cart ?? [];

        const key = cartKeyBuilder([newItem.product_id, newItem.modifier]);
        const existingIdx = cart.findIndex(
            (el) => cartKeyBuilder([el.product_id, el.modifier]) === key
        );

        if (existingIdx > -1) {
            cart[existingIdx].quantity =
                Number(cart[existingIdx].quantity) + Number(newItem.quantity);
        } else {
            cart.push({ ...newItem, quantity: Number(newItem.quantity) });
        }

        const res = await updateDirectusItem<IUser>('users', userData.id, { cart });

        if (res) {
            return { status: 200, success: true };
        } else return { status: 500, success: false };
    }
);
