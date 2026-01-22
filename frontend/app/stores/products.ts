/* eslint-disable @typescript-eslint/no-explicit-any */

import type { IProduct } from '~~/interfaces/entities/product';

export const useProductsStore = defineStore('products', () => {
    // State===============================================
    const products = ref<IProduct[]>([]);
    const filteredProducts = ref<IProduct[]>([]);

    // Helpers
    const { search } = useFuseSearch<IProduct>({
        keys: [
            'id',
            'title',
            'description',
            'category.categories_id.name',
            'reason.reason_id.name',
            'style.styles_id.name',
            'structure.structure_id.name',
        ],
        threshold: 0.35,
        ignoreLocation: true,
        includeScore: false,
    });

    // Actions=============================================
    function setProducts(data: IProduct[]) {
        products.value = data;
    }

    /**@deprecated лучше напрямую использовать useCmsItem */
    function getProductById(id: IProduct['id']): IProduct | null {
        const result = products.value.find((el) => el.id === id);

        return result ?? null;
    }

    async function searchProducts(query: string) {
        const doSearch = useDebounceFn(async () => {
            const result = await search(query, products.value);

            return result;
        }, 300);

        filteredProducts.value = await doSearch();
    }

    return { products, filteredProducts, setProducts, getProductById, searchProducts };
});
