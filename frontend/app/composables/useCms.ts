import { useDirectusItem } from './useDirectusItem';

interface UsePageOptions {
    resolveFiles?: boolean;
    force?: boolean;
    cacheTtl?: number;
}

export function useCms<T = any>(
    collection: string,
    withRelations: string[] = [],
    opts: UsePageOptions = {}
) {
    const query = {
        relations: withRelations.join(','),
        resolveFiles: opts.resolveFiles ?? true,
    };

    const { data, pending, error, refresh } = useDirectusItem<T>(collection, query, {
        key: `page:${collection}`,
        cacheTtl: opts.cacheTtl,
        force: opts.force,
    });

    return {
        content: data,
        pending,
        error,
        refresh,
    };
}
