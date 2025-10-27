export function useDirectusItem<T = any>(
    collection: string,
    id: string | number,
    params: Record<string, any> = {},
    options: { server?: boolean; key?: string } = {}
): {
    data: Ref<T | null>;
    pending: Ref<boolean>;
    error: Ref<any>;
    refresh: () => Promise<void>;
} {
    const key = options.key ?? `directus:item:${collection}:${id}:${JSON.stringify(params)}`;
    const { data, pending, error, refresh } = useFetch<T>(`/api/directus/${collection}/${id}`, {
        key,
        query: params,
        server: options.server ?? true,
    });

    return { data: data as Ref<T | null>, pending, error, refresh };
}
