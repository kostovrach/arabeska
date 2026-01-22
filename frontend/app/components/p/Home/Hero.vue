<template>
    <section class="home-hero">
        <div class="home-hero__container">
            <EmblaContainer
                class="home-hero__slider"
                :options="carouselOptions"
                overflow="visible"
                fade
                auto-height
                autoplay
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
                    <EmblaContainer
                        class="home-hero__runline-wrapper"
                        auto-scroll
                        stop-scroll-on-hover
                        :auto-scroll-options="{
                            ...runlineAutoScrollOptions,
                            direction: 'backward',
                        }"
                        :options="runlineOptions"
                    >
                        <EmblaSlide
                            v-for="(item, idx) in [...navItems, ...navItems, ...navItems]"
                            :key="idx"
                            class="home-hero__runline-item"
                        >
                            <NuxtLink
                                :to="{ name: item.path.name, params: item.path.params ?? {} }"
                            >
                                {{ item.title }}
                            </NuxtLink>
                        </EmblaSlide>
                    </EmblaContainer>
                </div>
                <div class="home-hero__runline home-hero__runline--filters">
                    <EmblaContainer
                        class="home-hero__runline-wrapper"
                        auto-scroll
                        stop-scroll-on-hover
                        :auto-scroll-options="runlineAutoScrollOptions"
                        :options="runlineOptions"
                    >
                        <EmblaSlide
                            v-for="(item, idx) in categories?.slice(0, 16)"
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
                        </EmblaSlide>
                    </EmblaContainer>
                </div>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    import type { EmblaOptionsType } from 'embla-carousel';
    import type { AutoScrollOptionsType } from 'embla-carousel-auto-scroll';
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

    const carouselOptions: EmblaOptionsType = {
        loop: true,
        align: 'start',
        dragFree: false,
        duration: 40,
    };

    const runlineOptions: EmblaOptionsType = {
        loop: true,
        align: 'start',
        dragFree: true,
    };

    const runlineAutoScrollOptions: AutoScrollOptionsType = {
        speed: 1,
    };

    const { content: categories } = await useCms<ICategories[]>('categories');

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
            @media (max-width: 768px) {
                min-height: initial;
                padding: rem(64) rem(16);
                overflow: hidden;
            }
            &-wrapper {
                width: 100%;
                height: 100%;
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: rem(128);
                align-items: flex-end;
                @media (max-width: 1024px) {
                    gap: rem(64);
                }
                @media (max-width: 768px) {
                    grid-template-columns: 100%;
                }
            }
            &-content {
                padding-bottom: rem(64);
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
                flex-direction: column;
                gap: rem(48);
                margin-top: rem(48);
            }
            &-button {
                @include button-primary($hover-color: $c-secondary);
            }
            &-media {
                display: flex;
                align-items: center;
                justify-content: center;
                @media (max-width: 768px) {
                    display: none;
                }
            }
            &-image-container {
                height: 100%;
                max-height: rem(420);
                aspect-ratio: 1;
            }
            &-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
                border-radius: 50%;
                scale: 1.8;
                @media (max-width: 1300px) {
                    scale: 1.5;
                }
                @media (max-width: 1024px) {
                    scale: 1.3;
                }
            }
        }
        &__runline {
            position: relative;
            left: 50%;
            translate: -50% 0;
            width: 110%;
            &--nav {
                z-index: 5;
                background-color: $c-99CC65;
                rotate: -6deg;
                transform-origin: 30% 40%;
            }
            &--filters {
                z-index: 4;
                background-color: $c-E5F2D8;
                rotate: 2.9deg;
                transform-origin: 70% 0%;
            }
            &-item {
                width: fit-content;
                text-transform: lowercase;
                white-space: nowrap;
                font-size: lineScale(24, 20, 480, 1440);
                line-height: 1;
                font-weight: $fw-semi;
                padding: rem(8) 0;
                @media (pointer: fine) {
                    &:hover {
                        color: $c-FFFFFF;
                    }
                }
            }
        }
    }
</style>
