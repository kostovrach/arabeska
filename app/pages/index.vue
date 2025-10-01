<template>
    <section class="hero">
        <div class="hero__container">
            <ClientOnly>
                <swiper-container
                    ref="sliderRef"
                    class="hero__slider"
                    :speed="800"
                    :allow-touch-move="false"
                >
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
            </ClientOnly>
        </div>
    </section>
</template>

<script setup lang="ts">
    const sliderRef = ref(null);

    const swiper = useSwiper(sliderRef);
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .hero {
        color: $c-FFFFFF;
        background-color: $c-accent;
        &__container {
            height: 100%;
            @include content-layout($padding: 0);
        }
        &__slider {
            width: 100%;
        }
        &__slide {
            box-sizing: border-box;
            width: 100%;
            min-height: 70lvh;
            padding: 0 $px;
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
            &-image-container {
                width: 100%;
                max-height: 70lvh;
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
    }
</style>
