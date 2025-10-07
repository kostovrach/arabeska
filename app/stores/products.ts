import type { AsyncData, AsyncDataOptions, AsyncDataRequestStatus } from '#app';
import type { IProduct } from '~/interfaces/product';

export const useProductsStore = defineStore('products', () => {
    const apiBase = useRuntimeConfig().public.apiBase;

    // State===============================================
    const productsList = useState<IProduct[] | null>('productsList', () => null);
    const productsItem = useState<IProduct | null>('productsItem', () => ({}) as IProduct);
    const productsStatus = useState<AsyncDataRequestStatus>('productsStatus', () => 'idle');
    const singleProductStatus = useState<AsyncDataRequestStatus>(
        'singleProductStatus',
        () => 'idle'
    );

    // Actions=============================================
    async function getProducts(opt?: AsyncDataOptions<IProduct[]>) {
        const { data, status } = useLazyFetch<IProduct[]>(`${apiBase}/products`, {
            key: 'products',
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
            const { data, status } = useLazyFetch<IProduct>(`${apiBase}/products/${id}`, {
                key: `product-${id}`,
                ...opt,
            }) as AsyncData<IProduct, Error>;

            watchEffect(() => {
                singleProductStatus.value = status.value;
                if (data.value) productsItem.value = data.value;
            });
        } else return;
    }

    return {
        productsList,
        productsItem,
        productsStatus,
        singleProductStatus,
        getProducts,
        getProductById,
    };
});
