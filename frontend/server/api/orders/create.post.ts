import type { IOrder } from '~~/interfaces/entities/order';
import type { IPromocode } from '~~/interfaces/entities/promocode';
import type { IUser } from '~~/interfaces/entities/user';

import { checkUser } from '~~/server/services/checkUser';
import {
    createDirectusItem,
    getDirectusItem,
    updateDirectusItem,
} from '~~/server/services/serverCms';

export default defineEventHandler(
    async (event): Promise<{ status: number; message?: string; success: boolean }> => {
        const { status, message, data: userData } = checkUser(event);
        if (!userData) {
            return { status, message, success: false };
        }

        const { order, promocode } = await readBody<{
            order: Omit<IOrder, 'id' | 'date_created' | 'date_updated'>;
            promocode?: IPromocode['name'];
        }>(event);

        const user = await getDirectusItem<IUser>('users', userData.id);
        if (!user) {
            return { status: 404, message: 'Ошибка: пользователь не найден', success: false };
        }

        try {
            const createOrder = await createDirectusItem<IOrder>('orders', { ...order });
            if (!createOrder) {
                return {
                    status: 500,
                    message: 'Произошла непредвиденная ошибка, попробуйте повторить попытку позже',
                    success: false,
                };
            }
        } catch {
            return {
                status: 500,
                message: 'Произошла непредвиденная ошибка, попробуйте повторить попытку позже',
                success: false,
            };
        }

        if (promocode) {
            const updateUser = await updateDirectusItem<IUser>('users', userData.id, {
                used_promocodes: user.used_promocodes
                    ? [...user.used_promocodes, promocode]
                    : [promocode],
            });
            if (!updateUser) {
                return {
                    status: 500,
                    message: 'Произошла непредвиденная ошибка, попробуйте повторить попытку позже',
                    success: false,
                };
            }
        }

        return { status: 200, success: true };
    }
);
