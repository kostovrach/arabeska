<template>
    <div class="feedback-carousel">
        <EmblaContainer
            ref="sliderRef"
            class="feedback-carousel__slider"
            :options="carouselOptions"
            auto-scroll
            :auto-scroll-options="{ speed: 1 }"
            stop-scroll-on-hover
        >
            <EmblaSlide v-for="item in feedback" :key="item.id" class="feedback-carousel__slide">
                <CFeedbackCard :content="item" />
            </EmblaSlide>
        </EmblaContainer>
    </div>
</template>

<script setup lang="ts">
    import type { EmblaCarouselType, EmblaOptionsType } from 'embla-carousel';

    const feedbackStore = useFeedbackStore();

    const feedback = computed(() => feedbackStore.feedbackList);

    const carouselOptions: EmblaOptionsType = {
        loop: true,
        align: 'start',
        dragFree: true,
    };
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
