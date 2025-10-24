import { eventHandler } from 'h3';
import type { IDatabase } from '~~/interfaces/database';
import dbData from '../../data/db.json';

const db = dbData as unknown as IDatabase;

export default eventHandler((event) => {
    const params = (event as any).context?.params || {};
    const endpoint = params.endpoint as keyof IDatabase | undefined;
    const id = params.id as string | undefined;

    if (!endpoint || !(endpoint in db)) {
        event.res.status = 404;
        event.res.statusText = `Endpoint '${String(endpoint) ?? 'undefined'}' not found`;
        return { error: true, message: `Endpoint '${String(endpoint) ?? 'undefined'}' not found` };
    }

    const collection = db[endpoint] as unknown as { id: string }[];
    if (!id) {
        event.res.status = 400;
        event.res.statusText = `Missing id param`;
        return { error: true, message: 'Missing id param' };
    }

    const item = collection.find((e) => e.id === id);

    if (!item) {
        event.res.status = 404;
        event.res.statusText = `Item with id '${id}' not found`;
        return { error: true, message: `Item with id '${id}' not found` };
    }

    return item;
});
