<template>
    <ClientOnly>
        <section class="views-slider" v-if="products?.length">
            <div class="views-slider__container">
                <div class="views-slider__body">
                    <EmblaContainer ref="sliderRef" :options="carouselOptions" padding="48px 0">
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
                </div>
                <div class="views-slider__titlebox">
                    <StarsOverlay class="views-slider__title">
                        <h2>Вы недавно смотрели</h2>
                    </StarsOverlay>
                    <div class="views-slider__controls">
                        <EmblaNavigation :slider-ref="computed(() => sliderRef)" />
                    </div>
                    <button
                        class="views-slider__cls-button"
                        type="button"
                        @click.prevent="clearViews"
                    >
                        Очистить историю
                    </button>
                </div>
            </div>
        </section>
    </ClientOnly>
</template>

<script setup lang="ts">
    import type { EmblaCarouselType, EmblaOptionsType } from 'embla-carousel';

    // data ==================================================
    const props = defineProps<{
        title?: string;
    }>();

    const productsStore = useProductsStore();
    const viewsStore = useViewsStore();

    const products = computed(() => {
        const views = new Set(viewsStore.viewsProducts);

        return productsStore.products.filter((el) => views.has(el.id.toString()));
    });
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
