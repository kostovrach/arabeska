// app/composables/useCms.ts

export function useCms<T = any>(
    collection: string,
    withRelations: string[] = [],
    opts: { resolveFiles?: boolean; force?: boolean; key?: string; cacheTtl?: number } = {}
) {
    const key = opts.key ?? `cms:${collection}:${JSON.stringify(withRelations)}`;
    const query = {
        relations: withRelations.join(','),
        resolveFiles: opts.resolveFiles ?? true,
    };

    const { data, pending, error, refresh } = useFetch<{ data: T }>(`/api/cms/${collection}`, {
        key,
        query,
        server: true,
        lazy: false,
        getCachedData(k, nuxtApp) {
            return nuxtApp.payload.data?.[k];
        },
        immediate: !opts.force,
    });

    return {
        content: computed(() => data.value?.data ?? null),
        pending,
        error: computed(() => error.value ?? null),
        refresh,
    };
}
