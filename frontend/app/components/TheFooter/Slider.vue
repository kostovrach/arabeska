<template>
    <div class="slider">
        <EmblaContainer
            ref="sliderRef"
            class="slider__body"
            :options="carouselOptions"
            stop-scroll-on-hover
            autoplay
        >
            <EmblaSlide
                v-for="(category, idx) in categories"
                :key="idx"
                class="slider__slide"
                :space-between="16"
            >
                <picture class="slider__slide-image-container">
                    <img
                        class="slider__slide-image"
                        :src="category.image_url || '/img/service/flowers.jpg'"
                        :alt="category.name ?? '#'"
                    />
                </picture>
                <div class="slider__slide-wrapper">
                    <div class="slider__slide-titlebox">
                        <h3 class="slider__slide-title">{{ category.name }}</h3>
                        <p class="slider__slide-desc" v-if="category.description">
                            {{ category.description }}
                        </p>
                    </div>
                    <NuxtLink
                        class="slider__slide-button"
                        :to="{
                            name: 'catalog-category',
                            params: { category: slugify(category.name) },
                        }"
                    >
                        <span>Открыть в каталоге</span>
                        <span><SvgSprite type="arrow" /></span>
                    </NuxtLink>
                </div>
            </EmblaSlide>
        </EmblaContainer>
        <div class="slider__controls">
            <EmblaNavigation :slider-ref="computed(() => sliderRef)" pagination />
        </div>
    </div>
</template>

<script setup lang="ts">
    // types==========================================================
    import type { EmblaCarouselType, EmblaOptionsType } from 'embla-carousel';
    import type { ICategories } from '~~/interfaces/categories';
    // ================================================================

    // data ===========================================================
    const { content: categoriesRaw } = await useCms<ICategories[]>('categories');
    const categories = computed(() => categoriesRaw.value?.filter((el) => el.available === true));
    // ================================================================

    // slider==========================================================
    const sliderRef = ref<{ emblaApi: EmblaCarouselType | null } | null>(null);

    const carouselOptions: EmblaOptionsType = {
        loop: true,
        align: 'start',
        dragFree: false,
        duration: 25,
    };
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .slider {
        $p: &;

        width: 100%;
        max-width: rem(484);
        &__slide {
            position: relative;
            min-width: 100%;
            max-width: 100%;
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
            color: $c-98BBD7;
            margin-top: rem(24);
        }
    }
</style>
