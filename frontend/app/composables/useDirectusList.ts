export function useDirectusList<T = any>(
    collection: string,
    params: Record<string, any> = {},
    options: { server?: boolean; key?: string; transform?: (v: any) => T[] } = {}
): {
    data: Ref<T[] | null>;
    pending: Ref<boolean>;
    error: Ref<any>;
    refresh: () => Promise<void>;
} {
    const key = options.key ?? `directus:list:${collection}:${JSON.stringify(params)}`;
    const { data, pending, error, refresh } = useFetch<{ data: T[]; meta?: any }>(
        `/api/directus/${collection}`,
        {
            key,
            query: params,
            server: options.server ?? true,
        }
    );

    // expose front-end friendly value: data.data -> T[]
    const wrappedData = computed(() => {
        if (!data.value) return null;
        if (!data.value.data) return data.value as unknown as T[]; // fallback
        return options.transform ? options.transform(data.value.data) : (data.value.data as T[]);
    });

    return {
        data: wrappedData as Ref<T[] | null>,
        pending,
        error,
        refresh,
    };
}
