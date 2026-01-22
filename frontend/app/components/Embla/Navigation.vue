<template>
    <div :class="['slider-navigation', `slider-navigation--${props.theme}`]">
        <button
            class="slider-navigation__button slider-navigation__button--prev"
            type="button"
            @click="scrollPrev"
            :disabled="!canScrollPrev"
        >
            <span></span>
        </button>
        <div v-if="props.pagination" class="slider-navigation__pagination">
            <span class="slider-navigation__pagination-current">{{ selectedSnap }}</span>
            <span class="slider-navigation__pagination-separator">/</span>
            <span class="slider-navigation__pagination-total">{{ snapCount }}</span>
        </div>

        <button
            class="slider-navigation__button slider-navigation__button--next"
            type="button"
            @click="scrollNext"
            :disabled="!canScrollNext"
        >
            <span></span>
        </button>
    </div>
</template>

<script setup lang="ts">
    import type { EmblaCarouselType } from 'embla-carousel';

    const props = withDefaults(
        defineProps<{
            sliderRef: ComputedRef<{ emblaApi: EmblaCarouselType | null } | null> | null;
            theme?: 'light' | 'dark';
            pagination?: boolean;
        }>(),
        {
            sliderRef: null,
            theme: 'dark',
            pagination: false,
        }
    );

    const emblaApi = computed(() => props.sliderRef?.value?.emblaApi);

    // controls =======================================================
    const scrollPrev = () => {
        if (!emblaApi.value || !canScrollPrev.value) return;
        emblaApi.value.scrollPrev();
    };
    const scrollNext = () => {
        if (!emblaApi.value || !canScrollNext.value) return;
        emblaApi.value.scrollNext();
    };
    // ================================================================

    // pagination =====================================================
    const selectedSnap = ref<number>(0);
    const snapCount = ref<number>(0);

    const canScrollPrev = ref(false);
    const canScrollNext = ref(false);

    const updateSnapDisplay = () => {
        selectedSnap.value = (emblaApi.value?.selectedScrollSnap() ?? 0) + 1;
        snapCount.value = emblaApi.value?.scrollSnapList().length ?? 0;

        canScrollPrev.value = emblaApi.value?.canScrollPrev() || false;
        canScrollNext.value = emblaApi.value?.canScrollNext() || false;
    };

    onMounted(() => {
        emblaApi.value?.on('select', updateSnapDisplay).on('reInit', updateSnapDisplay);

        updateSnapDisplay();
    });
    // ================================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .slider-navigation {
        width: fit-content;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: rem(32);
        &__button {
            cursor: pointer;
            width: rem(32);
            height: rem(24);
            display: flex;
            align-items: center;
            transition: width $td $tf;
            transform-origin: center;
            > span {
                position: relative;
                display: block;
                width: 100%;
                height: rem(2);
                background-color: currentColor;
                &::before,
                &::after {
                    content: '';
                    display: block;
                    position: absolute;
                    width: rem(12);
                    height: rem(2);
                    background-color: currentColor;
                    right: 0;
                    top: 50%;
                    translate: 0 -50%;
                }
                &::before {
                    transform-origin: right;
                    rotate: -45deg;
                }
                &::after {
                    transform-origin: right;
                    rotate: 45deg;
                }
            }
            @media (pointer: fine) {
                &:hover {
                    width: rem(48);
                }
            }
            &:active {
                width: rem(40);
            }
            &[disabled] {
                opacity: 0.5;
                pointer-events: none;
            }
            &--prev {
                transform: scaleX(-1);
            }
        }
        &__pagination {
            display: flex;
            align-items: center;
            gap: rem(8);
            font-family: 'Inter', sans-serif;
            font-size: rem(14);
        }
    }
</style>
