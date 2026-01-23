import type { LocationQuery } from 'vue-router';
import type { IProduct } from '~~/interfaces/entities/product';

// types ============================================================
type SortKey = 'price_asc' | 'price_desc' | 'date_new' | null;

interface IFilterStyle {
    id: number | string;
    filters_id?: unknown;
    styles_id: {
        id: number | string;
        name: string;
        sort?: number;
    };
}

interface IFilterStructure {
    id: number | string;
    filters_id?: unknown;
    structure_id: {
        id: number | string;
        name: string;
        sort?: number;
    };
}

interface IFilterReasons {
    id: number | string;
    filters_id?: unknown;
    reason_id: {
        id: number | string;
        name: string;
        sort?: number;
    };
}

interface IFilterColor {
    id: number | string;
    filters_id?: unknown;
    colors_id: {
        id: number | string;
        name: string;
        sort?: number;
    };
}

interface IFilterFormat {
    id: number | string;
    filters_id?: unknown;
    format_id: {
        id: number | string;
        name: string;
        sort?: number;
    };
}

interface IFiltersList {
    id?: number | string;
    styles?: IFilterStyle[];
    reasons?: IFilterReasons[];
    structure?: IFilterStructure[];
    color?: IFilterColor[];
    format?: IFilterFormat[];
}

interface FilterState {
    popularOnly: boolean;
    discountOnly: boolean;
    selectedStructures: string[];
    selectedReasons: string[];
    selectedStyles: string[];
    selectedColors: string[];
    selectedFormats: string[];
    priceMin: number | null;
    priceMax: number | null;
    sortBy: SortKey;
}
// ==================================================================

export const useFiltersStore = defineStore('filters', () => {
    const productsStore = useProductsStore();

    // State ========================================================
    const filterState: Ref<FilterState> = ref({
        popularOnly: false,
        discountOnly: false,
        selectedStructures: [],
        selectedReasons: [],
        selectedStyles: [],
        selectedColors: [],
        selectedFormats: [],
        priceMin: null,
        priceMax: null,
        sortBy: null,
    });

    const structures = ref<IFilterStructure[]>([]);
    const reasons = ref<IFilterReasons[]>([]);
    const styles = ref<IFilterStyle[]>([]);
    const colors = ref<IFilterColor[]>([]);
    const formats = ref<IFilterFormat[]>([]);
    // ==============================================================

    // Computed =====================================================
    const productsList = computed(() => productsStore.products);
    const minPrice = computed(() => {
        const prices = productsList.value
            .map((p) => p.discount ?? p.price)
            .filter((v) => typeof v === 'number');
        return prices.length ? Math.min(...prices) : 0;
    });

    const maxPrice = computed(() => {
        const prices = productsList.value
            .map((p) => p.discount ?? p.price)
            .filter((v) => typeof v === 'number');
        return prices.length ? Math.max(...prices) : 0;
    });
    // ==============================================================

    // Actions ======================================================
    function filteredProducts(category: string | 'all', exclude?: string) {
        const products = computed(() => {
            if (!productsList.value.length) return [];

            const pMin = filterState.value.priceMin ?? minPrice.value;
            const pMax = filterState.value.priceMax ?? maxPrice.value;

            let productsData: IProduct[];

            if (category === 'all' && exclude?.length) {
                productsData = productsList.value.filter((el) =>
                    el.category?.some(
                        (item) => slugify(item.categories_id?.name!) !== slugify(exclude)
                    )
                );
            } else {
                productsData = productsList.value.filter((el) =>
                    el.category?.some(
                        (item) => slugify(item.categories_id?.name!) === slugify(category)
                    )
                );
            }

            let res = productsData.filter((product) => {
                if (!product.available) return false;
                if (filterState.value.popularOnly && !product.popular) return false;
                if (filterState.value.discountOnly && product.discount == null) return false;

                const ep = product.discount ?? product.price;
                if (ep == null || ep < pMin || ep > pMax) return false;

                if (filterState.value.selectedStructures.length) {
                    const names = (product.structure ?? []).map((s) =>
                        String(s.structure_id?.name ?? '').trim()
                    );
                    if (!filterState.value.selectedStructures.every((sel) => names.includes(sel)))
                        return false;
                }

                if (filterState.value.selectedReasons.length) {
                    const names = (product.reason ?? []).map((r) =>
                        String(r.reason_id?.name ?? '').trim()
                    );
                    if (!filterState.value.selectedReasons.every((sel) => names.includes(sel)))
                        return false;
                }

                if (filterState.value.selectedStyles.length) {
                    const names = (product.style ?? []).map((st) =>
                        String(st.styles_id?.name ?? '').trim()
                    );
                    if (!filterState.value.selectedStyles.every((sel) => names.includes(sel)))
                        return false;
                }

                if (filterState.value.selectedColors.length) {
                    const names = (product.color ?? []).map((col) =>
                        String(col.colors_id?.name ?? '').trim()
                    );

                    if (!filterState.value.selectedColors.every((sel) => names.includes(sel)))
                        return false;
                }

                if (filterState.value.selectedFormats.length) {
                    const names = (product.format ?? []).map((fr) =>
                        String(fr.format_id?.name ?? '').trim()
                    );
                    if (!filterState.value.selectedFormats.every((sel) => names.includes(sel)))
                        return false;
                }

                return true;
            });

            const sort = filterState.value.sortBy;
            if (sort === 'price_asc') {
                res.sort((a, b) => (a.discount ?? a.price) - (b.discount ?? a.price));
            } else if (sort === 'price_desc') {
                res.sort((a, b) => (b.discount ?? b.price) - (a.discount ?? a.price));
            } else if (sort === 'date_new') {
                res.sort(
                    (a, b) =>
                        new Date(b.date_created).getTime() - new Date(a.date_created).getTime()
                );
            }

            return res;
        });

        return products.value;
    }

    async function loadFilters() {
        const { content: filtersData } = await useCms<IFiltersList>('filters', [
            'reasons.*',
            'reasons.reason_id.*',
            'structure.*',
            'structure.structure_id.*',
            'styles.*',
            'styles.styles_id.*',
            'color.*',
            'color.colors_id.*',
            'format.*',
            'format.format_id.*',
        ]);

        watchEffect(() => {
            const data = filtersData.value;
            if (data) {
                if (data.structure?.length) structures.value = data.structure;
                if (data.reasons?.length) reasons.value = data.reasons;
                if (data.styles?.length) styles.value = data.styles;
                if (data.color?.length) colors.value = data.color;
                if (data.format?.length) formats.value = data.format;
            }
        });
    }

    function initFromQuery(query: LocationQuery) {
        filterState.value = {
            ...filterState.value,
            discountOnly: query.discount === 'true',
            popularOnly: query.popular === 'true',
            selectedStructures: query.structure
                ? String(query.structure).split(',').map(decodeURIComponent)
                : [],
            selectedReasons: query.reason
                ? String(query.reason).split(',').map(decodeURIComponent)
                : [],
            selectedStyles: query.style
                ? String(query.style).split(',').map(decodeURIComponent)
                : [],
            selectedColors: query.color
                ? String(query.color).split(',').map(decodeURIComponent)
                : [],
            selectedFormats: query.format
                ? String(query.format).split(',').map(decodeURIComponent)
                : [],
            priceMin: query.price_min ? Number(query.price_min) : minPrice.value,
            priceMax: query.price_max ? Number(query.price_max) : maxPrice.value,
            sortBy: (query.sort as SortKey) ?? null,
        };
    }

    function resetFilters() {
        if (
            !filterState.value.discountOnly &&
            !filterState.value.popularOnly &&
            !filterState.value.selectedStructures.length &&
            !filterState.value.selectedReasons.length &&
            !filterState.value.selectedStyles.length &&
            !filterState.value.selectedColors.length &&
            !filterState.value.selectedFormats.length &&
            filterState.value.priceMax == maxPrice.value &&
            filterState.value.priceMin == minPrice.value &&
            !filterState.value.sortBy
        ) {
            return;
        } else {
            filterState.value = {
                popularOnly: false,
                discountOnly: false,
                selectedStructures: [],
                selectedReasons: [],
                selectedStyles: [],
                selectedColors: [],
                selectedFormats: [],
                priceMin: minPrice.value,
                priceMax: maxPrice.value,
                sortBy: null,
            };
        }
    }

    watch(
        [minPrice, maxPrice],
        ([min, max]) => {
            if (filterState.value.priceMin == null) filterState.value.priceMin = min;
            if (filterState.value.priceMax == null) filterState.value.priceMax = max;
            if (filterState.value.priceMin < min) filterState.value.priceMin = min;
            if (filterState.value.priceMax > max) filterState.value.priceMax = max;
        },
        { immediate: true }
    );
    // ==============================================================

    return {
        filterState,
        structures,
        reasons,
        styles,
        colors,
        formats,
        minPrice,
        maxPrice,
        filteredProducts,
        loadFilters,
        initFromQuery,
        resetFilters,
    };
});
