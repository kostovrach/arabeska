<template>
    <section class="home-feedback">
        <div class="home-feedback__container">
            <div class="home-feedback__titlebox">
                <h2 class="home-feedback__title">Отзывы покупателей</h2>
                <p class="home-feedback__subtitle">
                    Наша продукция подарит незабываемые впечатления каждому, получившему такой
                    презент
                </p>
                <NuxtLink class="home-feedback__link" :to="{ name: 'index' }">
                    <span>Смотреть все</span>
                    <SvgSprite type="arrow" :size="12" />
                </NuxtLink>
            </div>
            <ul class="home-feedback__widgets">
                <li class="home-feedback__widgets-item">
                    <div class="home-feedback__widgets-item-wrapper">
                        <h3 class="home-feedback__widgets-item-title">Яндекс карты</h3>
                        <a
                            class="home-feedback__widgets-item-counter"
                            href="https://example.com"
                            target="_blank"
                            rel="noopener noreferrer"
                        >
                            71 отзыв
                        </a>
                        <picture class="home-feedback__widgets-item-image-container">
                            <img
                                class="home-feedback__widgets-item-image"
                                src="/img/company/yandex.svg"
                                alt="#"
                            />
                        </picture>
                        <div class="home-feedback__widgets-item-rate">
                            <span>5.0</span>
                            <SvgSprite type="rate-star" :size="16" />
                        </div>
                    </div>
                </li>
                <li class="home-feedback__widgets-item">
                    <div class="home-feedback__widgets-item-wrapper">
                        <h3 class="home-feedback__widgets-item-title">2GIS</h3>
                        <a
                            class="home-feedback__widgets-item-counter"
                            href="https://example.com"
                            target="_blank"
                            rel="noopener noreferrer"
                        >
                            71 отзыв
                        </a>
                        <picture class="home-feedback__widgets-item-image-container">
                            <img
                                class="home-feedback__widgets-item-image"
                                src="/img/company/2gis.svg"
                                alt="#"
                            />
                        </picture>
                        <div class="home-feedback__widgets-item-rate">
                            <span>5.0</span>
                            <SvgSprite type="rate-star" :size="16" />
                        </div>
                    </div>
                </li>
                <li class="home-feedback__widgets-item">
                    <div class="home-feedback__widgets-item-wrapper">
                        <h3 class="home-feedback__widgets-item-title">Google Карты</h3>
                        <a
                            class="home-feedback__widgets-item-counter"
                            href="https://example.com"
                            target="_blank"
                            rel="noopener noreferrer"
                        >
                            71 отзыв
                        </a>
                        <picture class="home-feedback__widgets-item-image-container">
                            <img
                                class="home-feedback__widgets-item-image"
                                src="/img/company/google.svg"
                                alt="#"
                            />
                        </picture>
                        <div class="home-feedback__widgets-item-rate">
                            <span>5.0</span>
                            <SvgSprite type="rate-star" :size="16" />
                        </div>
                    </div>
                </li>
            </ul>
            <div class="home-feedback__body">
                <div class="home-feedback__loader" v-show="status === 'pending'">
                    <div class="home-feedback__loader-wrapper">
                        <HomeFeedbackLoader v-for="n in 5" :key="n" />
                    </div>
                </div>
                <div class="home-feedback__error" v-show="status === 'error'">
                    Потом добавить обработку ошибки
                </div>

                <ClientOnly>
                    <EmblaContainer
                        v-show="status === 'success'"
                        class="home-feedback__slider"
                        ref="sliderRef"
                        :options="carouselOptions"
                        :autoplay-enable="true"
                        :autoplay="autoplayOptions"
                        @mouseenter="autoplayStop"
                        @mouseleave="autoplayStart"
                    >
                        <EmblaSlide
                            class="home-feedback__slide"
                            v-for="item in items"
                            :key="item.id"
                        >
                            <div class="home-feedback__slide-wrapper">
                                <div class="home-feedback__slide-rate">
                                    <SvgSprite type="rate-star" :size="24" v-for="n in item.rate" />
                                </div>
                                test
                            </div>
                        </EmblaSlide>
                    </EmblaContainer>
                </ClientOnly>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    // types==================================================
    import type { AsyncDataRequestStatus } from '#app';
    import type { Ref } from 'vue';
    import type { IFeedback } from '~/interfaces/feedback';

    import type { EmblaCarouselType, EmblaOptionsType } from 'embla-carousel';
    import type { AutoplayOptionsType } from 'embla-carousel-autoplay';
    // =======================================================

    const props = defineProps<{
        contentRef: Ref<IFeedback[] | null>;
        statusRef: Ref<AsyncDataRequestStatus>;
    }>();

    const status = computed(() => props.statusRef.value);
    const items = computed(() => props.contentRef.value ?? []);

    // slider==============================================
    const sliderRef = ref<{ emblaApi: EmblaCarouselType | null } | null>(null);

    const carouselOptions: EmblaOptionsType = {
        loop: true,
        align: 'start',
        dragFree: true,
        duration: 20000,
    };

    const autoplayOptions: AutoplayOptionsType = {
        delay: 0,
        jump: false,
    };

    const autoplayStop = () => {
        sliderRef?.value?.emblaApi?.plugins().autoplay.stop();
    };
    const autoplayStart = () => {
        sliderRef?.value?.emblaApi?.plugins().autoplay.play();
    };
    //=====================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .home-feedback {
        @include content-block;
        &__container {
            @include content-container;
        }
        &__titlebox {
            display: grid;
            grid-template-columns: repeat(2, auto);
            grid-template-rows: repeat(2, auto);
            grid-template-areas:
                'title .'
                'subtitle link';
            gap: rem(32);
        }
        &__title {
            grid-area: title;
            font-size: lineScale(64, 32, 480, 1440);
            font-weight: $fw-semi;
        }
        &__subtitle {
            grid-area: subtitle;
            max-width: 45ch;
            font-size: lineScale(24, 18, 480, 1440);
            opacity: 0.8;
        }
        &__link {
            grid-area: link;
            justify-self: flex-end;
            align-self: flex-end;
            height: fit-content;
            display: flex;
            align-items: center;
            gap: rem(8);
            @include hover-blick-line;
        }
        &__widgets {
            display: flex;
            flex-wrap: wrap;
            gap: rem(32);
            margin-top: rem(64);
            &-item {
                width: 100%;
                max-width: rem(300);
                background-color: $c-D4E1E7;
                border-radius: rem(32) rem(32) 0 rem(32);
                &-wrapper {
                    display: grid;
                    grid-template-columns: repeat(2, auto);
                    grid-template-rows: repeat(2, auto);
                    grid-template-areas:
                        'title counter'
                        'image rate';
                    justify-content: space-between;
                    align-items: center;
                    gap: rem(22) rem(32);
                    padding: rem(18) rem(24);
                }
                &-title {
                    grid-area: title;
                    font-weight: $fw-semi;
                }
                &-counter {
                    grid-area: counter;
                    font-size: rem(14);
                    border-bottom: rem(1) dotted currentColor;
                    opacity: 0.5;
                }
                &-image-container {
                    grid-area: image;
                    max-width: rem(100);
                    img {
                        width: 100%;
                        height: 100%;
                        object-fit: contain;
                    }
                }
                &-rate {
                    grid-area: rate;
                    justify-self: flex-end;
                    width: fit-content;
                    display: flex;
                    align-items: center;
                    gap: rem(4);
                }
            }
        }
        &__slide {
            width: fit-content;
        }
    }
</style>
