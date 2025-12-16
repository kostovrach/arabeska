import type { IUser } from '~~/interfaces/entities/user';
import { updateDirectusItem } from '~~/server/services/serverCms';

export default defineEventHandler(
    async (event): Promise<{ status: number; message?: string; success: boolean }> => {
        const payload = await readBody<Partial<IUser>>(event);

        try {
            const res = await updateDirectusItem<IUser>('users', payload.id!, payload);

            if (res) {
                return { status: 200, success: true };
            } else {
                return { status: 500, success: false };
            }
        } catch (err) {
            return { status: 500, success: false };
        }
    }
);
