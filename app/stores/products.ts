import type { AsyncData, AsyncDataOptions, AsyncDataRequestStatus } from '#app';
import type { IProduct } from '~/interfaces/product';
import type FuseType from 'fuse.js';

export const useProductsStore = defineStore('products', () => {
    const apiBase = useRuntimeConfig().public.apiBase;

    // State===============================================
    const productsList = useState<IProduct[] | null>('productsList', () => null);
    const productsItem = useState<IProduct | null>('productsItem', () => null);
    const productsStatus = useState<AsyncDataRequestStatus>('productsStatus', () => 'idle');
    const singleProductStatus = useState<AsyncDataRequestStatus>(
        'singleProductStatus',
        () => 'idle'
    );

    // Fussy-search========================================
    const fuse = shallowRef<FuseType<IProduct> | null>(null);
    const fuseOptions: Record<string, any> = {
        keys: ['title', 'description', 'reason', 'style', 'structure.name', 'id'],
        threshold: 0.35,
        ignoreLocation: true,
        includeScore: false,
    };

    async function initFuseIfNeeded(): Promise<void> {
        if (fuse.value) return;
        const list = productsList.value;
        if (!list || !list.length) return;
        const { default: Fuse } = await import('fuse.js');
        fuse.value = new Fuse(list, fuseOptions);
    }

    watch(
        productsList,
        (newList) => {
            if (!newList || !newList.length) {
                fuse.value = null;
                return;
            }
            if (fuse.value) {
                import('fuse.js').then(({ default: Fuse }) => {
                    fuse.value = new Fuse(newList, fuseOptions);
                });
            }
        },
        { immediate: false }
    );

    // Actions=============================================
    async function getProducts(opt?: AsyncDataOptions<IProduct[]>) {
        const { data, status } = useLazyFetch<IProduct[]>(`${apiBase}/products`, {
            key: 'products',
            transform: (products) => products.filter((p) => p.available === true),
            ...opt,
        }) as AsyncData<IProduct[], Error>;

        watchEffect(() => {
            productsStatus.value = status.value;
            if (data.value) productsList.value = data.value;
        });
    }

    async function getProductById(
        id: string | string[] | undefined,
        opt?: AsyncDataOptions<IProduct>
    ) {
        if (typeof id === 'string') {
            const { data, status } = (await useFetch<IProduct>(`${apiBase}/products/${id}`, {
                key: `product-${id}`,
                ...opt,
            })) as AsyncData<IProduct, Error>;

            singleProductStatus.value = status.value;
            productsItem.value = data.value;
        } else {
            singleProductStatus.value = 'error';
        }
    }

    async function searchProductsFuzzy(query: string): Promise<IProduct[]> {
        if (!query.trim()) return [];

        await initFuseIfNeeded();

        if (!fuse.value) return [];

        return fuse.value.search(query).map((r: any) => r.item);
    }

    return {
        productsList,
        productsItem,
        productsStatus,
        singleProductStatus,
        getProducts,
        getProductById,
        searchProductsFuzzy,
    };
});
