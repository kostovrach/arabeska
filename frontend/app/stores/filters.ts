import type { LocationQuery } from 'vue-router';

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

interface IFiltersList {
    id?: number | string;
    styles?: IFilterStyle[];
    reasons?: IFilterReasons[];
    structure?: IFilterStructure[];
}

interface FilterState {
    discountOnly: boolean;
    selectedStructures: string[];
    selectedReasons: string[];
    selectedStyles: string[];
    priceMin: number | null;
    priceMax: number | null;
    sortBy: SortKey;
}
// ==================================================================

export const useFiltersStore = defineStore('filters', () => {
    const filterState: Ref<FilterState> = ref({
        discountOnly: false,
        selectedStructures: [],
        selectedReasons: [],
        selectedStyles: [],
        priceMin: null,
        priceMax: null,
        sortBy: null,
    });

    const structures: Ref<IFilterStructure[]> = ref([]);
    const reasons: Ref<IFilterReasons[]> = ref([]);
    const styles: Ref<IFilterStyle[]> = ref([]);

    const productsList = computed(() => useProductsStore().productsList ?? []);

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

    const filteredProducts = computed(() => {
        if (!productsList.value.length) return [];

        const pMin = filterState.value.priceMin ?? minPrice.value;
        const pMax = filterState.value.priceMax ?? maxPrice.value;

        let res = productsList.value.filter((p) => {
            if (!p.available) return false;
            if (filterState.value.discountOnly && p.discount == null) return false;

            const ep = p.discount ?? p.price;
            if (ep == null || ep < pMin || ep > pMax) return false;

            if (filterState.value.selectedStructures.length) {
                const names = (p.structure ?? []).map((s) =>
                    String(s.structure_id?.name ?? '').trim()
                );
                if (!filterState.value.selectedStructures.every((sel) => names.includes(sel)))
                    return false;
            }

            if (filterState.value.selectedReasons.length) {
                const names = (p.reason ?? []).map((r) => String(r.reason_id?.name ?? '').trim());
                if (!filterState.value.selectedReasons.every((sel) => names.includes(sel)))
                    return false;
            }

            if (filterState.value.selectedStyles.length) {
                const names = (p.style ?? []).map((st) => String(st.styles_id?.name ?? '').trim());
                if (!filterState.value.selectedStyles.every((sel) => names.includes(sel)))
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
                (a, b) => new Date(b.date_created).getTime() - new Date(a.date_created).getTime()
            );
        }

        return res;
    });

    function loadFilters() {
        const { content: filtersData } = useCms<IFiltersList>('filters', [
            'reasons.*',
            'reasons.reason_id.*',
            'structure.*',
            'structure.structure_id.*',
            'styles.*',
            'styles.styles_id.*',
        ]);

        watchEffect(() => {
            const d = filtersData.value;
            if (d) {
                if (d.structure?.length) structures.value = d.structure;
                if (d.reasons?.length) reasons.value = d.reasons;
                if (d.styles?.length) styles.value = d.styles;
            }
        });
    }

    function initFromQuery(query: LocationQuery) {
        filterState.value = {
            ...filterState.value,
            discountOnly: query.discount === 'true',
            selectedStructures: query.structure
                ? String(query.structure).split(',').map(decodeURIComponent)
                : [],
            selectedReasons: query.reason
                ? String(query.reason).split(',').map(decodeURIComponent)
                : [],
            selectedStyles: query.style
                ? String(query.style).split(',').map(decodeURIComponent)
                : [],
            priceMin: query.price_min ? Number(query.price_min) : minPrice.value,
            priceMax: query.price_max ? Number(query.price_max) : maxPrice.value,
            sortBy: (query.sort as SortKey) ?? null,
        };
    }

    function resetFilters() {
        filterState.value = {
            discountOnly: false,
            selectedStructures: [],
            selectedReasons: [],
            selectedStyles: [],
            priceMin: minPrice.value,
            priceMax: maxPrice.value,
            sortBy: null,
        };
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

    return {
        filterState,
        structures,
        reasons,
        styles,
        minPrice,
        maxPrice,
        filteredProducts,
        loadFilters,
        initFromQuery,
        resetFilters,
    };
});
