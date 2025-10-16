<template>
    <VueFinalModal
        overlay-transition="vfm-fade"
        content-transition="vfm-slide-up"
        swipe-to-close="up"
        :z-index-fn="({ index }: { index: number }) => 9 + 1 * index"
    >
        <div class="catalog">
            <div class="catalog__container">
                <div class="catalog__body">
                    <NuxtLink
                        v-for="(card, idx) in catalogCards"
                        :key="idx"
                        class="catalog__item"
                        :to="{ name: card.routeName, params: card.routeParams }"
                    >
                        <picture class="catalog__item-image-container">
                            <img class="catalog__item-image" :src="card.image" :alt="card.label" />
                        </picture>
                        <div class="catalog__item-wrapper">
                            <p class="catalog__item-title">{{ card.label }}</p>
                        </div>
                    </NuxtLink>
                </div>
                <div class="catalog__footer">
                    <button class="catalog__button" type="button" @click="emit('close')"></button>
                </div>
            </div>
        </div>
    </VueFinalModal>
</template>

<script setup lang="ts">
    import { VueFinalModal } from 'vue-final-modal';
    // types =========================================================
    import type { RouteParamsRawGeneric } from 'vue-router';
    interface ICatalogCard {
        image: string;
        label: string;
        routeName: string;
        routeParams?: RouteParamsRawGeneric;
    }
    // ===============================================================

    const emit = defineEmits<{
        (e: 'close'): void;
    }>();

    const catalogCards: ICatalogCard[] = [
        {
            image: '/img/temp/temp1.jpg',
            label: 'Букеты',
            routeName: 'catalog-category',
            routeParams: {
                category: 'flowers',
            },
        },
        {
            image: '/img/temp/temp1.jpg',
            label: 'Цветы оптом',
            routeName: 'index',
        },
        {
            image: '/img/temp/temp1.jpg',
            label: 'Сертификаты',
            routeName: 'catalog-category',
            routeParams: {
                category: 'certificates',
            },
        },
        {
            image: '/img/temp/temp1.jpg',
            label: 'Открытки',
            routeName: 'catalog-category',
            routeParams: {
                category: 'accessory',
            },
        },
    ];
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .catalog {
        $p: &;

        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        color: $c-FFFFFF;
        background-color: $c-secondary;
        &__container {
            @include content-container;
        }
        &__body {
            display: flex;
            align-items: center;
            gap: lineScale(32, 16, 480, 1440);
            margin-top: rem(96);
            overflow-x: auto;
            user-select: none;
            @include hide-scrollbar;
        }
        &__item {
            flex: 1;
            min-width: rem(320);
            position: relative;
            aspect-ratio: 1.5/1;
            border-radius: rem(32);
            overflow: hidden;
            @media (pointer: fine) {
                &:hover {
                    #{$p}__item {
                        &-wrapper {
                            backdrop-filter: none;
                        }
                        &-image-container {
                            scale: 1.1;
                        }
                    }
                }
            }
            &-wrapper {
                position: relative;
                z-index: 2;
                width: 100%;
                height: 100%;
                padding: rem(32);
                backdrop-filter: blur(5px) brightness(80%);
                transition: backdrop-filter $td $tf;
            }
            &-image-container {
                position: absolute;
                z-index: 1;
                inset: 0;
                transition: scale $td $tf;
            }
            &-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            &-title {
                font-size: lineScale(40, 24, 480, 1440);
                font-weight: $fw-semi;
                text-shadow: 1px 1px 1px $c-secondary;
            }
        }
        &__footer {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        &__button {
            cursor: pointer;
            position: relative;
            width: rem(64);
            aspect-ratio: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            @media (pointer: fine) {
                &:hover {
                    &::before {
                        rotate: -30deg;
                        translate: rem(4) 0;
                    }
                    &::after {
                        rotate: 30deg;
                        translate: rem(-4) 0;
                    }
                }
            }
            &::before,
            &::after {
                content: '';
                display: block;
                width: rem(32);
                height: rem(4);
                background-color: $c-FFFFFF;
                border-radius: rem(32);
                transition: all $td $tf;
            }
            &::before {
                rotate: -15deg;
                transform-origin: left;
                transform: translateX(rem(2));
            }
            &::after {
                rotate: 15deg;
                transform-origin: right;
                transform: translateX(rem(-2));
            }
        }
    }
</style>
