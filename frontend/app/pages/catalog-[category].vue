<template>
    <NuxtLayout>
        <div class="catalog-nav">
            <EmblaContainer
                class="catalog-nav__container"
                :options="{
                    align: 'start',
                    dragFree: true,
                }"
            >
                <EmblaSlide v-for="item in categories" :key="item.id">
                    <NuxtLink
                        :class="[
                            'catalog-nav__link',
                            route.params.category === slugify(item.name)
                                ? 'catalog-nav__link--current'
                                : '',
                        ]"
                        :to="{ name: route.name, params: { category: slugify(item.name) } }"
                    >
                        {{ item.name }}
                    </NuxtLink>
                </EmblaSlide>
            </EmblaContainer>
        </div>
        <div class="catalog-head">
            <div class="catalog-head__container">
                <div class="catalog-head__titlebox">
                    <h1 class="catalog-head__title">
                        {{ pageTitle ?? 'Сборные букеты с доставкой в Самаре' }}
                    </h1>
                    <span v-if="products.length" class="catalog-head__counter">
                        ({{ products.length }})
                    </span>
                </div>
                <TheFilters :render-condition="filtersAvailable" />
            </div>
        </div>
        <div class="catalog-list">
            <div class="catalog-list__container">
                <ul class="catalog-list__body">
                    <li v-for="product in products" :key="product.id" class="catalog-list__item">
                        <ProductCard class="catalog-list__item-card" :data="product" />
                    </li>
                </ul>
            </div>
        </div>
    </NuxtLayout>
</template>

<script setup lang="ts">
    // types ===================================================================
    import type { ICategories } from '~~/interfaces/categories';
    // =========================================================================

    // data ====================================================================
    const route = useRoute();

    const { content: categoriesRaw } = useCms<ICategories[]>('categories');
    const categories = computed(() => categoriesRaw.value?.filter((el) => el.available === true));

    const products = computed(() =>
        useFiltersStore().filteredProducts(route.params.category as string)
    );

    const pageTitle = computed(() => {
        const coincidence = categories.value?.find(
            (el) => slugify(el.name) === slugify(route.params.category as string)
        );

        if (coincidence) return coincidence?.title;
        else return null;
    });

    const filtersAvailable = computed(() => {
        const coincidence = categories.value?.find(
            (el) => slugify(el.name) === slugify(route.params.category as string)
        );

        if (coincidence) return coincidence?.filters;
        else return false;
    });

    // =========================================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .catalog-nav {
        width: 100%;
        background-color: $c-accent;
        padding: rem(4) 0;
        &__container {
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
        margin: rem(64) 0 rem(32) 0;
        &__container {
            @include content-container;
        }
        &__titlebox {
            display: flex;
            align-items: flex-start;
            margin-bottom: rem(64);
        }
        &__title {
            width: fit-content;
            position: relative;
            font-size: lineScale(64, 32, 480, 1440);
            font-weight: $fw-semi;
            text-wrap: balance;
        }
        &__counter {
            font-family: 'Inter', sans-serif;
            font-size: lineScale(24, 18, 480, 1440);
        }
    }

    .catalog-list {
        margin: 0 0 rem(128);
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
