<template>
    <section class="views-slider" v-if="products?.length">
        <div class="views-slider__container">
            <div class="views-slider__titlebox">
                <StarsOverlay class="views-slider__title">
                    <h2>Вы недавно смотрели</h2>
                </StarsOverlay>
                <div class="views-slider__controls">
                    <button
                        class="views-slider__button views-slider__button--prev"
                        type="button"
                        @click="scrollPrev()"
                    >
                        <SvgSprite type="arrow" />
                    </button>
                    <button
                        class="views-slider__button views-slider__button--next"
                        type="button"
                        @click="scrollNext()"
                    >
                        <SvgSprite type="arrow" />
                    </button>
                </div>
                <button class="views-slider__cls-button" type="button" @click.prevent="clearViews">
                    Очистить историю
                </button>
            </div>
            <div class="views-slider__body">
                <div v-show="status === 'pending'" class="views-slider__loader">
                    <div class="views-slider__loader-wrapper">
                        <ProductCardLoader v-for="n in 5" :key="n" />
                    </div>
                </div>
                <div v-show="status === 'error' || status === 'idle'" class="views-slider__error">
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
                            class="views-slider__slide"
                            :class="{ 'views-slider__slide--active': idx === selectedIndex }"
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
    const viewsStore = useViewsStore();

    productsStore.getProducts();

    const products = computed(() => {
        const views = new Set(viewsStore.viewsProducts);

        return productsStore.productsList.filter((el) => views.has(el.id.toString()));
    });
    const status = computed(() => productsStore.productsStatus);
    // =======================================================

    // methods ===============================================
    const clearViews = (): void => viewsStore.clearViews();
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

    .views-slider {
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
        &__cls-button {
            cursor: pointer;
            align-self: flex-end;
            font-family: 'Inter', sans-serif;
            font-weight: $fw-semi;
            font-size: rem(14);
            padding: 0 rem(16);
            opacity: 0.5;
            @media (pointer: fine) {
                &:hover {
                    opacity: 0.7;
                }
            }
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
