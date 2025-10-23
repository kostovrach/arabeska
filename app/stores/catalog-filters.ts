import { ref, computed, watch } from 'vue';
import { defineStore, storeToRefs } from 'pinia';
import Fuse from 'fuse.js';
import type { IProduct } from '~/interfaces/product';
import type { TypeCategories } from '~/types/categories';

export const useCatalogFilterStore = defineStore('catalogFilter', () => {
    // State
    const catalogList = ref<IProduct[] | null>(null);
    const selectedFlowers = ref<string[]>([]);
    const isPopular = ref<boolean>(false);
    const isDiscounted = ref<boolean>(false);
    const selectedReasons = ref<string[]>([]);
    const selectedStyles = ref<string[]>([]);
    const priceRange = ref<{ min: number; max: number }>({ min: 0, max: 10000 });
    const sortOrder = ref<'asc' | 'desc' | null>(null);

    // External stores
    const { productsList } = storeToRefs(useProductsStore());
    const { certificatesList } = storeToRefs(useCertificatesStore());
    const { accessoriesList } = storeToRefs(useAccessoriesStore());

    // Router
    const route = useRoute();
    const router = useRouter();

    // Fetch catalog items based on category
    function getCatalogItems(category: TypeCategories) {
        // Reset filters when category changes
        resetFilters();

        // Load catalog data
        switch (category) {
            case 'flowers':
                catalogList.value = productsList.value;
                break;
            case 'certificates':
                catalogList.value = certificatesList.value;
                break;
            case 'accessory':
                catalogList.value = accessoriesList.value;
                break;
            default:
                catalogList.value = productsList.value;
                break;
        }
    }

    // Reset all filters
    function resetFilters() {
        selectedFlowers.value = [];
        isPopular.value = false;
        isDiscounted.value = false;
        selectedReasons.value = [];
        selectedStyles.value = [];
        priceRange.value = { min: 0, max: 10000 };
        sortOrder.value = null;
        router.push({ query: {} }); // Clear query parameters
    }

    // Fuse.js setup
    const fuseOptions = {
        keys: [
            { name: 'structure.name', weight: 1 },
            { name: 'reason', weight: 1 },
            { name: 'style', weight: 1 },
            { name: 'popular', weight: 1 },
            { name: 'discount', weight: 1 },
        ],
        threshold: 0.35,
        includeScore: true,
        useExtendedSearch: true,
    };

    // Filter function
    const applyFilters = () => {
        if (!catalogList.value) return [];

        let filteredProducts = [...catalogList.value];

        // Return all products if no filters are applied
        if (
            selectedFlowers.value.length === 0 &&
            selectedReasons.value.length === 0 &&
            selectedStyles.value.length === 0 &&
            !isPopular.value &&
            !isDiscounted.value &&
            priceRange.value.min === 0 &&
            priceRange.value.max === 10000
        ) {
            return filteredProducts;
        }

        const fuse = new Fuse(filteredProducts, fuseOptions);

        // Apply flower filter (strict AND for all selected flowers)
        if (selectedFlowers.value.length > 0) {
            filteredProducts = filteredProducts.filter((product) => {
                const flowerNames = product.structure?.map((s) => s.name) || [];
                return selectedFlowers.value.every((flower) => {
                    const query = { 'structure.name': `="${flower}"` };
                    const results = fuse.search(query, { limit: filteredProducts.length });
                    return results.some((result) => result.item.id === product.id);
                });
            });
        }

        // Apply reason filter (strict AND for all selected reasons)
        if (selectedReasons.value.length > 0) {
            filteredProducts = filteredProducts.filter((product) => {
                const reasons = product.reason || [];
                return selectedReasons.value.every((reason) => {
                    const query = { reason: `="${reason}"` };
                    const results = fuse.search(query, { limit: filteredProducts.length });
                    return results.some((result) => result.item.id === product.id);
                });
            });
        }

        // Apply style filter (strict AND for all selected styles)
        if (selectedStyles.value.length > 0) {
            filteredProducts = filteredProducts.filter((product) => {
                const styles = product.style || [];
                return selectedStyles.value.every((style) => {
                    const query = { style: `="${style}"` };
                    const results = fuse.search(query, { limit: filteredProducts.length });
                    return results.some((result) => result.item.id === product.id);
                });
            });
        }

        // Apply popular filter
        if (isPopular.value) {
            filteredProducts = fuse.search({ popular: '=true' }).map((result) => result.item);
        }

        // Apply discount filter
        if (isDiscounted.value) {
            filteredProducts = fuse
                .search({ discount: '!*undefined' })
                .map((result) => result.item);
        }

        // Apply price range filter (JavaScript)
        if (priceRange.value.min > 0 || priceRange.value.max < 10000) {
            filteredProducts = filteredProducts.filter((product) => {
                const price = Number(product.price);
                return price >= priceRange.value.min && price <= priceRange.value.max;
            });
        }

        // Apply sorting
        if (sortOrder.value) {
            filteredProducts.sort((a, b) => {
                if (sortOrder.value === 'asc') {
                    return a.price - b.price;
                } else {
                    return b.price - a.price;
                }
            });
        }

        return filteredProducts;
    };

    // Debounced filter function
    //   const debouncedFilter = useDebounceFn(applyFilters, 300);

    // Computed filtered products
    //   const filteredProducts = computed<IProduct[]>(() => debouncedFilter());

    const filteredProducts = computed<IProduct[]>(() => applyFilters());

    // Sync filters with URL query parameters
    watch(
        [
            selectedFlowers,
            isPopular,
            isDiscounted,
            selectedReasons,
            selectedStyles,
            priceRange,
            sortOrder,
        ],
        () => {
            const query: Record<string, string | string[] | undefined> = {
                flowers:
                    selectedFlowers.value.length > 0 ? selectedFlowers.value.join(',') : undefined,
                popular: isPopular.value ? 'true' : undefined,
                discounted: isDiscounted.value ? 'true' : undefined,
                reasons:
                    selectedReasons.value.length > 0 ? selectedReasons.value.join(',') : undefined,
                styles:
                    selectedStyles.value.length > 0 ? selectedStyles.value.join(',') : undefined,
                priceMin: priceRange.value.min > 0 ? priceRange.value.min.toString() : undefined,
                priceMax:
                    priceRange.value.max < 10000 ? priceRange.value.max.toString() : undefined,
                sort: sortOrder.value || undefined,
            };
            router.push({ query });
        },
        { deep: true }
    );

    // Initialize filters from URL
    function initFromQuery() {
        selectedFlowers.value = route.query.flowers
            ? (route.query.flowers as string).split(',')
            : [];
        isPopular.value = route.query.popular === 'true';
        isDiscounted.value = route.query.discounted === 'true';
        selectedReasons.value = route.query.reasons
            ? (route.query.reasons as string).split(',')
            : [];
        selectedStyles.value = route.query.styles ? (route.query.styles as string).split(',') : [];
        priceRange.value = {
            min: route.query.priceMin ? Number(route.query.priceMin) : 0,
            max: route.query.priceMax ? Number(route.query.priceMax) : 10000,
        };
        sortOrder.value =
            route.query.sort === 'asc' || route.query.sort === 'desc' ? route.query.sort : null;
    }

    return {
        catalogList,
        selectedFlowers,
        isPopular,
        isDiscounted,
        selectedReasons,
        selectedStyles,
        priceRange,
        sortOrder,
        filteredProducts,
        getCatalogItems,
        initFromQuery,
        resetFilters,
    };
});
