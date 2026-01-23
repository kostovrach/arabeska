<template>
    <section class="hint-slider" v-if="products?.length">
        <div class="hint-slider__container">
            <div class="hint-slider__body">
                <EmblaContainer ref="sliderRef" :options="carouselOptions" padding="48px 0">
                    <EmblaSlide
                        v-for="(product, idx) in products"
                        :key="product.id"
                        class="hint-slider__slide"
                        :class="{ 'hint-slider__slide--active': idx === selectedIndex }"
                    >
                        <ProductCard
                            :data="product"
                            :dynamic="{
                                enable: true,
                                class: idx === selectedIndex ? 'active' : 'disable',
                            }"
                        />
                    </EmblaSlide>
                </EmblaContainer>
            </div>
            <div class="hint-slider__titlebox">
                <StarsOverlay v-if="props.title" class="hint-slider__title">
                    <h2 v-html="props.title"></h2>
                </StarsOverlay>
                <div class="hint-slider__controls">
                    <EmblaNavigation :slider-ref="computed(() => sliderRef)" />
                </div>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    // types==================================================
    import type { EmblaCarouselType, EmblaOptionsType } from 'embla-carousel';
    // =======================================================

    const productsStore = useProductsStore();

    // data ==================================================
    const props = withDefaults(
        defineProps<{
            title?: string | null;
        }>(),
        {
            title: null,
        }
    );

    const products = computed(() => productsStore.products.filter((el) => el.popular));
    // =======================================================

    // slider=================================================
    const sliderRef = ref<{ emblaApi: EmblaCarouselType | null } | null>(null);
    const selectedIndex = ref(0);

    const carouselOptions: EmblaOptionsType = {
        loop: true,
        align: 'center',
        dragFree: false,
        duration: 25,
    };

    watchEffect((onCleanup) => {
        const slider = sliderRef.value?.emblaApi;

        if (!slider) return;

        const updSelected = () => {
            selectedIndex.value = slider.selectedScrollSnap();
        };

        slider.on('select', updSelected);
        slider.on('init', updSelected);

        updSelected();

        onCleanup(() => {
            slider.off('select', updSelected);
            slider.off('init', updSelected);
        });
    });
    //========================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .hint-slider {
        $p: &;

        @include content-block;
        &__container {
            display: flex;
            flex-direction: column-reverse;
        }
        &__titlebox {
            width: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: rem(32);
        }
        &__title {
            max-width: 20ch;
            justify-self: center;
            font-size: lineScale(48, 24, 480, 1440);
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
        &__button {
            @include slider-buttons;
        }
    }
</style>
