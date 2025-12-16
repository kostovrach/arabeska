import type { IUser } from '~~/interfaces/entities/user';
import type { IPromocode } from '~~/interfaces/entities/promocode';

import { checkUser } from '~~/server/services/checkUser';
import { getDirectusCollection, getDirectusItem } from '~~/server/services/serverCms';

export default defineEventHandler(
    async (
        event
    ): Promise<{
        status: number;
        message?: string;
        success: boolean;
        reason?: string;
        discount?: number;
        requiredAmount?: number;
    }> => {
        const { status, message, data: userData } = checkUser(event);
        if (!userData) {
            return { status, message, success: false };
        }

        const { promocode } = await readBody<{ promocode: IPromocode['name'] }>(event);

        const user = await getDirectusItem<IUser>('users', userData.id);
        if (!user) {
            return { status: 404, message: 'User not found', success: false };
        }

        const promocodeIsUsed = user.used_promocodes?.find(
            (el) => el.trim().toLowerCase() === promocode.trim().toLowerCase()
        );
        if (promocodeIsUsed) {
            return { status: 403, reason: 'Вы уже использовали этот промокод', success: false };
        }

        const promocodes = await getDirectusCollection<IPromocode[]>('promocodes');

        if (!promocodes.length) {
            return {
                status: 404,
                message: 'Promocode not found',
                reason: 'Такого промокода не существует',
                success: false,
            };
        }

        const targetPromocode = promocodes.find(
            (el) => el.name.trim().toLowerCase() === promocode.trim().toLowerCase()
        );

        if (!targetPromocode || !targetPromocode.available) {
            return { status: 400, reason: 'Такого промокода не существует', success: false };
        }

        return {
            status: 200,
            success: true,
            discount: targetPromocode.discount,
            requiredAmount: targetPromocode.required_amount,
        };
    }
);
