import { getDirectus } from '~~/server/lib/directus';
import { buildFields } from '~~/server/lib/fieldsBuilder';
import { addFileUrls } from '~~/server/lib/files';
import { cacheGet, cacheSet } from '~~/server/lib/cache';

export default defineEventHandler(async (event) => {
    const params = getRouterParams(event) as { collection?: string; id?: string };
    const collection = String(params.collection || '');
    const idRaw = params.id;
    if (!idRaw) {
        event.res.status = 400;
        event.res.statusText = 'Missing id';
        throw new Error();
    }

    const q = getQuery(event);
    const ttl = Number(q.ttl ?? 300);

    // fields parsing as in list endpoint
    let fieldsCsv: string | undefined;
    if (q.fields) {
        const raw = String(q.fields);
        try {
            const parsed = JSON.parse(raw);
            if (Array.isArray(parsed)) fieldsCsv = buildFields(parsed, 3);
            else fieldsCsv = raw;
        } catch {
            fieldsCsv = raw;
        }
    }

    const directusParams: any = {};
    if (fieldsCsv) directusParams.fields = fieldsCsv;

    const cacheKey = `directus:item:${collection}:${idRaw}:${JSON.stringify(directusParams)}`;
    const cached = cacheGet(cacheKey, ttl);
    if (cached) return cached;

    try {
        const sdk = getDirectus();
        // Попробуем использовать readItem, иначе fallback на readItems + filter.
        let result: any;
        try {
            // readItem обычно ожидает корректный id (число/uuid). Если Directus не найдёт — может вернуть null.
            result = await sdk.request(
                (await import('@directus/sdk')).readItem(
                    collection as any,
                    idRaw as any,
                    directusParams
                )
            );
        } catch (e) {
            // fallback: readItems with filter _eq
            const res2: any = await sdk.request(
                (await import('@directus/sdk')).readItems(collection as any, {
                    filter: { id: { _eq: idRaw } },
                    ...directusParams,
                })
            );
            if (Array.isArray(res2)) result = res2[0] ?? null;
            else if (res2 && Array.isArray(res2.data)) result = res2.data[0] ?? null;
            else result = null;
        }

        if (!result) {
            event.res.status = 404;
            event.res.statusText = 'Not found';
            throw new Error();
        }
        addFileUrls(result, 5);
        cacheSet(cacheKey, result);
        return result;
    } catch (err: any) {
        console.error('directus item fetch error', err);
        if (err.statusCode && err.message) throw err;
        event.res.status = 500;
        event.res.statusText = 'Failed to fetch Directus item';
    }
});
