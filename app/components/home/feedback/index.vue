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
            <RateWidgets class="home-feedback__widgets" />
            <div class="home-feedback__body">
                <div class="home-feedback__loader" v-show="status === 'pending'">
                    <div class="home-feedback__loader-wrapper">
                        <HomeFeedbackLoader v-for="n in 5" :key="n" />
                    </div>
                </div>
                <div class="home-feedback__error" v-show="status === 'error'">
                    <FetchError />
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
                            <HomeFeedbackCard :content="item" />
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
    import type { AutoplayOptionsType } from 'embla-carousel-autoplay';
    // =======================================================

    // data===================================================
    const feedbackStore = useFeedbackStore();
    feedbackStore.getFeedback();

    const { feedbackList, feedbackStatus } = storeToRefs(feedbackStore);

    const status = computed(() => feedbackStatus.value);
    const items = computed(() => feedbackList.value ?? []);
    // =======================================================

    // slider=================================================
    const sliderRef = ref<{ emblaApi: EmblaCarouselType | null } | null>(null);

    const carouselOptions: EmblaOptionsType = {
        loop: true,
        align: 'start',
        dragFree: true,
        duration: 50000,
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
    // =======================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .home-feedback {
        @include content-block;
        &__container {
            display: flex;
            flex-direction: column;
            gap: rem(64);
            @include content-container;
        }
        &__titlebox {
            display: grid;
            grid-template-columns: repeat(2, auto);
            grid-template-rows: repeat(3, auto);
            grid-template-areas:
                'title .'
                'subtitle .'
                'link link';
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
        &__body {
            width: 100%;
            @supports (mask-image: url()) {
                mask-image: linear-gradient(
                    90deg,
                    transparent 0%,
                    #000 10%,
                    #000 90%,
                    transparent 100%
                );
                mask-size: 100%;
                mask-repeat: no-repeat;
            }
        }
        &__slide {
            width: fit-content;
        }
        &__loader {
            width: 100%;
            overflow: hidden;
            padding: rem(40) 0;
            &-wrapper {
                min-width: max-content;
            }
        }
    }
</style>
