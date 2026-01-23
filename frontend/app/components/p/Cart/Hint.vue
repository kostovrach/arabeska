<template>
    <section class="cart-hint-slider" v-if="products?.length">
        <div class="cart-hint-slider__container">
            <div class="cart-hint-slider__body">
                <EmblaContainer
                    ref="sliderRef"
                    :options="{ loop: true, align: 'center', dragFree: true, duration: 25 }"
                    padding="36px 0"
                >
                    <EmblaSlide
                        v-for="product in products"
                        :key="product.id"
                        class="cart-hint-slider__slide"
                    >
                        <ProductCard :data="product" compact />
                    </EmblaSlide>
                </EmblaContainer>
            </div>
            <div class="cart-hint-slider__titlebox">
                <StarsOverlay v-if="props.title" class="cart-hint-slider__title">
                    <h2 v-html="props.title"></h2>
                </StarsOverlay>
                <div class="cart-hint-slider__controls">
                    <EmblaNavigation :slider-ref="computed(() => sliderRef)" />
                </div>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    import type { EmblaCarouselType } from 'embla-carousel';

    const props = withDefaults(
        defineProps<{
            title?: string | null;
        }>(),
        {
            title: null,
        }
    );

    const productsStore = useProductsStore();

    const products = computed(() => productsStore.products.filter((el) => el.popular === true));

    const sliderRef = ref<{ emblaApi: EmblaCarouselType | null } | null>(null);
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .cart-hint-slider {
        $p: &;

        &__container {
            display: flex;
            flex-direction: column-reverse;
        }
        &__titlebox {
            width: 100%;
            display: flex;
            flex-direction: column;
            gap: rem(32);
        }
        &__title {
            max-width: 20ch;
            justify-self: center;
            font-size: lineScale(32, 20, 480, 1440);
            font-weight: $fw-semi;
            text-align: center;
        }
        &__controls {
            display: flex;
            align-items: center;
            gap: rem(24);
        }
        &__loader {
            width: 100%;
            overflow: hidden;
            padding: rem(40) 0;
            &-wrapper {
                min-width: max-content;
            }
        }
        &__slide {
            margin-right: rem(16);
        }
    }
</style>
