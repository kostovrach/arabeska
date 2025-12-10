import type { IJwtPayload } from '~~/interfaces/jwt-payload';
import type { H3Event, EventHandlerRequest } from 'h3';
import jwt from 'jsonwebtoken';

const config = useRuntimeConfig();
const secret = config.jwt.secret;

export function checkUser(event: H3Event<EventHandlerRequest>): {
    status: number;
    message?: string;
    data: IJwtPayload | null;
} {
    const token = getCookie(event, 'authorization');

    if (!token) return { status: 401, message: 'Unauthorized', data: null };

    const decoded = jwt.verify(token, secret) as IJwtPayload;

    return { status: 200, data: decoded };
}
