import jwt from 'jsonwebtoken';
import { getDirectusItem } from '~~/server/services/serverCms';

import type { IUser } from '~~/interfaces/entities/user';
import type { IJwtPayload } from '~~/interfaces/jwt-payload';

const config = useRuntimeConfig();
const secret = config.jwt.secret;

export default defineEventHandler(
    async (
        event
    ): Promise<{ status: number; success: boolean; message?: string; user: IUser | null }> => {
        const token = getCookie(event, 'authorization');

        if (!token) return { status: 401, message: 'Unauthorized', user: null, success: false };

        try {
            const decoded = jwt.verify(token, secret) as IJwtPayload;
            const user = await getDirectusItem<IUser>('users', decoded.id);

            if (!user) {
                return { status: 404, message: 'User not found', user: null, success: false };
            }

            return { status: 200, user, success: true };
        } catch (err) {
            console.error(err);
            return { status: 401, message: 'Invalid or expired token', user: null, success: false };
        }
    }
);
