<template>
    <section class="home-carousel">
        <div class="home-carousel__container">
            <div class="home-carousel__titlebox">
                <h2 class="home-carousel__title">{{ props.title }}</h2>
                <NuxtLink :to="{ name: 'index' }" class="home-carousel__link" v-if="props.wtithLink">
                    <span>Смотреть все</span>
                    <SvgSprite type="arrow" :size="12" />
                </NuxtLink>
            </div>
            <div class="home-carousel__body">
                <div v-show="status === 'pending'">Загрузка...</div>
                <div v-show="status === 'error'">Ошибка загрузки данных</div>

                <ClientOnly>
                    <EmblaContainer
                        v-show="status === 'success'"
                        ref="sliderRef"
                        :options="carouselOptions"
                        :autoplay-enable="props.autoplay"
                        :autoplay="props.autoplay ? autoplayOptions : undefined"
                        padding="40px 0"
                    >
                        <EmblaSlide v-for="product in products" :key="product.id">
                            <ProductCard :product="product" :variant="props.cardVariant" />
                        </EmblaSlide>
                    </EmblaContainer>
                </ClientOnly>

                <div class="home-carousel__controls" v-if="!props.autoplay">
                    <button class="home-carousel__button home-carousel__button--prev" @click="scrollPrev">
                        <SvgSprite type="arrow" />
                    </button>
                    <button class="home-carousel__button home-carousel__button--next" @click="scrollNext">
                        <SvgSprite type="arrow" />
                    </button>
                </div>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    // types
    import type { AsyncDataRequestStatus } from '#app';
    import type { Ref } from 'vue';
    import type { IProduct } from '~/interfaces/product';
    import type { EmblaCarouselType, EmblaOptionsType } from 'embla-carousel';
    import type { AutoplayOptionsType } from 'embla-carousel-autoplay';

    interface IProps {
        contentRef: Ref<IProduct[] | null>;
        statusRef: Ref<AsyncDataRequestStatus>;
        autoplay?: boolean;
        title?: string;
        wtithLink?: boolean;
        cardVariant?: 'large' | null;
    }

    const props = withDefaults(defineProps<IProps>(), {
        wtithLink: true,
        autoplay: false
    });

    const status = computed(() => props.statusRef.value);
    const products = computed(() => props.contentRef.value ?? []);

    // slider==============================================
    const sliderRef = ref<{ emblaApi: EmblaCarouselType | null } | null>(null);

    const carouselOptions: EmblaOptionsType = {
        loop: false,
        align: 'start',
        dragFree: true,
    };

    const autoplayOptions: AutoplayOptionsType = {
        delay: 800,
        jump: false,
        stopOnMouseEnter: true
    }

    const scrollPrev = () => sliderRef?.value?.emblaApi?.scrollPrev();
    const scrollNext = () => sliderRef?.value?.emblaApi?.scrollNext();
    //=====================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .home-carousel {
        @include content-block;
        &__container {
            @include content-container($padding: 0);
        }
        &__titlebox {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            grid-template-areas: '. title link';
            padding: 0 $px;
        }
        &__title {
            grid-area: title;
            justify-self: center;
            font-size: lineScale(64, 24, 480, 1440);
            font-weight: $fw-semi;
        }
        &__link {
            grid-area: link;
            justify-self: flex-end;
            align-self: flex-end;
            display: flex;
            align-items: center;
            gap: rem(4);
            @include hover-blick-line;
        }
        &__controls {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: rem(32);
        }
        &__button {
            cursor: pointer;
            display: flex;
            align-items: center;
            &::before {
                content: '';
                display: block;
                width: rem(32);
                height: rem(2);
                transform: scaleY(0.89);
                translate: 0 -0.5px;
                background-color: currentColor;
                transition: width $td $tf;
            }
            @media (pointer: fine) {
                &:hover {
                    &::before {
                        width: rem(48);
                    }
                }
            }
            &[disabled] {
                opacity: 0.5;
                &::before {
                    width: 0;
                }
            }
            &--prev {
                transform: scaleX(-1);
            }
        }
        &__slide {
            width: fit-content;
            padding: rem(40) 0;
        }
    }
</style>
