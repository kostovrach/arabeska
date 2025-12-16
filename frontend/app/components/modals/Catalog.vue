<template>
    <VueFinalModal
        overlay-transition="vfm-fade"
        content-transition="vfm-slide-up"
        swipe-to-close="up"
    >
        <div class="catalog">
            <div class="catalog__container">
                <EmblaContainer class="catalog__body" :options="{ dragFree: true }">
                    <EmblaSlide
                        v-for="(card, idx) in categories"
                        :key="idx"
                        :class="
                            route.name === 'catalog-category' &&
                            route.params.category === slugify(card.name)
                                ? 'catalog__item catalog__item--current'
                                : 'catalog__item'
                        "
                    >
                        <NuxtLink
                            :to="{
                                name: 'catalog-category',
                                params: { category: slugify(card.name) },
                            }"
                        >
                            <picture class="catalog__item-image-container">
                                <img
                                    class="catalog__item-image"
                                    :src="card.image_url ?? '/img/service/flowers.jpg'"
                                    :alt="card.name"
                                />
                            </picture>
                            <div class="catalog__item-wrapper">
                                <p class="catalog__item-title">{{ card.name }}</p>
                            </div>
                        </NuxtLink>
                    </EmblaSlide>
                </EmblaContainer>
                <div class="catalog__footer">
                    <button class="catalog__button" type="button" @click="emit('close')"></button>
                </div>
            </div>
        </div>
    </VueFinalModal>
</template>

<script setup lang="ts">
    import { VueFinalModal } from 'vue-final-modal';
    import type { ICategories } from '~~/interfaces/categories';

    const { content: categoriesRaw } = await useCms<ICategories[]>('categories');
    const categories = computed(() => categoriesRaw.value?.filter((el) => el.available === true));

    const route = useRoute();

    const emit = defineEmits<{
        (e: 'close'): void;
    }>();
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
        border-radius: 0 0 rem(32) rem(32);
        &__container {
            @include content-container($padding: 0);
        }
        &__body {
            padding: 0 rem(32);
            margin: rem(32) 0 rem(16) 0;
            @supports (mask-image: url()) {
                mask-image: linear-gradient(
                    90deg,
                    transparent 0%,
                    #000 5%,
                    #000 95%,
                    transparent 100%
                );
            }
        }
        &__item {
            flex: 1;
            min-width: rem(360);
            max-width: rem(360);
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
            &:focus-within {
                #{$p}__item {
                    &-wrapper {
                        backdrop-filter: none;
                    }
                    &-image-container {
                        scale: 1.1;
                    }
                }
            }
            &--current {
                pointer-events: none;
                opacity: 0.5;
            }
            &-wrapper {
                position: relative;
                z-index: 2;
                width: 100%;
                height: 100%;
                padding: lineScale(32, 16, 480, 1440);
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
            transition: all $td $tf 0s;
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
            &:active {
                scale: 0.95;
                opacity: 0.5;
                &::before {
                    rotate: -20deg;
                    translate: rem(1) 0;
                }
                &::after {
                    rotate: 20deg;
                    translate: rem(-1) 0;
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

    @media (max-width: 768px) {
        .catalog {
            &__item {
                max-width: rem(240);
                min-width: rem(240);
            }
        }
    }
</style>
