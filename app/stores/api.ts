type FetchOptions = {
    params?: Record<string, any>;
    lazy?: boolean;
    immediate?: boolean;
    body?: any;
    method?: string;
    headers?: Record<string, string>;
};

export const useApiStore = defineStore('api', () => {
    const apiBase = useRuntimeConfig().public.apiBase;

    // Словарь кэшированных запросов
    const cache = reactive<Record<string, ReturnType<typeof useFetch<any>>>>({});

    function stableKey(endpoint: string, options?: FetchOptions) {
        const sortedParams = options?.params ? Object.fromEntries(Object.entries(options.params).sort()) : {};
        const sortedOptions = { ...options, params: sortedParams };
        return `${endpoint}-${JSON.stringify(sortedOptions)}`;
    }

    function fetchData<T = any>(endpoint: string, options?: FetchOptions) {
        const key = stableKey(endpoint, options);

        if (!cache[key]) {
            cache[key] = useFetch<T>(() => `${apiBase}${endpoint}`, {
                key,
                params: options?.params,
                method: options?.method as any,
                body: options?.body,
                headers: options?.headers,
            });
        }

        return cache[key] as ReturnType<typeof useFetch<T>>;
    }

    async function getById<T = any>(endpoint: string, id: string | number) {
        return await useFetch<T>(`${apiBase}${endpoint}/${id}`, {
            key: `${endpoint}-${id}`,
            lazy: true,
        });
    }

    return { fetchData, getById };
});
