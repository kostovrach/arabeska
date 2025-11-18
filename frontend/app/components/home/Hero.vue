<template>
    <section class="home-hero">
        <div class="home-hero__container">
            <EmblaContainer
                ref="sliderRef"
                class="home-hero__slider"
                :options="carouselOptions"
                overflow="visible"
                fade
            >
                <EmblaSlide
                    v-for="(slide, idx) in props.slides"
                    :key="idx"
                    class="home-hero__slide"
                    width="100%"
                >
                    <div class="home-hero__slide-wrapper">
                        <div class="home-hero__slide-content">
                            <h1 class="home-hero__slide-title">
                                {{ slide.home_slider_id.title ?? '' }}
                            </h1>
                            <ClientOnly>
                                <p
                                    class="home-hero__slide-desc"
                                    v-if="slide.home_slider_id.content"
                                    v-html="slide.home_slider_id.content"
                                ></p>
                            </ClientOnly>
                            <div class="home-hero__slide-controls">
                                <NuxtLink class="home-hero__slide-button" :to="{ name: 'index' }">
                                    <span>Подобрать букет</span>
                                    <span><SvgSprite type="arrow" /></span>
                                </NuxtLink>
                                <div class="home-hero__slide-nav">
                                    <button
                                        class="home-hero__slide-nav-button home-hero__slide-nav-button--prev"
                                        @click="scrollPrev"
                                    >
                                        <SvgSprite type="arrow" />
                                    </button>
                                    <button
                                        class="home-hero__slide-nav-button home-hero__slide-nav-button--next"
                                        @click="scrollNext"
                                    >
                                        <SvgSprite type="arrow" />
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="home-hero__slide-media" v-if="slide.home_slider_id.image_url">
                            <picture class="home-hero__slide-image-container">
                                <img
                                    class="home-hero__slide-image"
                                    :src="slide.home_slider_id.image_url ?? ''"
                                    :alt="slide.home_slider_id.title ?? '#'"
                                />
                            </picture>
                        </div>
                    </div>
                </EmblaSlide>
            </EmblaContainer>

            <div class="home-hero__runline-container">
                <div class="home-hero__runline home-hero__runline--nav">
                    <ul v-for="n in 2" :key="n" class="home-hero__runline-wrapper">
                        <li
                            v-for="(item, idx) in navItems"
                            :key="idx"
                            class="home-hero__runline-item"
                        >
                            <NuxtLink
                                :to="{ name: item.path.name, params: item.path.params ?? {} }"
                            >
                                {{ item.title }}
                            </NuxtLink>
                        </li>
                    </ul>
                </div>
                <div class="home-hero__runline home-hero__runline--filters">
                    <ul v-for="n in 2" :key="n" class="home-hero__runline-wrapper">
                        <li
                            v-for="(item, idx) in categories?.slice(0, 8)"
                            :key="idx"
                            class="home-hero__runline-item"
                        >
                            <NuxtLink
                                :to="{
                                    name: 'catalog-category',
                                    params: { category: slugify(item.name) },
                                }"
                            >
                                {{ item.name }}
                            </NuxtLink>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    import type { EmblaCarouselType, EmblaOptionsType } from 'embla-carousel';
    import type { ICategories } from '~~/interfaces/categories';

    interface Slide {
        id: number | string;
        home_id: any;
        home_slider_id: {
            id: number | string;
            title: string;
            content: string;
            image: string;
            image_url: string;
        };
    }

    const props = withDefaults(
        defineProps<{
            slides?: Slide[];
        }>(),
        {
            slides: () => [],
        }
    );

    const sliderRef = ref<{ emblaApi: EmblaCarouselType | null } | null>(null);

    const carouselOptions: EmblaOptionsType = {
        loop: true,
        align: 'start',
        dragFree: false,
        duration: 40,
    };

    const scrollPrev = () => sliderRef?.value?.emblaApi?.scrollPrev();
    const scrollNext = () => sliderRef?.value?.emblaApi?.scrollNext();

    const { content: categories } = useCms<ICategories[]>('categories');

    const navItems: {
        title: string;
        path: {
            name: string;
            params?: {};
        };
    }[] = [
        {
            title: 'цветы оптом',
            path: {
                name: 'wholesale',
            },
        },
        {
            title: 'Отзывы',
            path: {
                name: 'feedback',
            },
        },
        {
            title: 'Частые вопросы',
            path: {
                name: 'faq',
            },
        },
        {
            title: 'цветочная подписка',
            path: {
                name: 'subscription',
            },
        },
        {
            title: 'Контакты',
            path: {
                name: 'contact',
            },
        },
        {
            title: 'Франшиза',
            path: {
                name: 'franchise',
            },
        },
    ];
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .home-hero {
        $p: &;

        overflow-x: clip;
        &__container {
            height: 100%;
        }
        &__slider {
            // background-color: $c-082535;
            overflow: visible;
        }
        &__slide {
            position: relative;
            width: 100vw;
            min-height: 60lvh;
            color: $c-FFFFFF;
            overflow-x: clip;
            @include content-container($padding: lineScale(64, 16, 480, 1440));
            &::before {
                content: '';
                position: absolute;
                top: 100%;
                right: 0;
                height: rem(64);
                width: 100%;
                background-color: inherit;
                clip-path: polygon(100% 0, 0 0, 100% 100%);
                transition-duration: 0s;
            }
            &:nth-child(2n + 1) {
                background-color: $c-082535;
            }
            &:nth-child(2n + 2) {
                background-color: $c-98BBD7;
            }
            &-wrapper {
                width: 100%;
                height: 100%;
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: rem(128);
                align-items: flex-end;
            }
            &-title {
                text-wrap: balance;
                font-size: lineScale(64, 24, 480, 1440);
                font-weight: $fw-semi;
            }
            &-desc {
                max-width: 35ch;
                font-size: lineScale(22, 16, 480, 1440);
                font-weight: $fw-semi;
                line-height: 1.2;
                margin-top: rem(24);
                h2,
                h3,
                h4,
                h5,
                h6 {
                    font-size: lineScale(24, 18, 480, 1440);
                    margin-bottom: rem(16);
                }
                ul,
                ol {
                    display: flex;
                    flex-direction: column;
                    gap: rem(8);
                    li {
                        margin-left: rem(22);
                    }
                }
                ul > li {
                    list-style: disc outside;
                }
                ol > li {
                    list-style: decimal outside;
                }
            }
            &-controls {
                display: flex;
                align-items: center;
                flex-wrap: wrap;
                gap: lineScale(96, 64, 480, 1440);
                margin-top: rem(48);
            }
            &-button {
                @include button-primary($hover-color: $c-secondary);
            }
            &-nav {
                justify-self: flex-end;
                display: flex;
                align-items: center;
                justify-content: space-between;
                gap: rem(32);
                &-button {
                    @include slider-buttons;
                }
            }
            &-media {
                display: flex;
                align-items: center;
                justify-content: center;
            }
            &-image-container {
                height: 100%;
                max-height: rem(420);
                aspect-ratio: 1;
                img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                    border-radius: 50%;
                    scale: 1.8;
                }
            }
        }
        &__runline-container {
            display: flex;
            flex-direction: column;
        }
        &__runline {
            position: relative;
            left: 50%;
            translate: -50% 0;
            width: 110%;
            display: flex;
            gap: rem(64);
            &--nav {
                z-index: 5;
                background-color: $c-99CC65;
                rotate: -6deg;
                transform-origin: 30% 40%;
                #{$p}__runline-wrapper {
                    animation-direction: reverse;
                }
            }
            &--filters {
                z-index: 4;
                background-color: $c-E5F2D8;
                rotate: 2.9deg;
                transform-origin: 70% 0%;
            }
            @media (pointer: fine) {
                &:hover {
                    #{$p}__runline-wrapper {
                        animation-play-state: paused;
                    }
                }
            }
            &-wrapper {
                display: flex;
                align-items: center;
                gap: rem(64);
                padding: rem(8) 0;
                will-change: translate;
                animation: runline 10s linear infinite;
                @keyframes runline {
                    from {
                        translate: 0 0;
                    }
                    to {
                        translate: -50% 0;
                    }
                }
            }
            &-item {
                width: fit-content;
                text-transform: lowercase;
                white-space: nowrap;
                font-size: lineScale(24, 20, 480, 1440);
                line-height: 1;
                font-weight: $fw-semi;
                @media (pointer: fine) {
                    &:hover {
                        color: $c-FFFFFF;
                    }
                }
            }
        }
    }

    @media (max-width: 1300px) {
        .home-hero {
            &__slide {
                &-image-container img {
                    scale: 1.5;
                }
            }
        }
    }
    @media (max-width: 1024px) {
        .home-hero {
            &__slide {
                &-wrapper {
                    gap: rem(64);
                }
                &-image-container img {
                    scale: 1.3;
                }
            }
        }
    }
    @media (max-width: 768px) {
        .home-hero {
            &__slide {
                min-height: initial;
                padding: rem(64) rem(16);
                overflow: hidden;
                &-wrapper {
                    grid-template-columns: 100%;
                    // gap: rem(186);
                }
                &-media {
                    max-height: rem(240);
                }
                &-image-container {
                    translate: 0 rem(128);
                }
            }
        }
    }

    @media (max-width: 480px) {
        .home-hero {
            &__slide {
                &-nav {
                    width: 100%;
                    justify-content: space-evenly;
                }
            }
        }
    }
</style>
