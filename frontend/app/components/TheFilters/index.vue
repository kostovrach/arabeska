<template>
    <ClientOnly>
        <form
            v-if="props.type !== 'none'"
            @submit.prevent
            class="filters"
            role="region"
            aria-label="Фильтры"
        >
            <div class="filters__group">
                <label class="filters__item filters__item--button" for="filter-popular">
                    <input
                        type="checkbox"
                        id="filter-popular"
                        v-model="filterState.popularOnly"
                        :aria-checked="filterState.popularOnly"
                        aria-label="Показать популярные товары"
                    />
                    <span>Популярное</span>
                </label>
                <label class="filters__item filters__item--button" for="filter-discount">
                    <input
                        type="checkbox"
                        id="filter-discount"
                        v-model="filterState.discountOnly"
                        :aria-checked="filterState.discountOnly"
                        aria-label="Показать только товары с акцией"
                    />
                    <span>Акции</span>
                </label>

                <template v-if="props.type === 'standard'">
                    <TheFiltersDropdown
                        class="filters__item filters__item--multiple"
                        label="Цветы"
                        :items="
                            structures?.map((el) => ({
                                id: el.structure_id.id,
                                name: el.structure_id.name,
                            })) ?? []
                        "
                        v-model:selected="filterState.selectedStructures"
                    />
                    <TheFiltersDropdown
                        class="filters__item filters__item--multiple"
                        label="Повод"
                        :items="
                            reasons?.map((el) => ({
                                id: el.reason_id.id,
                                name: el.reason_id.name,
                            })) ?? []
                        "
                        v-model:selected="filterState.selectedReasons"
                    />
                    <TheFiltersDropdown
                        class="filters__item filters__item--multiple"
                        label="Стиль"
                        :items="
                            styles?.map((el) => ({
                                id: el.styles_id.id,
                                name: el.styles_id.name,
                            })) ?? []
                        "
                        v-model:selected="filterState.selectedStyles"
                    />
                </template>

                <template v-if="props.type === 'roses'">
                    <TheFiltersDropdown
                        class="filters__item filters__item--multiple"
                        label="Цвет"
                        :items="
                            colors?.map((el) => ({
                                id: el.colors_id.id,
                                name: el.colors_id.name,
                            })) ?? []
                        "
                        v-model:selected="filterState.selectedColors"
                    />
                </template>

                <template v-if="props.type === 'roses' || props.type === 'additional'">
                    <TheFiltersDropdown
                        class="filters__item filters__item--multiple"
                        label="Формат"
                        :items="
                            formats?.map((el) => ({
                                id: el.format_id.id,
                                name: el.format_id.name,
                            })) ?? []
                        "
                        v-model:selected="filterState.selectedFormats"
                    />
                </template>
                <button
                    class="filters__item filters__item--reset"
                    type="button"
                    title="Сбросить фильтры"
                    aria-label="Сбросить фильтры"
                    @click="
                        () => {
                            resetFilters();
                            doSyncToUrl();
                        }
                    "
                >
                    <span><SvgSprite type="refresh" :size="18" /></span>
                </button>
            </div>

            <div class="filters__range" role="group" aria-label="Фильтр по цене">
                <div class="filters__range-label">Цена</div>
                <div class="filters__range-body">
                    <div class="filters__range-values" aria-hidden="true">
                        <span class="ruble">
                            {{ filterState.priceMin?.toLocaleString('ru-RU') }}
                        </span>
                        <span class="ruble">
                            {{ filterState.priceMax?.toLocaleString('ru-RU') }}
                        </span>
                    </div>
                    <div class="filters__range-inputbox">
                        <input
                            class="filters__range-input filters__range-input--min"
                            type="range"
                            :min="minPrice"
                            :max="maxPrice"
                            :step="RANGE_STEP"
                            v-model="filterState.priceMin"
                            @input="normalizeMin"
                            :aria-valuemin="minPrice"
                            :aria-valuemax="maxPrice"
                            :aria-valuenow="filterState.priceMin ?? 0"
                            aria-label="Минимальная цена"
                        />
                        <input
                            class="filters__range-input filters__range-input--max"
                            type="range"
                            :min="minPrice"
                            :max="maxPrice"
                            :step="RANGE_STEP"
                            v-model="filterState.priceMax"
                            @input="normalizeMax"
                            :aria-valuemin="minPrice"
                            :aria-valuemax="maxPrice"
                            :aria-valuenow="filterState.priceMax ?? 0"
                            aria-label="Максимальная цена"
                        />
                        <div class="filters__range-track" aria-hidden="true">
                            <div
                                class="filters__range-active"
                                :style="{
                                    marginLeft: rangePercentLeft + '%',
                                    marginRight: rangePercentRight + '%',
                                }"
                            ></div>
                        </div>
                    </div>
                </div>
            </div>
            <TheFiltersSort
                class="filters__sort"
                label="Сортировка"
                :options="sortOptions"
                v-model:modelValue="filterState.sortBy"
            />
        </form>
    </ClientOnly>
</template>

<script setup lang="ts">
    import type { LocationQuery } from 'vue-router';
    import type { ICategories } from '~~/interfaces/categories';

    const props = withDefaults(
        defineProps<{
            type: ICategories['filters'];
        }>(),
        {
            type: 'standard',
        }
    );

    // data =======================================================================
    const route = useRoute();
    const router = useRouter();

    const filterStore = useFiltersStore();

    const filterState = computed(() => filterStore.filterState);

    const structures = computed(() => filterStore.structures);
    const reasons = computed(() => filterStore.reasons);
    const styles = computed(() => filterStore.styles);
    const colors = computed(() => filterStore.colors);
    const formats = computed(() => filterStore.formats);

    const minPrice = computed(() => filterStore.minPrice);
    const maxPrice = computed(() => filterStore.maxPrice);

    const { resetFilters, loadFilters, initFromQuery } = filterStore;

    initFromQuery(route.query);
    loadFilters();

    const RANGE_STEP = 1;

    const rangePercentLeft = computed(() => {
        const min = Number(minPrice.value ?? 0);
        const max = Number(maxPrice.value ?? 0);
        const curMin = Number(filterState.value.priceMin ?? min);
        return max === min ? 0 : ((curMin - min) / (max - min)) * 100;
    });

    const rangePercentRight = computed(() => {
        const min = Number(minPrice.value ?? 0);
        const max = Number(maxPrice.value ?? 0);
        const curMax = Number(filterState.value.priceMax ?? max);
        return max === min ? 0 : 100 - ((curMax - min) / (max - min)) * 100;
    });

    const sortOptions = [
        { value: '', label: 'По умолчанию' },
        { value: 'price_asc', label: 'По  возрастанию цены' },
        { value: 'price_desc', label: 'По убыванию цены' },
        { value: 'date_new', label: 'Сначала новинки' },
    ];
    // ============================================================================

    // helpers ====================================================================
    const doSyncToUrl = useDebounceFn(() => {
        const q: LocationQuery = {};

        if (filterState.value.popularOnly) q.popular = 'true';
        if (filterState.value.discountOnly) q.discount = 'true';
        if (filterState.value.selectedStructures.length)
            q.structure = filterState.value.selectedStructures.join(',');
        if (filterState.value.selectedReasons.length)
            q.reason = filterState.value.selectedReasons.join(',');
        if (filterState.value.selectedStyles.length)
            q.style = filterState.value.selectedStyles.join(',');
        if (filterState.value.selectedColors.length)
            q.color = filterState.value.selectedColors.join(',');
        if (filterState.value.selectedFormats.length)
            q.format = filterState.value.selectedFormats.join(',');
        if (
            filterState.value.priceMin != null &&
            filterState.value.priceMax != null &&
            (filterState.value.priceMin !== minPrice.value ||
                filterState.value.priceMax !== maxPrice.value)
        ) {
            q.price_min = String(filterState.value.priceMin);
            q.price_max = String(filterState.value.priceMax);
        }
        if (filterState.value.sortBy) q.sort = filterState.value.sortBy;

        router.replace({ path: route.path, query: q }).catch(() => {});
    }, 250);

    watch(filterState, () => doSyncToUrl(), { deep: true });

    function normalizeMin() {
        const min = Number(minPrice.value ?? 0);
        const max = Number(maxPrice.value ?? 0);
        let val = Math.round((filterState.value.priceMin ?? min) / RANGE_STEP) * RANGE_STEP;
        val = Math.max(min, Math.min(max, val));
        if (filterState.value.priceMax != null && val > filterState.value.priceMax)
            filterState.value.priceMax = val;
        filterState.value.priceMin = val;
    }

    function normalizeMax() {
        const min = Number(minPrice.value ?? 0);
        const max = Number(maxPrice.value ?? 0);
        let val = Math.round((filterState.value.priceMax ?? max) / RANGE_STEP) * RANGE_STEP;
        val = Math.max(min, Math.min(max, val));
        if (filterState.value.priceMin != null && val < filterState.value.priceMin)
            filterState.value.priceMin = val;
        filterState.value.priceMax = val;
    }
    // ============================================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .filters {
        display: grid;
        grid-template-areas:
            'group range'
            '. sort';
        justify-content: space-between;
        gap: rem(32);
        font-family: 'Inter', sans-serif;
        @media (max-width: 768px) {
            display: flex;
            flex-direction: column;
        }
        &__group {
            grid-area: group;
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: rem(8);
            user-select: none;
            @media (max-width: 768px) {
                max-width: 75%;
            }
        }
        &__item {
            cursor: pointer;
            font-size: lineScale(18, 16, 480, 1440);
            font-weight: $fw-semi;
            &--button {
                position: relative;
                width: fit-content;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: rem(12) rem(18);
                border-radius: rem(32);
                opacity: 0.8;
                > input {
                    position: absolute;
                    inset: 0;
                    z-index: -1;
                    pointer-events: none;
                }
                &:has(input[type='checkbox']:checked) {
                    color: $c-FFFFFF;
                    background-color: $c-accent;
                    opacity: 1;
                }
                &:has(input[type='checkbox']:not(:checked)):focus-within {
                    opacity: 1;
                    background-color: $c-D4E1E7;
                }
                &:active {
                    scale: 0.98;
                }
                @media (pointer: fine) {
                    &:hover {
                        opacity: 1;
                        background-color: $c-D4E1E7;
                    }
                }
            }
            &--reset {
                display: flex;
                align-items: center;
                justify-content: center;
                width: rem(48);
                aspect-ratio: 1;
                border-radius: 50%;
                @media (pointer: fine) {
                    > span:has(svg) {
                        display: block;
                        width: rem(18);
                        height: rem(18);
                        transition: rotate $td $tf-spring;
                    }
                    &:hover {
                        background-color: $c-D4E1E7;
                        > span:has(svg) {
                            rotate: 180deg;
                        }
                    }
                }
                &:focus {
                    background-color: $c-D4E1E7;
                }
                &:active {
                    scale: 0.9;
                }
            }
        }
        &__range {
            grid-area: range;
            position: relative;
            width: rem(320);
            display: flex;
            align-items: center;
            gap: rem(32);
            font-size: rem(16);
            font-weight: $fw-semi;
            @media (max-width: 768px) {
                align-self: flex-end;
            }
            &-label {
                opacity: 0.5;
            }
            &-body {
                width: 100%;
                display: flex;
                flex-direction: column;
                gap: rem(8);
            }
            &-values {
                width: 100%;
                display: flex;
                align-items: center;
                justify-content: space-between;
                gap: rem(32);
                opacity: 0.5;
            }
            &-inputbox {
                width: 100%;
                height: rem(30);
                position: relative;
            }
            &-input[type='range'] {
                position: absolute;
                z-index: 1;
                left: 0;
                right: 0;
                top: 50%;
                translate: 0 -50%;
                height: 0;
                background-color: transparent;
                pointer-events: none;
                &::-webkit-slider-thumb {
                    cursor: pointer;
                    width: rem(12);
                    aspect-ratio: 1;
                    border-radius: 50%;
                    background-color: $c-accent;
                    box-shadow: 0 0 5px $c-D4E1E7;
                    pointer-events: auto;
                    @media (pointer: fine) {
                        &:not(:active):hover {
                            scale: 1.2;
                        }
                    }
                    &:active {
                        scale: 1.2;
                    }
                }
            }
            &-track {
                position: absolute;
                left: 0;
                right: 0;
                top: 50%;
                translate: 0 -50%;
                height: rem(4);
                background-color: $c-D4E1E7;
                border-radius: rem(16);
                pointer-events: none;
            }
            &-active {
                position: absolute;
                inset: 0;
                background: $c-accent;
                pointer-events: none;
            }
        }
        &__sort {
            grid-area: sort;
            @media (max-width: 768px) {
                align-self: flex-end;
            }
        }
    }
</style>
