// stores/filters.ts
import type { IProduct } from '~~/interfaces/product';
import type { Ref } from 'vue';

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

export const useFiltersStore = defineStore('filters', () => {
    // State as ref
    const filterState: Ref<FilterState> = ref({
        discountOnly: false,
        selectedStructures: [],
        selectedReasons: [],
        selectedStyles: [],
        priceMin: null,
        priceMax: null,
        sortBy: null,
    });

    // Dictionaries
    const structures: Ref<IFilterStructure[]> = ref([]);
    const reasons: Ref<IFilterReasons[]> = ref([]);
    const styles: Ref<IFilterStyle[]> = ref([]);

    // External products
    const productsList: ComputedRef<IProduct[]> = computed(
        () => useProductsStore().productsList ?? []
    );

    // Getters as computed
    const minPrice: ComputedRef<number> = computed(() => {
        const prices = productsList.value
            .map((p) => p.discount ?? p.price)
            .filter((v) => typeof v === 'number');
        return prices.length ? Math.min(...prices) : 0;
    });

    const maxPrice: ComputedRef<number> = computed(() => {
        const prices = productsList.value
            .map((p) => p.discount ?? p.price)
            .filter((v) => typeof v === 'number');
        return prices.length ? Math.max(...prices) : 0;
    });

    const filteredProducts: ComputedRef<IProduct[]> = computed(() => {
        if (!productsList.value.length) return [];

        const pMin = filterState.value.priceMin ?? minPrice.value;
        const pMax = filterState.value.priceMax ?? maxPrice.value;

        let res = productsList.value.filter((p: IProduct) => {
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

        // Sort (без изменений)
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

    // Actions as functions
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

    function initFromQuery() {
        const q = useRoute().query;
        filterState.value = {
            ...filterState.value,
            discountOnly: q.discount === 'true',
            selectedStructures: q.structure
                ? String(q.structure).split(',').map(decodeURIComponent)
                : [],
            selectedReasons: q.reason ? String(q.reason).split(',').map(decodeURIComponent) : [],
            selectedStyles: q.style ? String(q.style).split(',').map(decodeURIComponent) : [],
            priceMin: q.price_min ? Number(q.price_min) : minPrice.value,
            priceMax: q.price_max ? Number(q.price_max) : maxPrice.value,
            sortBy: (q.sort as SortKey) ?? null,
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
        useRouter()
            .replace({ path: useRoute().path, query: {} })
            .catch(() => {});
    }

    function clearQueryOnLeave() {
        useRouter()
            .replace({ path: useRoute().path, query: {} })
            .catch(() => {});
    }

    // URL sync (debounced watch inside store)
    const doSyncToUrl = useDebounceFn(() => {
        const q: Record<string, any> = {};
        if (filterState.value.discountOnly) q.discount = 'true';
        if (filterState.value.selectedStructures.length)
            q.structure = filterState.value.selectedStructures.join(',');
        if (filterState.value.selectedReasons.length)
            q.reason = filterState.value.selectedReasons.join(',');
        if (filterState.value.selectedStyles.length)
            q.style = filterState.value.selectedStyles.join(',');
        if (filterState.value.priceMin != null && filterState.value.priceMax != null) {
            q.price_min = String(filterState.value.priceMin);
            q.price_max = String(filterState.value.priceMax);
        }
        if (filterState.value.sortBy) q.sort = filterState.value.sortBy;
        useRouter()
            .replace({ path: useRoute().path, query: q })
            .catch(() => {});
    }, 250);

    watch(filterState, () => doSyncToUrl(), { deep: true });

    // Price init watch
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
        clearQueryOnLeave,
    };
});
