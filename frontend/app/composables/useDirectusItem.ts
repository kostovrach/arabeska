import { useFetch } from '#app';

interface UseDirectusItemOptions {
    /**
     * Ключ кэша для useAsyncData/useFetch
     */
    key?: string;
    /**
     * Время жизни кэша в секундах (по умолчанию 60)
     */
    cacheTtl?: number;
    /**
     * Явно форсировать повторный запрос (игнорировать кэш useFetch)
     */
    force?: boolean;
}

interface UseDirectusResult<T> {
    data: Ref<T | null>;
    pending: Ref<boolean>;
    error: Ref<Error | null>;
    refresh: () => Promise<void>;
}

/**
 * Универсальный composable для запроса к серверному API `/api/cms/items`
 */
export function useDirectusItem<T = any>(
    collection: string,
    params: Record<string, any>,
    opts: UseDirectusItemOptions = {}
): UseDirectusResult<T> {
    const key = opts.key ?? JSON.stringify(params);

    const { data, pending, error, refresh } = useFetch<{ data: T }>(`/api/cms/${collection}`, {
        key,
        query: params,
        server: true,
        lazy: false,
        getCachedData(key, nuxtApp) {
            return nuxtApp.payload.data[key];
        },
        immediate: !opts.force,
    });

    return {
        data: computed(() => data.value?.data ?? null),
        pending,
        error: computed(() => (error.value ? (error.value as Error) : null)),
        refresh,
    };
}
