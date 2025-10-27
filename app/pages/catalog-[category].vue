<template>
    <NuxtLayout>
        <ClientOnly>
            <nav class="catalog-nav">
                <div class="catalog-nav__container">
                    <NuxtLink
                        :class="[
                            'catalog-nav__link',
                            route.params.category === 'flowers' ? 'catalog-nav__link--current' : '',
                        ]"
                        :to="{ name: route.name, params: { category: 'flowers' } }"
                    >
                        букеты
                    </NuxtLink>
                    <NuxtLink
                        :class="[
                            'catalog-nav__link',
                            route.params.category === 'certificates'
                                ? 'catalog-nav__link--current'
                                : '',
                        ]"
                        :to="{ name: route.name, params: { category: 'certificates' } }"
                    >
                        сертификаты
                    </NuxtLink>
                    <NuxtLink
                        :class="[
                            'catalog-nav__link',
                            route.params.category === 'accessory'
                                ? 'catalog-nav__link--current'
                                : '',
                        ]"
                        :to="{ name: route.name, params: { category: 'accessory' } }"
                    >
                        дополнительно к букету
                    </NuxtLink>
                </div>
            </nav>
            <div class="catalog-head">
                <div class="catalog-head__container">
                    <div class="catalog-head__titlebox">
                        <h2 v-if="route.params.category === 'flowers'" class="catalog-head__title">
                            Сборные букеты с доставкой в Самаре
                        </h2>
                        <h2
                            v-if="route.params.category === 'certificates'"
                            class="catalog-head__title"
                        >
                            Подарочные сертификаты
                        </h2>
                        <h2
                            v-if="route.params.category === 'accessory'"
                            class="catalog-head__title"
                        >
                            Дополнительные товары и аксессуары
                        </h2>
                        <span class="catalog-head__counter">({{ filteredProducts?.length }})</span>
                    </div>

                    <div v-if="route.params.category === 'flowers'" class="catalog-head__controls">
                        <div class="catalog-head__filterbox">
                            <!-- Popular filter -->
                            <label class="catalog-head__filter-singleton">
                                <input v-model="isPopular" type="checkbox" />
                                Популярные
                            </label>

                            <!-- Discount filter -->
                            <label class="catalog-head__filter-singleton">
                                <input v-model="isDiscounted" type="checkbox" />
                                Акции
                            </label>

                            <!-- Flower filter -->
                            <div class="catalog-head__filter-group">
                                <button
                                    class="catalog-head__filter-group-button"
                                    @click="showFlowerDropdown = !showFlowerDropdown"
                                >
                                    <div class="catalog-head__filter-group-label">
                                        Цветы
                                        <span v-show="selectedFlowers.length">
                                            ({{ selectedFlowers.length }})
                                        </span>
                                    </div>
                                    <span class="catalog-head__filter-group-icon">
                                        <SvgSprite type="chevron" :size="12" />
                                    </span>
                                </button>
                                <div
                                    v-if="showFlowerDropdown"
                                    class="catalog-head__filter-group-dropdown"
                                >
                                    <label
                                        v-for="flower in flowerOptions"
                                        :key="flower"
                                        class="catalog-head__filter-group-item"
                                    >
                                        <input
                                            v-model="selectedFlowers"
                                            type="checkbox"
                                            :value="flower"
                                        />
                                        {{ flower }}
                                    </label>
                                </div>
                            </div>

                            <!-- Reason filter -->
                            <div class="catalog-head__filter-group">
                                <button
                                    class="catalog-head__filter-group-button"
                                    @click="showReasonDropdown = !showReasonDropdown"
                                >
                                    <div class="catalog-head__filter-group-label">
                                        Повод
                                        <span v-show="selectedReasons.length">
                                            ({{ selectedReasons.length }})
                                        </span>
                                    </div>
                                    <span class="catalog-head__filter-group-icon">
                                        <SvgSprite type="chevron" :size="12" />
                                    </span>
                                </button>
                                <div
                                    v-if="showReasonDropdown"
                                    class="catalog-head__filter-group-dropdown"
                                >
                                    <label
                                        v-for="reason in reasonOptions"
                                        :key="reason"
                                        class="catalog-head__filter-group-item"
                                    >
                                        <input
                                            v-model="selectedReasons"
                                            type="checkbox"
                                            :value="reason"
                                        />
                                        {{ reason }}
                                    </label>
                                </div>
                            </div>

                            <!-- Style filter -->
                            <div class="catalog-head__filter-group">
                                <button
                                    class="catalog-head__filter-group-button"
                                    @click="showStyleDropdown = !showStyleDropdown"
                                >
                                    <div class="catalog-head__filter-group-label">
                                        Стиль
                                        <span v-show="selectedStyles.length">
                                            ({{ selectedStyles.length }})
                                        </span>
                                    </div>
                                    <span class="catalog-head__filter-group-icon">
                                        <SvgSprite type="chevron" :size="12" />
                                    </span>
                                </button>
                                <div
                                    v-if="showStyleDropdown"
                                    class="catalog-head__filter-group-dropdown"
                                >
                                    <label
                                        v-for="style in styleOptions"
                                        :key="style"
                                        class="catalog-head__filter-group-item"
                                    >
                                        <input
                                            v-model="selectedStyles"
                                            type="checkbox"
                                            :value="style"
                                        />
                                        {{ style }}
                                    </label>
                                </div>
                            </div>
                            <button
                                class="catalog-head__filter-reset"
                                :disabled="!isAnyFilterApplied"
                                @click="resetAllFilters"
                            >
                                <SvgSprite type="refresh" :size="18" />
                            </button>
                        </div>

                        <!-- Price range filter -->
                        <div class="catalog-head__range">
                            <span class="catalog-head__range-title">Цена</span>
                            <div class="catalog-head__range-label">
                                <div>
                                    {{ priceRange.min }}
                                    <span class="ruble"></span>
                                </div>
                                <div>
                                    {{ priceRange.max }}
                                    <span class="ruble"></span>
                                </div>
                            </div>
                            <div class="catalog-head__range-inputbox">
                                <input
                                    v-model.number="priceRange.min"
                                    type="range"
                                    :min="0"
                                    :max="priceRange.max"
                                    step="100"
                                />
                                <input
                                    v-model.number="priceRange.max"
                                    type="range"
                                    :min="priceRange.min"
                                    :max="10000"
                                    step="100"
                                />
                            </div>
                        </div>

                        <!-- Sort options -->
                        <div class="catalog-head__sort">
                            <select v-model="sortOrder" class="catalog-head__sort-select">
                                <option :value="null">Без сортировки</option>
                                <option value="asc">По возрастанию цены</option>
                                <option value="desc">По убыванию цены</option>
                            </select>
                            <span class="catalog-head__sort-icon">
                                <SvgSprite type="chevron" :size="16" />
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="catalog-list">
                <div class="catalog-list__container">
                    <ul class="catalog-list__body">
                        <li
                            v-for="product in filteredProducts"
                            :key="product.id"
                            class="catalog-list__item"
                        >
                            <ProductCard class="catalog-list__item-card" :data="product" />
                        </li>
                    </ul>
                </div>
            </div>
        </ClientOnly>
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { TypeCategories } from '~~/types/categories';

    // Initialize store and fetch data
    const route = useRoute();
    const catalogFilterStore = useCatalogFilterStore();
    catalogFilterStore.getCatalogItems(route.params.category as TypeCategories);
    catalogFilterStore.initFromQuery();

    // Get store refs
    const {
        selectedFlowers,
        isPopular,
        isDiscounted,
        selectedReasons,
        selectedStyles,
        priceRange,
        sortOrder,
        filteredProducts,
    } = storeToRefs(catalogFilterStore);

    // Filter options (static)
    const flowerOptions = ['астры', 'жасмин', 'нарциссы', 'розы', 'гортензия'];
    const reasonOptions = ['свадьба', 'выпускной', 'юбилей'];
    const styleOptions = ['нежный', 'траурный'];

    // Dropdown visibility
    const showFlowerDropdown = ref(false);
    const showReasonDropdown = ref(false);
    const showStyleDropdown = ref(false);

    // Check if any filter is applied
    const isAnyFilterApplied = computed(() => {
        return (
            selectedFlowers.value.length > 0 ||
            isPopular.value ||
            isDiscounted.value ||
            selectedReasons.value.length > 0 ||
            selectedStyles.value.length > 0 ||
            priceRange.value.min > 0 ||
            priceRange.value.max < 10000 ||
            sortOrder.value !== null
        );
    });

    // Reset filters
    const resetAllFilters = () => {
        catalogFilterStore.resetFilters();
        showFlowerDropdown.value = false;
        showReasonDropdown.value = false;
        showStyleDropdown.value = false;
    };
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .catalog-nav {
        width: 100%;
        background-color: $c-accent;
        padding: rem(4) 0;
        overflow-x: auto;
        @include hide-scrollbar;
        &__container {
            display: flex;
            align-items: center;
            gap: lineScale(32, 16, 480, 1440);
            min-width: fit-content;
            @include content-container;
        }
        &__link {
            white-space: nowrap;
            font-size: lineScale(20, 18, 480, 1440);
            @media (pointer: fine) {
                &:hover {
                    color: $c-FFFFFF;
                }
            }
            &--current {
                text-decoration: underline;
                pointer-events: none;
            }
        }
    }

    .catalog-head {
        @include content-block($margin: rem(64));
        &__container {
            @include content-container;
        }
        &__titlebox {
            display: flex;
            align-items: flex-start;
        }
        &__title {
            font-size: lineScale(64, 32, 480, 1440);
            font-weight: $fw-semi;
        }
        &__counter {
            font-family: 'Inter', sans-serif;
            font-size: lineScale(24, 18, 480, 1440);
        }
        &__controls {
            display: grid;
            grid-template-areas:
                'filterbox range'
                '. sort';
            justify-content: space-between;
            align-items: center;
            gap: rem(32) rem(64);
            font-family: 'Inter', sans-serif;
            margin-top: rem(64);
        }
        &__filterbox {
            grid-area: filterbox;
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: rem(8);
            font-size: lineScale(18, 16, 480, 1440);
            font-weight: $fw-semi;
            user-select: none;
        }
        &__filter {
            &-singleton,
            &-group-button {
                cursor: pointer;
                padding: rem(18) rem(16);
                border-radius: rem(32);
                &:focus,
                &:has(input:focus) {
                    outline: none;
                    background-color: rgba($c-secondary, 0.1);
                }
                @media (pointer: fine) {
                    &:hover {
                        background-color: rgba($c-secondary, 0.1);
                    }
                }
            }
            &-singleton {
                &:has(input[type='checkbox']:checked) {
                    color: $c-FFFFFF;
                    background-color: $c-accent;
                    opacity: 1;
                }
            }
            &-group {
                position: relative;
                &-button {
                    display: flex;
                    align-items: center;
                    gap: rem(16);
                }
                &-dropdown {
                    position: absolute;
                    top: 105%;
                    left: 50%;
                    translate: -50% 0;
                    width: rem(350);
                    padding: rem(16);
                    background-color: $c-main;
                    border-radius: rem(32);
                    box-shadow: 1px 1px 5px $c-D4E1E7;
                    display: flex;
                    flex-wrap: wrap;
                    gap: rem(8);
                }
                &-item {
                    cursor: pointer;
                    font-size: rem(16);
                    padding: rem(6) rem(16) rem(6) rem(10);
                    border: rem(1) solid $c-D4E1E7;
                    border-radius: rem(32);
                    @media (pointer: fine) {
                        &:not(:has(input[type='checkbox']:checked)):hover {
                            color: $c-accent;
                            border-color: $c-accent;
                        }
                    }
                    &:has(input[type='checkbox']:checked) {
                        color: $c-FFFFFF;
                        background-color: $c-accent;
                        border-color: $c-accent;
                    }
                }
            }
            &-reset {
                cursor: pointer;
                width: rem(60);
                aspect-ratio: 1;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 50%;
                &:focus {
                    outline: none;
                    background-color: rgba($c-secondary, 0.1);
                }
                @media (pointer: fine) {
                    &:hover {
                        background-color: rgba($c-secondary, 0.1);
                    }
                }
                &:disabled {
                    opacity: 0.6;
                    pointer-events: none;
                }
            }
        }
        &__range {
            grid-area: range;
            display: grid;
            grid-template-areas:
                '. label'
                'title inputbox';
            align-items: center;
            gap: rem(8) rem(32);
            &-title,
            &-label {
                font-size: lineScale(18, 16, 480, 1440);
                font-weight: $fw-semi;
                opacity: 0.5;
            }
            &-title {
                grid-area: title;
            }
            &-inputbox {
                grid-area: inputbox;
                input {
                    appearance: none;
                    height: rem(4);
                    // track
                    &::-webkit-slider-runnable-track {
                        box-sizing: border-box;
                        height: rem(4);
                        background-color: $c-accent;
                    }
                    &::-moz-range-track {
                        box-sizing: border-box;
                        background-color: $c-accent;
                    }
                    // thumb
                    &::-webkit-slider-thumb {
                        cursor: pointer;
                        width: rem(12);
                        aspect-ratio: 1;
                        border-radius: 50%;
                        background-color: $c-accent;
                        translate: 0 rem(-4);
                        @media (pointer: fine) {
                            &:hover {
                                scale: 1.3;
                            }
                        }
                    }
                    &::-moz-range-thumb {
                        cursor: pointer;
                        width: rem(12);
                        aspect-ratio: 1;
                        border-radius: 50%;
                        background-color: $c-accent;
                        @media (pointer: fine) {
                            &:hover {
                                scale: 1.3;
                            }
                        }
                    }
                    // progress
                    &::-moz-range-progress {
                        background-color: $c-accent;
                    }
                    // state
                    &:focus-visible,
                    &:focus {
                        &::-webkit-slider-thumb {
                            scale: 1.3;
                        }
                        &::-moz-range-thumb {
                            scale: 1.3;
                        }
                    }
                }
            }
            &-label {
                grid-area: label;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
        }
        &__sort {
            grid-area: sort;
            position: relative;
            justify-self: flex-end;
            width: rem(334);
            display: flex;
            align-items: center;
            justify-content: space-between;
            border: rem(1) solid $c-D4E1E7;
            border-radius: rem(32);
            overflow: hidden;
            &-select {
                cursor: pointer;
                width: 100%;
                font-size: lineScale(18, 16, 480, 1440);
                color: rgba($c-secondary, 0.8);
                padding: rem(18) rem(24);
                background-color: transparent;
                appearance: none;
                &:focus {
                    outline: none;
                }
                @media (pointer: fine) {
                    &:hover,
                    &:focus {
                        background-color: rgba($c-secondary, 0.1);
                    }
                }
            }
            &-icon {
                position: absolute;
                top: 50%;
                right: rem(24);
                translate: 0 -50%;
                pointer-events: none;
            }
        }
    }

    .catalog-list {
        @include content-block;
        &__container {
            @include content-container;
        }
        &__body {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(rem(320), 1fr));
            gap: lineScale(48, 40, 480, 1440) lineScale(24, 12, 480, 1440);
            @media (max-width: 768px) {
                grid-template-columns: repeat(auto-fill, minmax(rem(185), 1fr));
            }
        }
        &__item {
            &-card {
                width: 100%;
            }
        }
    }
</style>
