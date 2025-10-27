import { getQuery, getRouterParams } from 'h3';
import { getDirectus } from '~~/server/lib/directus';
import { buildFields } from '~~/server/lib/fieldsBuilder';
import { addFileUrls } from '~~/server/lib/files';
import { cacheGet, cacheSet } from '~~/server/lib/cache';

export default defineEventHandler(async (event) => {
    const params = getRouterParams(event) as { collection?: string };
    const collection = String(params.collection || '');
    const q = getQuery(event);

    // parse TTL (seconds), default 300
    const ttl = Number(q.ttl ?? 300);

    // parse fields: accept JSON array or CSV string
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

    const limit = q.limit ? Number(q.limit) : undefined;
    const page = q.page ? Number(q.page) : undefined;
    const sort = q.sort ? String(q.sort) : undefined;
    const filter = q.filter
        ? (() => {
              try {
                  return JSON.parse(String(q.filter));
              } catch {
                  return undefined;
              }
          })()
        : undefined;

    const directusParams: Record<string, any> = {};
    if (fieldsCsv) directusParams.fields = fieldsCsv;
    if (limit !== undefined) directusParams.limit = limit;
    if (page !== undefined) directusParams.page = page;
    if (sort) directusParams.sort = sort;
    if (filter) directusParams.filter = filter;

    const cacheKey = `directus:list:${collection}:${JSON.stringify(directusParams)}`;
    const cached = cacheGet(cacheKey, ttl);
    if (cached) return cached;

    try {
        const sdk = getDirectus();
        // readItems may return array or { data, meta }
        const res: any = await sdk.request(
            (await import('@directus/sdk')).readItems(collection as any, directusParams)
        );

        let data: any[] = [];
        let meta: any = undefined;

        if (Array.isArray(res)) data = res;
        else if (res && Array.isArray(res.data)) {
            data = res.data;
            meta = res.meta ?? undefined;
        } else if (res && typeof res === 'object' && Array.isArray((res as any).data)) {
            data = (res as any).data;
            meta = (res as any).meta;
        } else {
            data = Array.isArray(res) ? res : [];
        }

        // Add file URLs to all items (deep scan up to default depth in addFileUrls)
        data.forEach((it) => addFileUrls(it, 5));

        const payload = { data, meta };
        cacheSet(cacheKey, payload);
        return payload;
    } catch (err: any) {
        event.res.status = 500;
        event.res.statusText = err;
        throw new Error(err);
    }
});
