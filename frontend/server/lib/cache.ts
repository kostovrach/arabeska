type CacheRecord<T> = { data: T; ts: number };

const memoryCache = new Map<string, CacheRecord<any>>();

export function cacheGet<T>(key: string, ttlSeconds?: number): T | null {
    const rec = memoryCache.get(key);
    if (!rec) return null;
    if (ttlSeconds && Date.now() - rec.ts > ttlSeconds * 1000) {
        memoryCache.delete(key);
        return null;
    }
    return rec.data as T;
}

export function cacheSet<T>(key: string, data: T) {
    memoryCache.set(key, { data, ts: Date.now() });
}

export function cacheClearPrefix(prefix?: string) {
    if (!prefix) {
        memoryCache.clear();
        return;
    }
    for (const k of Array.from(memoryCache.keys())) {
        if (k.startsWith(prefix)) memoryCache.delete(k);
    }
}
