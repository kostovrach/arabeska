import { defineHandler } from 'h3';
import type { IDatabase } from '~~/interfaces/database';
import dbData from '../../data/db.json';

const db = dbData as IDatabase;

export default defineHandler((event) => {
    const params = (event as any).context?.params || {};
    const endpoint = params.endpoint as keyof IDatabase | undefined;

    if (!endpoint || !(endpoint in db)) {
        event.res.status = 404;
        event.res.statusText = `Endpoint '${String(endpoint) ?? 'undefined'}' not found`;
        return;
    }

    return db[endpoint];
});
