<template>
    <section class="hero">
        <div class="hero__container">
            <ClientOnly>
                <swiper-container ref="sliderRef" class="hero__slider" :speed="800" :allow-touch-move="false">
                    <swiper-slide class="hero__slide">
                        <div class="hero__slide-wrapper">
                            <div class="hero__slide-content">
                                <h1 class="hero__slide-title">Цветы, которые говорят без слов</h1>
                                <p class="hero__slide-desc">
                                    Каждый букет в коллекции неповторим, каждый имеет свой характер. Каждая деталь,
                                    форма и материал упаковки передают особую гармонию элементов через восприятие и
                                    тактильные ощущения
                                </p>
                                <div class="hero__slide-controls">
                                    <button class="hero__slide-button">
                                        <span>Как подобрать букет</span>
                                        <span><SvgSprite type="arrow" /></span>
                                    </button>
                                    <div class="hero__slide-nav">
                                        <button
                                            class="hero__slide-nav-button hero__slide-nav-button--prev"
                                            :class="swiper.isBeginning.value ? 'disabled' : ''"
                                            @click="swiper.prev()"
                                        >
                                            <SvgSprite type="arrow" />
                                        </button>
                                        <button
                                            class="hero__slide-nav-button hero__slide-nav-button--next"
                                            :class="swiper.isEnd.value ? 'disabled' : ''"
                                            @click="swiper.next()"
                                        >
                                            <SvgSprite type="arrow" />
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="hero__slide-media">
                                <picture
                                    class="hero__slide-image-container"
                                    style="--mask: url('/img/masks/flower.svg')"
                                >
                                    <img class="hero__slide-image" src="/img/temp/temp1.jpg" alt="#" />
                                </picture>
                            </div>
                        </div>
                    </swiper-slide>
                    <swiper-slide class="hero__slide">
                        <div class="hero__slide-wrapper">
                            <div class="hero__slide-content">
                                <h1 class="hero__slide-title">Сезонные цветы с собственной фермы</h1>
                                <p class="hero__slide-desc">
                                    Каждая деталь, форма и материал упаковки передают особую гармонию элементов через
                                    восприятие и тактильные ощущения
                                </p>
                                <div class="hero__slide-controls">
                                    <NuxtLink :to="{ name: 'index' }" class="hero__slide-button">
                                        <span>Открыть в каталоге</span>
                                        <span><SvgSprite type="arrow" /></span>
                                    </NuxtLink>
                                    <div class="hero__slide-nav">
                                        <button
                                            class="hero__slide-nav-button hero__slide-nav-button--prev"
                                            :class="swiper.isBeginning.value ? 'disabled' : ''"
                                            @click="swiper.prev()"
                                        >
                                            <SvgSprite type="arrow" />
                                        </button>
                                        <button
                                            class="hero__slide-nav-button hero__slide-nav-button--next"
                                            :class="swiper.isEnd.value ? 'disabled' : ''"
                                            @click="swiper.next()"
                                        >
                                            <SvgSprite type="arrow" />
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="hero__slide-media">
                                <picture
                                    class="hero__slide-image-container"
                                    style="--mask: url('/img/masks/oval.svg'); translate: 0 96px"
                                >
                                    <img class="hero__slide-image" src="/img/temp/flowers.gif" alt="#" />
                                </picture>
                            </div>
                        </div>
                    </swiper-slide>
                </swiper-container>
                <div class="hero__runline-container">
                    <div class="hero__runline hero__runline--nav">
                        <ul class="hero__runline-wrapper" v-for="n in 2" :key="n">
                            <li class="hero__runline-item" v-for="item in navItems" :key="item.key">
                                <NuxtLink :to="{ name: item.path.name, params: item.path.params }">
                                    {{ item.title }}
                                </NuxtLink>
                            </li>
                        </ul>
                    </div>
                    <div class="hero__runline hero__runline--filters">
                        <ul class="hero__runline-wrapper" v-for="n in 2" :key="n">
                            <li class="hero__runline-item" v-for="item in filterItems" :key="item.key">
                                <NuxtLink :to="{ name: item.path.name, params: item.path.params }">
                                    {{ item.title }}
                                </NuxtLink>
                            </li>
                        </ul>
                    </div>
                </div>
            </ClientOnly>
        </div>
    </section>
</template>

<script setup lang="ts">
    const sliderRef = ref(null);

    const swiper = useSwiper(sliderRef);

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

    .hero {
        $p: &;

        overflow-x: clip;
        &__container {
            height: 100%;
        }
        &__slider {
            width: 100%;
            color: $c-FFFFFF;
            background-color: $c-accent;
        }
        &__slide {
            box-sizing: border-box;
            width: 100%;
            @include content-layout;
            &-wrapper {
                height: 100%;
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: rem(64);
            }
            &-content {
                display: flex;
                flex-direction: column;
                gap: rem(48);
                padding: rem(128) 0;
            }
            &-media {
                max-height: 70lvh;
                min-height: rem(670);
            }
            &-image-container {
                width: 100%;
                height: 100%;
                mask-image: var(--mask);
                mask-size: 100% 100%;
                mask-repeat: no-repeat;
                scale: 1.2;
                img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }
            }
            &-title {
                font-size: lineScale(96, 40, 480, 1440);
                font-weight: $fw-semi;
                line-height: 0.8;
            }
            &-desc {
                font-size: lineScale(22, 18, 480, 1440);
                font-weight: $fw-semi;
                line-height: 1.4;
                text-wrap: balance;
            }
            &-controls {
                display: flex;
                align-items: center;
                gap: rem(48);
            }
            &-button {
                @include button-primary($border-color: $c-FFFFFF, $hover-color: $c-secondary);
            }
            &-nav {
                display: flex;
                align-items: center;
                gap: rem(32);
                &-button {
                    cursor: pointer;
                    display: flex;
                    align-items: center;
                    &::before {
                        content: '';
                        display: block;
                        width: rem(32);
                        height: rem(2);
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
                    &.disabled {
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
                background-color: $c-98BBD7;
                rotate: -2deg;
                transform-origin: 0% 40%;
                #{$p}__runline-wrapper {
                    animation-direction: reverse;
                }
            }
            &--filters {
                background-color: $c-D4E1E7;
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
</style>
