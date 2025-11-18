import type { IOrder } from '~~/interfaces/entities/order';
import type { IUser } from '~~/interfaces/entities/user';
import { Client } from 'amocrm-js';
import { getDirectusItem } from '~~/server/services/serverCms';

const config = useRuntimeConfig();

const client = new Client({
    domain: config.amo.domain,
    auth: {
        client_id: config.amo.clientId,
        client_secret: config.amo.clientSecret,
        redirect_uri: config.amo.redirectUri,
        bearer: config.amo.bearer,
    },
});

export default eventHandler(async (event) => {
    const orederData = await readBody<IOrder>(event);

    const user = await getDirectusItem<IUser>('users', orederData.user.id);
    if (!user) throw createError({ statusCode: 400, statusMessage: 'user not found' });

    const phoneDigits = user.telephone.toString().trim().replace(/\s+/g, '');
    let contactId = user.amocrm_contact_id ?? null;
});
