import type { AsyncData, AsyncDataOptions, AsyncDataRequestStatus } from '#app';
import type { IProduct } from '~/interfaces/product';

export const useProductsStore = defineStore('products', () => {
    const apiBase = useRuntimeConfig().public.apiBase;

    // State===============================================
    const productsList = useState<IProduct[] | null>('productsList', () => null);
    const productsItem = useState<IProduct | null>('productsItem', () => ({}) as IProduct);
    const productsStatus = useState<AsyncDataRequestStatus>('productsStatus', () => 'idle');

    // Actions=============================================
    async function getProducts(opt?: AsyncDataOptions<IProduct[]>) {
        const { data, status } = (useLazyFetch<IProduct[]>(`${apiBase}/products`, {
            key: 'products',
            ...opt,
        })) as AsyncData<IProduct[], Error>;

        productsList.value = data.value ?? [];
        productsStatus.value = status.value;
        
    }

    return { productsList, productsItem, productsStatus, getProducts };
});
