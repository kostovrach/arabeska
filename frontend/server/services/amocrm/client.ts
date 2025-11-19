import { Client } from 'amocrm-js';

const config = useRuntimeConfig();

export const amoClient = new Client({
    domain: config.amo.domain,
    auth: {
        client_id: config.amo.clientId,
        client_secret: config.amo.clientSecret,
        redirect_uri: config.amo.redirectUri,
        bearer: config.amo.bearer,
    },
});

const connectionPromise = amoClient.connection
    .connect()
    .then(() => {
        amoLog('connection:established');
    })
    .catch((error) => {
        console.error('Failed to connect to AmoCRM', error);
        throw error;
    });

export async function ensureConnected() {
    await connectionPromise;
}
