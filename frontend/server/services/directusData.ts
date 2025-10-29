// server/services/directusData.ts
import { directus, assetUrl } from './directus';
import { readItems } from '@directus/sdk';

// (файловая детекция и addFileUrls оставляем как есть)
const FILE_NAMES = new Set<string>([
    'video',
    'poster',
    'logo',
    'image',
    'banner_image',
    'image1',
    'image2',
    'image3',
    'image4',
    'image5',
    'image6',
    'image7',
    'image8',
    'image9',
    'file',
    'media',
    'favicon',
    'files',
    'avatar',
    'cover',
    'thumbnail',
    'attachment',
    'poster_image',
    'footer_image',
]);
const UUID_RE = /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;

export function addFileUrls(obj: any): void {
    if (!obj) return;
    const walk = (node: any) => {
        if (!node) return;
        if (Array.isArray(node)) return node.forEach(walk);
        if (typeof node !== 'object') return;
        for (const [k, v] of Object.entries(node)) {
            if (typeof v === 'string' && UUID_RE.test(v) && (FILE_NAMES.has(k) || k.includes('image'))) {
                if (!node[`${k}_url`]) node[`${k}_url`] = assetUrl(v);
            } else if (v && typeof v === 'object') {
                walk(v);
            }
        }
    };
    walk(obj);
}

/* ---------- normalizer: single entry point ---------- */
/**
 * Возвращает:
 * - массив (если Directus вернул массив или { data: [...] })
 * - объект (если Directus вернул объект или { data: { ... } })
 * - null/[] при отсутствии
 */
export function normalizeCollectionResponse(res: any): any | any[] | null {
    if (res == null) return null;

    // Если Directus вернул "сырой" массив
    if (Array.isArray(res)) return res;

    // Если у нас объект с data
    if (res && typeof res === 'object' && 'data' in res) {
        const d = res.data;
        if (Array.isArray(d)) return d;
        if (d && typeof d === 'object') return d;
        return null;
    }

    // Если Directus вернул одиночный объект (singleton)
    if (res && typeof res === 'object') return res;

    return null;
}

/* ---------- memory cache (server) ---------- */
type MemRec = { data: any; ts: number };
const memoryCache = new Map<string, MemRec>();
export function memGet(key: string, ttl?: number) {
    const rec = memoryCache.get(key);
    if (!rec) return null;
    if (ttl && Date.now() - rec.ts > ttl) {
        memoryCache.delete(key);
        return null;
    }
    return rec.data;
}
export function memSet(key: string, data: any) {
    memoryCache.set(key, { data, ts: Date.now() });
}
export function clearMemoryCache(prefix?: string) {
    if (!prefix) {
        memoryCache.clear();
        return;
    }
    for (const k of Array.from(memoryCache.keys())) if (k.startsWith(prefix)) memoryCache.delete(k);
}

/* ---------- helpers ---------- */
function buildItemKey(collection: string, params: Record<string, any> = {}) {
    return `item:${collection}:${JSON.stringify(params || {})}`;
}
function buildListKey(collection: string, params: Record<string, any> = {}) {
    return `list:${collection}:${JSON.stringify(params || {})}`;
}
function buildParams({
    fields,
    filter,
    sort,
    limit,
}: {
    fields?: any;
    filter?: any;
    sort?: any;
    limit?: any;
}) {
    const params: Record<string, any> = {};
    if (fields) params.fields = fields;
    if (filter) params.filter = filter;
    if (sort) params.sort = sort;
    if (limit !== undefined) params.limit = limit;
    return params;
}

/* ---------- fetchCollection: универсальная функция ---------- */
/**
 * Возвращает либо массив (коллекция), либо объект (singleton), либо null.
 */
export async function fetchCollection(
    collection: string,
    params: { fields?: any; filter?: any; sort?: any; limit?: any } = {},
    opts: { force?: boolean; memoryTtl?: number; resolveFiles?: boolean } = {}
): Promise<any /* object | any[] | null */> {
    const fields = params.fields ?? ['*'];
    const key = buildListKey(collection, {
        fields,
        filter: params.filter,
        sort: params.sort,
        limit: params.limit,
    });

    if (!opts.force) {
        const cached = memGet(key, opts.memoryTtl);
        if (cached !== null) return cached;
    }

    try {
        const query = buildParams({
            fields,
            filter: params.filter,
            sort: params.sort,
            limit: params.limit,
        });
        const res = await directus.request(readItems(collection, query));

        const normalized = normalizeCollectionResponse(res);

        if (Array.isArray(normalized)) {
            if (opts.resolveFiles !== false) normalized.forEach(addFileUrls);
            memSet(key, normalized);
            return normalized;
        }
        if (normalized && typeof normalized === 'object') {
            if (opts.resolveFiles !== false) addFileUrls(normalized);
            memSet(key, normalized);
            return normalized;
        }

        memSet(key, null);
        return null;
    } catch (err) {
        console.error('[directusData] fetchCollection error', err);
        throw err;
    }
}

/* ---------- fetchItem (оставляем для pageRepository) ---------- */
export async function fetchItem(
    collection: string,
    params: { fields?: any; filter?: any; sort?: any; relations?: any; limit?: number } = {},
    opts: { force?: boolean; memoryTtl?: number; resolveFiles?: boolean } = {}
): Promise<any | null> {
    // поведение: возвращаем одиночный объект или null
    const fields = params.fields ?? ['*', ...(params.relations ?? [])];
    const limit = params.limit ?? 1;
    const key = buildItemKey(collection, {
        fields,
        filter: params.filter,
        sort: params.sort,
        limit,
    });

    if (!opts.force) {
        const cached = memGet(key, opts.memoryTtl);
        if (cached !== null) return cached;
    }

    try {
        const query = buildParams({ fields, filter: params.filter, sort: params.sort, limit });
        const res = await directus.request(readItems(collection, query));
        // Если Directus вернул массив, берем первый элемент; если объект — возвращаем его
        const normalized = normalizeCollectionResponse(res);
        if (Array.isArray(normalized)) {
            const v = normalized[0] ?? null;
            if (v && opts.resolveFiles !== false) addFileUrls(v);
            memSet(key, v);
            return v;
        }
        if (normalized && typeof normalized === 'object') {
            if (opts.resolveFiles !== false) addFileUrls(normalized);
            memSet(key, normalized);
            return normalized;
        }
        memSet(key, null);
        return null;
    } catch (err) {
        console.error('[directusData] fetchItem error', err);
        throw err;
    }
}
