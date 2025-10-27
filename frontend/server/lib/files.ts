import { useRuntimeConfig } from '#imports';

const FILE_LIKE_KEYS = new Set([
    'video',
    'poster',
    'logo',
    'image',
    'image1',
    'image2',
    'file',
    'files',
    'media',
    'avatar',
    'cover',
    'thumbnail',
]);

const UUID_RE =
    /^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$/;
const SIMPLE_ID_RE = /^[0-9]+$/;

export function assetUrl(id?: string | number | null) {
    if (!id) return null;
    const base: string = useRuntimeConfig().directus.url.replace(/\/$/, '');
    return `${base}/assets/${id}`;
}

export function addFileUrls<T extends Record<string, any>>(obj: T, maxDepth = 5): T {
    if (!obj || typeof obj !== 'object') return obj;
    const seen = new WeakSet();

    const walk = (node: any, depth = 0) => {
        if (!node || typeof node !== 'object') return;
        if (depth > maxDepth) return;
        if (seen.has(node)) return;
        seen.add(node);

        if (Array.isArray(node)) {
            node.forEach((n) => walk(n, depth + 1));
            return;
        }

        for (const [k, v] of Object.entries(node)) {
            if (!v) continue;
            // if it's a file-like object (has id and filename or type)
            if (
                v &&
                typeof v === 'object' &&
                'id' in v &&
                ('filename_download' in v || 'type' in v)
            ) {
                if (!node[`${k}_url`]) node[`${k}_url`] = assetUrl((v as any).id);
            } else if (typeof v === 'string' || typeof v === 'number') {
                // string/number maybe uuid or id and key name indicates file
                if (
                    FILE_LIKE_KEYS.has(k) &&
                    (UUID_RE.test(String(v)) || SIMPLE_ID_RE.test(String(v)))
                ) {
                    if (!node[`${k}_url`]) node[`${k}_url`] = assetUrl(v);
                }
            } else if (typeof v === 'object') {
                walk(v, depth + 1);
            }
        }
    };

    walk(obj, 0);
    return obj;
}
