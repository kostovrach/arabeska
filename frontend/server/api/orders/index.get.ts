import type { IOrder } from '~~/interfaces/entities/order';
import type { IUser } from '~~/interfaces/entities/user';
import { checkUser } from '~~/server/services/checkUser';
import { getDirectusCollection, getDirectusItem } from '~~/server/services/serverCms';

export default defineEventHandler(
    async (
        event
    ): Promise<{
        status: number;
        message?: string;
        success: boolean;
        orders: Omit<IOrder[], 'payment_method' | 'postcard' | 'comment'>;
    }> => {
        const { status, message, data: userData } = checkUser(event);
        if (!userData) {
            return { status, message, success: false, orders: [] };
        }

        try {
            const user = await getDirectusItem<IUser>('users', userData.id);
            if (!user)
                return { status: 404, message: 'Пользователь не найден', success: false, orders: [] };

            const orders = await getDirectusCollection<IOrder[]>('orders', {
                filter: { user_id: { _eq: user.id } },
            });
            if (!orders.length)
                return { status: 404, message: 'У данного пользователя отсутствуют заказы', success: false, orders: [] };

            return { status: 200, success: true, orders };
        } catch (err) {
            return { status: 500, message: `${err}`, success: false, orders: [] };
        }
    }
);
