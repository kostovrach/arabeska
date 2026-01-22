<template>
    <div class="feedback-carousel">
        <div v-show="status === 'pending'" class="feedback-carousel__loader">
            <div class="feedback-carousel__loader-wrapper">
                <CFeedbackLoader v-for="n in 5" :key="n" />
            </div>
        </div>
        <div v-show="status === 'error'" class="feedback-carousel__error">
            <FetchError />
        </div>

        <ClientOnly>
            <EmblaContainer
                v-show="status === 'success'"
                ref="sliderRef"
                class="feedback-carousel__slider"
                :options="carouselOptions"
                :autoScroll="true"
                :autoScrollOptions="autoplayOptions"
                @mouseenter="autoplayStop"
                @mouseleave="autoplayStart"
            >
                <EmblaSlide v-for="item in items" :key="item.id" class="feedback-carousel__slide">
                    <CFeedbackCard :content="item" />
                </EmblaSlide>
            </EmblaContainer>
        </ClientOnly>
    </div>
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

    .feedback-carousel {
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
