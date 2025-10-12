<template>
    <section class="home-hero">
        <div class="home-hero__container">
            <EmblaContainer class="home-hero__slider" ref="sliderRef" :options="carouselOptions">
                <EmblaSlide class="home-hero__slide" width="100%">
                    <div class="home-hero__slide-wrapper">
                        <div class="home-hero__slide-content">
                            <h1 class="home-hero__slide-title">Цветы, которые говорят без слов</h1>
                            <p class="home-hero__slide-desc">
                                Каждый букет в коллекции неповторим, каждый имеет свой характер
                            </p>
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
                        <div class="home-hero__slide-media">
                            <picture class="home-hero__slide-image-container">
                                <img
                                    class="home-hero__slide-image"
                                    src="/img/temp/flowers.gif"
                                    alt="#"
                                />
                            </picture>
                        </div>
                    </div>
                </EmblaSlide>
                <EmblaSlide class="home-hero__slide" width="100%">
                    <div class="home-hero__slide-wrapper">
                        <div class="home-hero__slide-content">
                            <h1 class="home-hero__slide-title">В подарок любимой</h1>
                            <p class="home-hero__slide-desc">
                                Каждый букет в коллекции неповторим, каждый имеет свой характер
                            </p>
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
                        <div class="home-hero__slide-media">
                            <picture class="home-hero__slide-image-container">
                                <img
                                    class="home-hero__slide-image"
                                    src="/img/temp/temp1.jpg"
                                    alt="#"
                                />
                            </picture>
                        </div>
                    </div>
                </EmblaSlide>
            </EmblaContainer>

            <div class="home-hero__runline-container">
                <div class="home-hero__runline home-hero__runline--nav">
                    <ul class="home-hero__runline-wrapper" v-for="n in 2" :key="n">
                        <li
                            class="home-hero__runline-item"
                            v-for="item in navItems"
                            :key="item.key"
                        >
                            <NuxtLink :to="{ name: item.path.name, params: item.path.params }">
                                {{ item.title }}
                            </NuxtLink>
                        </li>
                    </ul>
                </div>
                <div class="home-hero__runline home-hero__runline--filters">
                    <ul class="home-hero__runline-wrapper" v-for="n in 2" :key="n">
                        <li
                            class="home-hero__runline-item"
                            v-for="item in filterItems"
                            :key="item.key"
                        >
                            <NuxtLink :to="{ name: item.path.name, params: item.path.params }">
                                {{ item.title }}
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

    const sliderRef = ref<{ emblaApi: EmblaCarouselType | null } | null>(null);

    const carouselOptions: EmblaOptionsType = {
        loop: true,
        align: 'start',
        dragFree: false,
        duration: 40,
    };

    const scrollPrev = () => sliderRef?.value?.emblaApi?.scrollPrev();
    const scrollNext = () => sliderRef?.value?.emblaApi?.scrollNext();

    const navItems = [
        {
            key: '1',
            title: 'букеты',
            path: {
                name: 'index',
                params: {},
            },
        },
        {
            key: '2',
            title: 'дополнительное',
            path: {
                name: 'index',
                params: {},
            },
        },
        {
            key: '3',
            title: 'цветы оптом',
            path: {
                name: 'index',
                params: {},
            },
        },
        {
            key: '4',
            title: 'сертификаты',
            path: {
                name: 'index',
                params: {},
            },
        },
        {
            key: '5',
            title: 'цветочная подписка',
            path: {
                name: 'index',
                params: {},
            },
        },
        {
            key: '6',
            title: 'открытки',
            path: {
                name: 'index',
                params: {},
            },
        },
    ];

    const filterItems = [
        {
            key: '1',
            title: 'розы',
            path: {
                name: 'index',
                params: {},
            },
        },
        {
            key: '2',
            title: 'гвоздики',
            path: {
                name: 'index',
                params: {},
            },
        },
        {
            key: '3',
            title: 'тюльпаны',
            path: {
                name: 'index',
                params: {},
            },
        },
        {
            key: '4',
            title: 'хризантемы',
            path: {
                name: 'index',
                params: {},
            },
        },
        {
            key: '5',
            title: 'астры',
            path: {
                name: 'index',
                params: {},
            },
        },
        {
            key: '6',
            title: 'подсолнухи',
            path: {
                name: 'index',
                params: {},
            },
        },
        {
            key: '7',
            title: 'калы',
            path: {
                name: 'index',
                params: {},
            },
        },
        {
            key: '8',
            title: 'ромашки',
            path: {
                name: 'index',
                params: {},
            },
        },
    ];
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .home-hero {
        $p: &;

        overflow-x: clip;
        &__container {
            height: 100%;
        }
        &__slider {
            background-color: $c-082535;
            overflow: visible;
        }
        &__slide {
            width: 100vw;
            min-height: 60lvh;
            color: $c-FFFFFF;
            overflow-x: clip;
            @include content-container($padding: lineScale(64, 16, 480, 1440));
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
                align-items: center;
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
                align-self: flex-end;
                justify-self: flex-end;
                display: flex;
                align-items: center;
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
            z-index: 5;
            display: flex;
            gap: rem(64);
            &--nav {
                background-color: $c-99CC65;
                rotate: -1.5deg;
                transform-origin: 0% 40%;
                #{$p}__runline-wrapper {
                    animation-direction: reverse;
                }
            }
            &--filters {
                background-color: $c-E5F2D8;
                rotate: 3deg;
                transform-origin: 140% 0%;
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
                &-wrapper {
                    grid-template-columns: 100%;
                }
                &-media {
                    display: none;
                }
            }
        }
    }
</style>
