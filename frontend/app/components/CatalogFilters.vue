<template>
    <section class="catalog-filters" aria-label="Фильтры каталога">
        <form @submit.prevent class="cf__form" role="region" aria-label="Фильтры">
            <!-- Акция -->
            <div class="cf__item cf__item--checkbox">
                <label class="cf-checkbox">
                    <input
                        type="checkbox"
                        v-model="filterState.discountOnly"
                        :aria-checked="filterState.discountOnly"
                        aria-label="Показать только товары с акцией"
                    />
                    <span>Акция</span>
                </label>
            </div>

            <!-- Dropdowns -->
            <CatalogFilterDropdown
                label="Цветы"
                :items="
                    structures.map((s) => ({ id: s.structure_id.id, name: s.structure_id.name }))
                "
                v-model:selected="filterState.selectedStructures"
            />
            <CatalogFilterDropdown
                label="Повод"
                :items="reasons.map((r) => ({ id: r.reason_id.id, name: r.reason_id.name }))"
                v-model:selected="filterState.selectedReasons"
            />
            <CatalogFilterDropdown
                label="Стиль"
                :items="styles.map((st) => ({ id: st.styles_id.id, name: st.styles_id.name }))"
                v-model:selected="filterState.selectedStyles"
            />

            <!-- Диапазон цен -->
            <div class="cf__item cf__item--range" role="group" aria-label="Фильтр по цене">
                <div class="cf__label">Цена</div>
                <div class="cf-range">
                    <input
                        class="cf-range__input cf-range__min"
                        type="range"
                        :min="minPrice"
                        :max="maxPrice"
                        :step="STEP"
                        v-model="filterState.priceMin"
                        @input="normalizeMin"
                        :aria-valuemin="minPrice"
                        :aria-valuemax="maxPrice"
                        :aria-valuenow="filterState.priceMin ?? 0"
                        aria-label="Минимальная цена"
                    />
                    <input
                        class="cf-range__input cf-range__max"
                        type="range"
                        :min="minPrice"
                        :max="maxPrice"
                        :step="STEP"
                        v-model="filterState.priceMax"
                        @input="normalizeMax"
                        :aria-valuemin="minPrice"
                        :aria-valuemax="maxPrice"
                        :aria-valuenow="filterState.priceMax ?? 0"
                        aria-label="Максимальная цена"
                    />
                    <div class="cf-range__track" aria-hidden="true">
                        <div
                            class="cf-range__active"
                            :style="{
                                left: rangePercentLeft + '%',
                                right: rangePercentRight + '%',
                            }"
                        ></div>
                    </div>
                    <div class="cf-range__values" aria-hidden="true">
                        <span>{{ filterState.priceMin }} ₽</span>
                        <span>{{ filterState.priceMax }} ₽</span>
                    </div>
                </div>
            </div>

            <!-- Сортировка -->
            <CatalogSortDropdown
                label="Сортировка"
                :options="sortOptions"
                v-model:modelValue="filterState.sortBy"
            />

            <!-- Сброс -->
            <div class="cf__item cf__item--reset">
                <button type="button" @click="resetFilters" class="cf-reset">Сбросить</button>
            </div>
        </form>
    </section>
</template>

<script setup lang="ts">
    import { storeToRefs } from 'pinia';

    const store = useFiltersStore();
    const { filterState, structures, reasons, styles, minPrice, maxPrice } = storeToRefs(store);
    const { resetFilters } = store;

    onMounted(() => {
        store.initFromQuery();
        store.loadFilters();
    });

    onBeforeUnmount(() => {
        store.clearQueryOnLeave();
    });

    const STEP = 100;

    function normalizeMin() {
        const min = Number(minPrice.value ?? 0);
        const max = Number(maxPrice.value ?? 0);
        let val = Math.round((filterState.value.priceMin ?? min) / STEP) * STEP;
        val = Math.max(min, Math.min(max, val));
        if (filterState.value.priceMax != null && val > filterState.value.priceMax)
            filterState.value.priceMax = val;
        filterState.value.priceMin = val;
    }

    function normalizeMax() {
        const min = Number(minPrice.value ?? 0);
        const max = Number(maxPrice.value ?? 0);
        let val = Math.round((filterState.value.priceMax ?? max) / STEP) * STEP;
        val = Math.max(min, Math.min(max, val));
        if (filterState.value.priceMin != null && val < filterState.value.priceMin)
            filterState.value.priceMin = val;
        filterState.value.priceMax = val;
    }

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
        { value: 'price_asc', label: 'Цена: по возрастанию' },
        { value: 'price_desc', label: 'Цена: по убыванию' },
        { value: 'date_new', label: 'По новизне' },
    ];
</script>

<style lang="scss" scoped>
    .catalog-filters {
        .cf__form {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            align-items: flex-start;
        }

        .cf__item {
            min-width: 180px;
        }

        .cf-checkbox {
            display: inline-flex;
            gap: 0.5rem;
            align-items: center;
            input {
                width: 18px;
                height: 18px;
            }
        }

        .cf__options {
            max-height: 220px;
            overflow-y: auto;
            border: 1px solid #e6e6e6;
            padding: 0.5rem;
            border-radius: 6px;
            background: #fff;
        }

        .cf-option {
            display: flex;
            gap: 0.5rem;
            align-items: center;
            padding: 0.2rem 0;
            input {
                width: 16px;
                height: 16px;
            }
        }

        /* Range */
        .cf-range {
            position: relative;
            width: 280px;
            height: 48px;
            padding-top: 8px;
        }

        input[type='range'].cf-range__input {
            -webkit-appearance: none;
            appearance: none;
            position: absolute;
            left: 0;
            right: 0;
            top: 12px;
            height: 0;
            background: transparent;
            pointer-events: none;
        }

        input[type='range']::-webkit-slider-thumb {
            -webkit-appearance: none;
            appearance: none;
            pointer-events: auto;
            width: 16px;
            height: 16px;
            border-radius: 50%;
            background: #c43e3e;
            cursor: pointer;
            border: 2px solid #fff;
            box-shadow: 0 0 0 2px rgba(0, 0, 0, 0.05);
        }

        .cf-range__track {
            position: absolute;
            left: 0;
            right: 0;
            top: 18px;
            height: 6px;
            background: #eee;
            border-radius: 6px;
        }

        .cf-range__active {
            position: absolute;
            top: 0;
            bottom: 0;
            background: #c43e3e;
            border-radius: 6px;
        }

        .cf-range__values {
            margin-top: 34px;
            display: flex;
            justify-content: space-between;
            font-size: 0.9rem;
            color: #333;
        }

        select {
            padding: 0.45rem 0.6rem;
            border-radius: 6px;
            border: 1px solid #ddd;
            background: #fff;
        }

        .cf-reset {
            background: transparent;
            border: 1px solid #ddd;
            padding: 0.35rem 0.6rem;
            border-radius: 6px;
            cursor: pointer;
        }
    }
</style>
