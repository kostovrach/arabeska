/* eslint-disable @typescript-eslint/no-explicit-any */

import type { AsyncDataRequestStatus } from '#app';
import type { IProduct } from '~~/interfaces/entities/product';
import type FuseType from 'fuse.js';

export const useProductsStore = defineStore('products', () => {
    const productRelations = [
        'images.*',
        'images.directus_files_id.*',
        'category.*',
        'category.categories_id.*',
        'reason.*',
        'reason.reason_id.*',
        'style.*',
        'style.styles_id.*',
        'structure.*',
        'structure.structure_id.*',
    ];

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
    async function getProducts() {
        const { content: productsRaw, status } = useCms<IProduct[]>('products', productRelations, {
            lazy: true,
        });

        const products = computed(() => productsRaw.value?.filter((el) => el.available === true));

        watchEffect(() => {
            productsStatus.value = status.value;
            if (products.value) productsList.value = products.value;
        });
    }

    /**@deprecated лучше напрямую использовать useCmsItem */
    async function getProductById(id: number | string) {
        if (!id) {
            singleProductStatus.value = 'error';
            return;
        } else {
            const { item: product, status } = useCmsItem<IProduct>(
                'products',
                id,
                productRelations
            );

            watchEffect(() => {
                singleProductStatus.value = status.value;
                if (product.value) productsItem.value = product.value ?? null;
            });
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
