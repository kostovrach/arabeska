// server/services/directusData.ts
import { directus, assetUrl } from './directus';
import { readItems } from '@directus/sdk';

// ---------- file detection ----------
const FILE_NAMES = new Set<string>([
    'video',
    'poster',
    'logo',
    'image',
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

function addFileUrls(obj: any): void {
    if (!obj) return;

    const walk = (node: any) => {
        if (!node) return;
        if (Array.isArray(node)) {
            node.forEach(walk);
            return;
        }
        if (typeof node !== 'object') return;

        for (const [k, v] of Object.entries(node)) {
            if (typeof v === 'string' && UUID_RE.test(v) && FILE_NAMES.has(k)) {
                if (!node[`${k}_url`]) node[`${k}_url`] = assetUrl(v);
            } else if (v && typeof v === 'object') {
                walk(v);
            }
        }
    };

    walk(obj);
}

// ---------- normalizers ----------
export function normalizeSingleResponse(res: any): any | null {
    if (res == null) return null;
    // directus readItems may return an array, or object { data: [...] }, or single object
    if (Array.isArray(res)) return res[0] ?? null;
    if (res && Array.isArray((res as any).data)) return (res as any).data[0] ?? null;
    if (res && typeof res === 'object') return res;
    return null;
}

export function normalizeListResponse(res: any): any[] {
    if (!res) return [];

    // Если res уже массив
    if (Array.isArray(res)) return res;

    // Если res объект с ключами, превращаем в массив значений
    if (typeof res === 'object') return [res]; // <-- оборачиваем одиночный объект в массив

    return [];
}
export function normalizeCollectionResponse(res: any): any | any[] {
    if (res == null) return [];

    // Если Directus вернул массив напрямую
    if (Array.isArray(res)) return res;

    // Если есть res.data
    if (res && typeof res === 'object' && 'data' in res) {
        const d = (res as any).data;
        if (Array.isArray(d)) return d; // обычная коллекция
        if (d && typeof d === 'object') return d; // singleton внутри data -> вернуть объект
        return [];
    }

    // Если res сам по себе — объект: считаем singleton и возвращаем объект
    if (typeof res === 'object') return res;

    // fallback
    return [];
}

// ---------- memory cache ----------
type MemRec = { data: any; ts: number };
const memoryCache = new Map<string, MemRec>();

export function memGet(key: string, ttl?: number): any | null {
    const rec = memoryCache.get(key);
    if (!rec) return null;
    if (ttl && Date.now() - rec.ts > ttl) {
        memoryCache.delete(key);
        return null;
    }
    return rec.data;
}

export function memSet(key: string, data: any): void {
    memoryCache.set(key, { data, ts: Date.now() });
}

export function clearMemoryCache(prefix?: string): void {
    if (!prefix) {
        memoryCache.clear();
        return;
    }
    for (const k of Array.from(memoryCache.keys())) {
        if (k.startsWith(prefix)) memoryCache.delete(k);
    }
}

// ---------- key builders ----------
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

// ---------- fetch functions ----------
export async function fetchItem(
    collection: string,
    params: { fields?: any; filter?: any; sort?: any; relations?: any; limit?: number } = {},
    opts: { force?: boolean; memoryTtl?: number; resolveFiles?: boolean } = {}
): Promise<any | null> {
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

        const data = normalizeSingleResponse(res);
        if (data && opts.resolveFiles !== false) addFileUrls(data);

        memSet(key, data);
        return data;
    } catch (err) {
        console.error('[directusData] fetchItem error', err);
        throw err;
    }
}

export async function fetchList(
    collection: string,
    params: { fields?: any; filter?: any; sort?: any; limit?: any } = {},
    opts: {
        force?: boolean;
        memoryTtl?: number;
        resolveFiles?: boolean;
        persist?: boolean;
        persistTtl?: number;
    } = {}
): Promise<any /* either any[] or any (object) */> {
    const fields = params.fields ?? ['*'];
    const key = buildListKey(collection, {
        fields,
        filter: params.filter,
        sort: params.sort,
        limit: params.limit,
    });

    if (!opts.force) {
        const m = memGet(key, opts.memoryTtl);
        if (m) return m;
    }

    try {
        const query = buildParams({
            fields,
            filter: params.filter,
            sort: params.sort,
            limit: params.limit,
        });
        const res = await directus.request(readItems(collection, query));

        // Нормализуем — может вернуть массив или объект
        const normalized = normalizeCollectionResponse(res);

        // Если нормализованный результат — массив, применяем addFileUrls к каждому элементу
        if (Array.isArray(normalized)) {
            if (normalized && opts.resolveFiles !== false) normalized.forEach(addFileUrls);
            memSet(key, normalized);
            return normalized;
        }

        // Если нормализованный результат — объект (singleton)
        if (normalized && typeof normalized === 'object') {
            if (opts.resolveFiles !== false) addFileUrls(normalized);
            memSet(key, normalized);
            return normalized;
        }

        // fallback: пустой массив
        const empty: any[] = [];
        memSet(key, empty);
        return empty;
    } catch (err) {
        console.error('[directusData] fetchList error', err);
        throw err;
    }
}
