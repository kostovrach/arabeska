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
                        <span class="catalog-head__counter">({{ products?.length }})</span>
                    </div>
                    <div class="catalog-head__controls">
                        <div class="catalog-head__filters"></div>
                        <div class="catalog-head__price"></div>
                        <div class="catalog-head__sort"></div>
                    </div>
                </div>
            </div>
            <div class="catalog-list">
                <div class="catalog-list__container">
                    <ul class="catalog-list__body">
                        <li
                            v-for="product in products"
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
    // types ==============================================
    import type { TypeCategories } from '~/types/catrgories';
    // ====================================================

    const route = useRoute();

    const catalogStore = useCatalogStore();

    catalogStore.getCatalogItems(route.params.category as TypeCategories);

    const { catalogList } = storeToRefs(catalogStore);

    const products = computed(() => {
        return catalogList.value;
    });
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .catalog-nav {
        background-color: $c-accent;
        padding: rem(4) 0;
        &__container {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: lineScale(32, 16, 480, 1440);
            @include content-container;
        }
        &__link {
            font-size: lineScale(20, 14, 480, 1440);
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
    }

    .catalog-list {
        @include content-block;
        &__container {
            @include content-container;
        }
        &__body {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(rem(385), 1fr));
            gap: rem(32) rem(16);
            @media (max-width: 540px) {
                grid-template-columns: repeat(auto-fill, minmax(rem(280), 1fr));
            }
        }
        &__item {
            &-card {
                width: 100%;
            }
        }
    }
</style>
