<template>
    <div class="slider">
        <EmblaContainer ref="sliderRef" class="slider__body" :options="carouselOptions">
            <EmblaSlide
                v-for="slide in slides"
                :key="slide.id"
                class="slider__slide"
                :space-between="16"
            >
                <picture class="slider__slide-image-container">
                    <img
                        class="slider__slide-image"
                        :src="slide.image || '/img/service/flowers-placeholder.png'"
                        :alt="slide.title"
                    />
                </picture>
                <div class="slider__slide-wrapper">
                    <div class="slider__slide-titlebox">
                        <h3 class="slider__slide-title">{{ slide.title }}</h3>
                        <p class="slider__slide-desc">{{ slide.desc }}</p>
                    </div>
                    <NuxtLink class="slider__slide-button" :to="slide.link">
                        <span>Открыть в каталоге</span>
                        <span><SvgSprite type="arrow" /></span>
                    </NuxtLink>
                </div>
            </EmblaSlide>
        </EmblaContainer>
        <div class="slider__controls">
            <button class="slider__button slider__button--prev" @click="scrollPrev">
                <SvgSprite type="arrow" :size="20" />
            </button>
            <div class="slider__pagination">
                {{ selectedSnap }}
                <span class="symbol">/</span>
                {{ snapCount }}
            </div>

            <button class="slider__button slider__button--next" @click="scrollNext">
                <SvgSprite type="arrow" :size="20" />
            </button>
        </div>
    </div>
</template>

<script setup lang="ts">
    // types==========================================================
    import type { EmblaCarouselType, EmblaOptionsType } from 'embla-carousel';
    // ================================================================

    // slider==========================================================
    const sliderRef = ref<{ emblaApi: EmblaCarouselType | null } | null>(null);

    const carouselOptions: EmblaOptionsType = {
        loop: true,
        align: 'start',
        dragFree: false,
        duration: 25,
    };

    const scrollPrev = () => sliderRef?.value?.emblaApi?.scrollPrev();
    const scrollNext = () => sliderRef?.value?.emblaApi?.scrollNext();

    // pagination======================================================
    const selectedSnap = ref<number>();
    const snapCount = ref<number>();

    const updateSnapDisplay = () => {
        selectedSnap.value = (sliderRef.value?.emblaApi?.selectedScrollSnap() ?? 0) + 1;
        snapCount.value = sliderRef.value?.emblaApi?.scrollSnapList().length ?? 0;
    };

    onMounted(() => {
        sliderRef.value?.emblaApi?.on('select', updateSnapDisplay).on('reInit', updateSnapDisplay);

        updateSnapDisplay();
    });
    // ================================================================

    const slides = [
        {
            id: 1,
            title: 'Букеты на свадьбу',
            desc: 'Описание — основной смысл. Используйте 1–2 предложения в 1–3 строчки, если выравнивание по центру.',
            image: '/img/temp/temp1.jpg',
            link: { name: 'index' },
        },
        {
            id: 2,
            title: 'Букеты на свадьбу',
            desc: 'Описание — основной смысл. Используйте 1–2 предложения в 1–3 строчки, если выравнивание по центру.',
            image: '/img/temp/flowers.gif',
            link: { name: 'index' },
        },
        {
            id: 3,
            title: 'Букеты на свадьбу',
            desc: 'Описание — основной смысл. Используйте 1–2 предложения в 1–3 строчки, если выравнивание по центру.',
            image: '/img/temp/temp1.jpg',
            link: { name: 'index' },
        },
        {
            id: 4,
            title: 'Букеты на свадьбу',
            desc: 'Описание — основной смысл. Используйте 1–2 предложения в 1–3 строчки, если выравнивание по центру.',
            image: '/img/temp/flowers.gif',
            link: { name: 'index' },
        },
        {
            id: 5,
            title: 'Букеты на свадьбу',
            desc: 'Описание — основной смысл. Используйте 1–2 предложения в 1–3 строчки, если выравнивание по центру.',
            image: '/img/temp/temp1.jpg',
            link: { name: 'index' },
        },
    ];
    // ================================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .slider {
        $p: &;

        width: 100%;
        max-width: rem(484);
        &__slide {
            position: relative;
            width: 100%;
            aspect-ratio: 1.2/1;
            border-radius: rem(32);
            overflow: hidden;
            @media (pointer: fine) {
                &:hover {
                    #{$p}__slide-wrapper {
                        backdrop-filter: blur(5px);
                    }
                    #{$p}__slide-title {
                        font-size: lineScale(40, 32, 480, 1440);
                    }
                    #{$p}__slide-desc {
                        flex: 1 1 100%;
                    }
                }
            }
            &-image-container {
                position: absolute;
                z-index: -1;
                inset: 0;
                img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                    filter: brightness(60%);
                }
            }
            &-wrapper {
                width: 100%;
                height: 100%;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                gap: rem(16);
                padding: lineScale(32, 16, 480, 1440);
                transition: backdrop-filter $td $tf;
            }
            &-titlebox {
                display: flex;
                flex-direction: column;
                gap: rem(16);
            }
            &-title {
                max-width: 13ch;
                text-wrap: balance;
                font-size: lineScale(32, 24, 480, 1440);
                font-weight: $fw-semi;
                transition: font-size $td $tf;
            }
            &-desc {
                flex: 0 0 0%;
                font-size: lineScale(18, 16, 480, 1440);
                line-height: 1.4;
                opacity: 0.8;
                min-height: 0;
                overflow: hidden;
                transition: flex $td $tf;
            }
            &-button {
                @include button-primary(
                    $anim-color: $c-accent,
                    $gap: rem(8),
                    $font-size: lineScale(20, 16, 480, 1440)
                );
            }
        }
        &__controls {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: rem(16);
            font-size: rem(14);
            color: $c-98BBD7;
            margin-top: rem(24);
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
    }
</style>
