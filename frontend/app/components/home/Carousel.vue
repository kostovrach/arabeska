<template>
    <section class="home-carousel">
        <div class="home-carousel__container">
            <div class="home-carousel__titlebox">
                <StarsOverlay class="home-carousel__title">
                    <h2 v-html="props.title"></h2>
                </StarsOverlay>
                <NuxtLink
                    v-if="props.wtithLink"
                    :to="{ name: 'catalog-category', params: { category: props.category } }"
                    class="home-carousel__link"
                >
                    <span>Смотреть все</span>
                    <SvgSprite type="arrow" :size="12" />
                </NuxtLink>
            </div>
            <div class="home-carousel__body">
                <div v-show="status === 'pending'" class="home-carousel__loader">
                    <div class="home-carousel__loader-wrapper">
                        <ProductCardLoader v-for="n in 5" :key="n" />
                    </div>
                </div>
                <div v-show="status === 'error' || status === 'idle'" class="home-carousel__error">
                    <FetchError />
                </div>
                <ClientOnly>
                    <EmblaContainer
                        v-show="status === 'success'"
                        ref="sliderRef"
                        :options="carouselOptions"
                        :autoplay-enable="props.autoplay"
                        :autoplay="autoplayOptions"
                        padding="48px 0"
                    >
                        <EmblaSlide
                            v-for="product in products"
                            :key="product.id"
                            class="home-carousel__slide"
                            @mouseenter="autoplayStop"
                            @mouseleave="autoplayStart"
                        >
                            <ProductCard :data="product" />
                        </EmblaSlide>
                    </EmblaContainer>
                </ClientOnly>

                <div v-if="!props.autoplay" class="home-carousel__controls">
                    <button
                        class="home-carousel__button home-carousel__button--prev"
                        type="button"
                        @click="scrollPrev"
                    >
                        <SvgSprite type="arrow" />
                    </button>
                    <button
                        class="home-carousel__button home-carousel__button--next"
                        type="button"
                        @click="scrollNext"
                    >
                        <SvgSprite type="arrow" />
                    </button>
                </div>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    // types==================================================
    import type { AsyncDataRequestStatus } from '#app';
    import type { IProduct } from '~~/interfaces/entities/product';

    import type { EmblaCarouselType, EmblaOptionsType } from 'embla-carousel';
    import type { AutoplayOptionsType } from 'embla-carousel-autoplay';
    // =======================================================

    interface IProps {
        contentRef: Ref<IProduct[] | null> | ComputedRef<IProduct[] | null>;
        statusRef: Ref<AsyncDataRequestStatus>;
        autoplay?: boolean;
        title?: string;
        wtithLink?: boolean;
        category: string;
    }

    const props = withDefaults(defineProps<IProps>(), {
        title: '',
        wtithLink: true,
        autoplay: false,
    });

    const status = computed(() => props.statusRef.value);
    const products = computed(() => props.contentRef.value ?? []);

    // slider==============================================
    const sliderRef = ref<{ emblaApi: EmblaCarouselType | null } | null>(null);

    const carouselOptions: EmblaOptionsType = {
        loop: true,
        align: 'center',
        dragFree: true,
        duration: props.autoplay ? 20000 : 25,
    };

    const autoplayOptions: AutoplayOptionsType = {
        delay: 0,
        jump: false,
    };

    const scrollPrev = () => {
        if (sliderRef.value?.emblaApi?.canScrollPrev()) {
            sliderRef?.value?.emblaApi?.scrollPrev();
        } else return;
    };
    const scrollNext = () => {
        if (sliderRef.value?.emblaApi?.canScrollNext()) {
            sliderRef?.value?.emblaApi?.scrollNext();
        } else return;
    };

    const autoplayStop = () => {
        if (props.autoplay) {
            sliderRef?.value?.emblaApi?.plugins()?.autoplay?.stop();
        } else return;
    };
    const autoplayStart = () => {
        if (props.autoplay && !sliderRef?.value?.emblaApi?.plugins()?.autoplay) {
            sliderRef?.value?.emblaApi?.plugins()?.autoplay?.play();
        } else return;
    };
    //=====================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .home-carousel {
        @include content-block($margin: lineScale(128, 96, 480, 1440));
        &__container {
            @include content-container($padding: 0);
        }
        &__titlebox {
            display: grid;
            grid-template-columns: 1fr auto 1fr;
            grid-template-rows: repeat(2, auto);
            grid-template-areas:
                '. title .'
                'link link link';
            gap: rem(32);
            padding: 0 $px;
        }
        &__title {
            grid-area: title;
            max-width: 25ch;
            justify-self: center;
            font-size: lineScale(64, 32, 480, 1440);
            font-weight: $fw-semi;
            text-align: center;
        }
        &__link {
            grid-area: link;
            justify-self: flex-end;
            align-self: flex-end;
            display: flex;
            align-items: center;
            gap: rem(4);
            white-space: nowrap;
            @include hover-blick-line;
        }
        &__loader {
            width: 100%;
            overflow: hidden;
            padding: rem(40) 0;
            &-wrapper {
                min-width: max-content;
            }
        }
        &__error {
            width: 100%;
            min-height: rem(400);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: rem(16);
            text-align: center;
        }
        &__controls {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: rem(32);
        }
        &__button {
            @include slider-buttons;
        }
        &__slide {
            width: fit-content;
        }
    }
</style>
