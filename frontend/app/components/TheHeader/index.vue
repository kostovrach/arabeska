<template>
    <header class="header">
        <div class="header__container">
            <div class="header__overview">
                <NuxtLink class="header__logo" :to="{ name: 'index' }">
                    <div class="header__logo-image--desktop">
                        <SvgSprite type="logo-full" size="100%" />
                    </div>
                    <div class="header__logo-image--touch">
                        <SvgSprite type="logo-icon" size="100%" />
                    </div>
                </NuxtLink>
                <div class="header__dropdown">
                    <button class="header__dropdown-button" type="button" @click="openCatalog">
                        <SvgSprite type="frame" :size="12" />
                        <span>Каталог</span>
                    </button>
                    <div class="header__dropdo-__body"></div>
                </div>
                <nav class="header__nav">
                    <NuxtLink
                        v-for="(category, idx) in hintCategories"
                        :key="idx"
                        class="header__nav-link"
                        :to="{
                            name: 'catalog-category',
                            params: { category: slugify(category.name) },
                        }"
                    >
                        <span>{{ category.name }}</span>
                    </NuxtLink>
                </nav>
            </div>
            <div class="header__controls">
                <div class="header__location">
                    <SvgSprite type="map-pin" :size="20" />
                    <span>Самара</span>
                </div>
                <a
                    class="header__number"
                    :href="`tel:${contacts?.phone.trim().replace(/\s+/g, '')}`"
                >
                    {{ contacts?.phone }}
                </a>
                <ClientOnly>
                    <button
                        v-if="useProductsStore().productsList?.length"
                        class="header__action header__action-searchbar"
                        type="button"
                        @click="openSearchbar"
                    >
                        <SvgSprite type="search" :size="24" />
                    </button>
                </ClientOnly>
                <NuxtLink class="header__action header__action--profile" :to="{ name: 'profile' }">
                    <SvgSprite type="user" :size="24" />
                </NuxtLink>
                <NuxtLink class="header__action header__action--cart" :to="{ name: 'cart' }">
                    <SvgSprite type="bag" :size="24" />
                    <ClientOnly>
                        <span class="header__action-indicator" v-if="cartCounter >= 1">
                            {{ cartCounter }}
                        </span>
                    </ClientOnly>
                </NuxtLink>
                <TheHeaderBurger class="header__burger" @click="openMenu" />
            </div>
        </div>
    </header>
</template>

<script setup lang="ts">
    // types ===============================================================================
    import type { ICategories } from '~~/interfaces/categories';
    // =====================================================================================

    import { ModalsSearchbar, ModalsSideMenu, ModalsCatalog } from '#components';
    import { useModal } from 'vue-final-modal';
    import type { IContacts } from '~~/interfaces/contacts';

    // data ================================================================================
    const route = useRoute();

    const cartStore = useCartStore();
    const cartCounter = computed(() => cartStore.cartCount);

    const { content: categoriesRaw } = await useCms<ICategories[]>('categories');

    const categories = computed(() => categoriesRaw.value?.filter((el) => el.available === true));

    const hintCategories = computed(() =>
        categories.value?.filter((el) => slugify(el.name) !== route.params.category).slice(0, 3)
    );

    const { content: contacts } = await useCms<IContacts>('contact');

    // =====================================================================================

    // modals ==============================================================================
    const { open: openSearchbar, close: closeSearchbar } = useModal({
        component: ModalsSearchbar,
        attrs: {
            onClose() {
                closeSearchbar();
            },
        },
    });
    const { open: openMenu, close: closeMenu } = useModal({
        component: ModalsSideMenu,
        attrs: {
            onClose() {
                closeMenu();
            },
        },
    });
    const { open: openCatalog, close: closeCatalog } = useModal({
        component: ModalsCatalog,
        attrs: {
            onClose() {
                closeCatalog();
            },
        },
    });
    // =====================================================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .header {
        $p: &;

        position: sticky;
        top: 0;
        z-index: 10;
        width: 100%;
        color: $c-98BBD7;
        background-color: $c-secondary;
        padding: rem(16) 0;
        &__container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: lineScale(32, 16, 480, 1440);
            @include content-container;
        }

        // left bar
        &__overview {
            display: flex;
            align-items: center;
            gap: lineScale(16, 8, 480, 1440);
            font-size: rem(14);
            font-weight: $fw-semi;
        }
        &__logo {
            width: fit-content;
            color: $c-accent;
            translate: 0 rem(-4);
            @media (pointer: fine) {
                &:hover {
                    color: $c-FFFFFF;
                }
            }
            &-image {
                &--desktop {
                    width: rem(250);
                    height: rem(40);
                    @media (max-width: 1024px) {
                        display: none;
                    }
                }
                &--touch {
                    width: rem(50);
                    height: rem(32);
                    @media (min-width: 1025px) {
                        display: none;
                    }
                }
            }
        }
        &__dropdown {
            &-button {
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: rem(8);
                color: $c-D4E1E7;
                @include frame-scale;
            }
        }
        &__nav {
            display: flex;
            align-items: center;
            &-link {
                @include frame-scale($anim-color: $c-98BBD7);
                &--current {
                    display: none;
                }
            }
        }

        // right bar
        &__controls {
            display: flex;
            align-items: center;
            gap: lineScale(16, 8, 480, 1440);
            font-weight: $fw-semi;
        }
        &__number {
            font-family: 'Inter', sans-serif;
            font-size: lineScale(16, 14, 480, 1440);
            @media (pointer: fine) {
                &:hover {
                    opacity: 0.5;
                }
            }
        }
        &__location {
            cursor: default;
            display: flex;
            align-items: center;
            gap: rem(4);
            font-size: rem(12);
            opacity: 0.5;
        }
        &__action {
            position: relative;
            cursor: pointer;
            aspect-ratio: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            @include frame-scale($border-radius: 0, $padding: rem(8), $finally-border-radius: 50%);
            @media (pointer: fine) {
                &:hover {
                    #{$p}__action-indicator {
                        color: $c-accent;
                        background-color: $c-secondary;
                        border-color: $c-accent;
                    }
                }
            }
            &-indicator {
                position: absolute;
                z-index: 2;
                top: rem(-4);
                right: rem(-6);
                display: flex;
                align-items: center;
                justify-content: center;
                min-height: rem(18);
                aspect-ratio: 1;
                font-size: rem(10);
                color: $c-FFFFFF;
                padding: rem(4);
                border-radius: 50%;
                border: rem(0.25) solid transparent;
                background-color: $c-accent;
                will-change: border-color;
                transition: all $td $tf;
            }
        }
    }

    @media (max-width: 1300px) {
        .header {
            &__location,
            &__number {
                display: none;
            }
        }
    }
    @media (max-width: 768px) {
        .header {
            &__nav {
                display: none;
            }
        }
    }
</style>
