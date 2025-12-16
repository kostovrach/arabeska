<template>
    <section class="hint-slider" v-if="products?.length">
        <div class="hint-slider__container">
            <div class="hint-slider__titlebox">
                <StarsOverlay v-if="props.title" class="hint-slider__title">
                    <h2 v-html="props.title"></h2>
                </StarsOverlay>
                <div class="hint-slider__controls">
                    <button
                        class="hint-slider__button hint-slider__button--prev"
                        type="button"
                        @click="scrollPrev()"
                    >
                        <SvgSprite type="arrow" />
                    </button>
                    <button
                        class="hint-slider__button hint-slider__button--next"
                        type="button"
                        @click="scrollNext()"
                    >
                        <SvgSprite type="arrow" />
                    </button>
                </div>
            </div>
            <div class="hint-slider__body">
                <div v-show="status === 'pending'" class="hint-slider__loader">
                    <div class="hint-slider__loader-wrapper">
                        <ProductCardLoader v-for="n in 5" :key="n" />
                    </div>
                </div>
                <div v-show="status === 'error' || status === 'idle'" class="hint-slider__error">
                    <FetchError />
                </div>
                <ClientOnly>
                    <EmblaContainer
                        v-show="status === 'success'"
                        ref="sliderRef"
                        :options="carouselOptions"
                        padding="48px 0"
                    >
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
                </ClientOnly>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    // types==================================================
    import type { EmblaCarouselType, EmblaOptionsType } from 'embla-carousel';
    // =======================================================

    // data ==================================================
    const props = defineProps<{
        title?: string;
    }>();

    const productsStore = useProductsStore();

    productsStore.getProducts();

    const products = computed(() => productsStore.productsList.filter((el) => el.popular));
    const status = computed(() => productsStore.productsStatus);
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

    const scrollPrev = () => sliderRef?.value?.emblaApi?.scrollPrev();
    const scrollNext = () => sliderRef?.value?.emblaApi?.scrollNext();

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
        &__slide {
            margin-right: 0;
        }
    }
</style>
