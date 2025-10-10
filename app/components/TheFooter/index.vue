<template>
    <footer class="footer">
        <div class="footer__container">
            <div class="footer__slider">
                <EmblaContainer
                    class="footer__slider-body"
                    ref="sliderRef"
                    :options="carouselOptions"
                >
                    <EmblaSlide
                        class="footer__slide"
                        v-for="slide in slides"
                        :key="slide.id"
                        :space-between="16"
                    >
                        <picture class="footer__slide-image-container">
                            <img
                                class="footer__slide-image"
                                :src="slide.image || '/img/service/flowers-placeholder.png'"
                                :alt="slide.title"
                            />
                        </picture>
                        <div class="footer__slide-wrapper">
                            <div class="footer__slide-titlebox">
                                <h3 class="footer__slide-title">{{ slide.title }}</h3>
                                <p class="footer__slide-desc">{{ slide.desc }}</p>
                            </div>
                            <NuxtLink class="footer__slide-button" :to="slide.link">
                                <span>Открыть в каталоге</span>
                                <span><SvgSprite type="arrow" /></span>
                            </NuxtLink>
                        </div>
                    </EmblaSlide>
                </EmblaContainer>
                <div class="footer__slider-controls">
                    <button
                        class="footer__slider-button footer__slider-button--prev"
                        @click="scrollPrev"
                    >
                        <SvgSprite type="arrow" :size="20" />
                    </button>
                    <div class="footer__slider-pagination">
                        {{ selectedSpan }}
                        <span class="symbol">/</span>
                        {{ snapCount }}
                    </div>

                    <button
                        class="footer__slider-button footer__slider-button--next"
                        @click="scrollNext"
                    >
                        <SvgSprite type="arrow" :size="20" />
                    </button>
                </div>
            </div>
            <div class="footer__main">
                <NuxtLink class="footer__logo" :to="{ name: 'index' }">
                    <SvgSprite type="logo-full" size="100%" />
                </NuxtLink>
                <div class="footer__links">
                    <a href="tel:+">8 846 489-31-17</a>
                    <a href="mailto:">info@arabeska.ru</a>
                </div>
                <TheFooterForm class="footer__form" />
            </div>
            <div class="footer__nav">
                <div class="footer__nav-list footer__nav-list--map">
                    <h4 class="footer__nav-title">Карта сайта</h4>
                    <NuxtLink class="footer__nav-link" :to="{ name: 'index' }">Главная</NuxtLink>
                    <NuxtLink class="footer__nav-link" :to="{ name: 'index' }">Каталог</NuxtLink>
                    <NuxtLink class="footer__nav-link" :to="{ name: 'index' }">Отзывы</NuxtLink>
                    <NuxtLink class="footer__nav-link" :to="{ name: 'index' }">
                        Личный кабинет
                    </NuxtLink>
                    <NuxtLink class="footer__nav-link" :to="{ name: 'index' }">
                        Доставка и оплата
                    </NuxtLink>
                    <NuxtLink class="footer__nav-link" :to="{ name: 'index' }">Возврат</NuxtLink>
                    <NuxtLink class="footer__nav-link" :to="{ name: 'index' }">Оптовикам</NuxtLink>
                    <NuxtLink class="footer__nav-link" :to="{ name: 'index' }">Франшиза</NuxtLink>
                    <NuxtLink class="footer__nav-link" :to="{ name: 'index' }">Контакты</NuxtLink>
                </div>
                <div class="footer__nav-list footer__nav-list--socials">
                    <h4 class="footer__nav-title">Мы в соцсетях</h4>
                    <a
                        class="footer__nav-link"
                        href="https://example.com"
                        target="_blank"
                        rel="noopener noreferrer"
                    >
                        VK
                    </a>
                    <a
                        class="footer__nav-link"
                        href="https://example.com"
                        target="_blank"
                        rel="noopener noreferrer"
                    >
                        Instagram
                        <span class="symbol">*</span>
                    </a>
                    <a
                        class="footer__nav-link"
                        href="https://example.com"
                        target="_blank"
                        rel="noopener noreferrer"
                    >
                        Telegram
                    </a>
                </div>
                <div class="footer__nav-list footer__nav-list--address">
                    <h4 class="footer__nav-title">Магазины</h4>
                    <a
                        class="footer__nav-link"
                        href="https://example.com"
                        target="_blank"
                        rel="noopener noreferrer"
                    >
                        Проспект Кирова, 22
                    </a>
                    <a
                        class="footer__nav-link"
                        href="https://example.com"
                        target="_blank"
                        rel="noopener noreferrer"
                    >
                        Улица Ленина, 15, ТЦ «БигБэн», офис 21
                    </a>
                    <a
                        class="footer__nav-link"
                        href="https://example.com"
                        target="_blank"
                        rel="noopener noreferrer"
                    >
                        Площадь Славы, 5
                    </a>
                </div>
            </div>
            <div class="footer__info">
                <span class="footer__info-copy">2019 Arabeska. All Rights Reserved</span>
                <button class="footer__info-button">Политика конфиденциальности</button>
                <span class="footer__info-footnote">
                    *Instagram — продукт компании Meta, которая признана экстремистской организацией
                    в России
                </span>
            </div>
        </div>
    </footer>
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
    const selectedSpan = ref<number>();
    const snapCount = ref<number>();

    const updateSnapDisplay = () => {
        selectedSpan.value = (sliderRef.value?.emblaApi?.selectedScrollSnap() ?? 0) + 1;
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

    .footer {
        $p: &;

        color: $c-FFFFFF;
        padding: rem(64) 0 rem(16) 0;
        background-color: $c-secondary;
        &__container {
            display: grid;
            grid-template-areas:
                'slider main nav'
                'info info info';
            gap: rem(32);
            @include content-container;
        }
        &__slider {
            grid-area: slider;
            width: 100%;
            max-width: rem(484);
            &-controls {
                width: 100%;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: rem(16);
                font-size: rem(14);
                color: $c-98BBD7;
                margin-top: rem(24);
            }
            &-button {
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
        &__main {
            grid-area: main;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            gap: rem(32);
        }
        &__logo {
            display: block;
            max-width: rem(384);
            max-height: rem(48);
            @media (pointer: fine) {
                &:hover {
                    color: $c-accent;
                }
            }
        }
        &__links {
            display: flex;
            flex-direction: column;
            a {
                width: fit-content;
                font-family: 'Inter', sans-serif;
                font-size: lineScale(24, 18, 480, 1440);
                @include hover-blick-line($init-color: inherit);
            }
        }
        &__nav {
            grid-area: nav;
            width: 100%;
            display: grid;
            grid-template-areas:
                'map socials'
                'map address';
            justify-content: space-between;
            gap: rem(32) lineScale(64,32,480,1440);
            &-list {
                max-width: 20ch;
                display: flex;
                flex-direction: column;
                gap: rem(18);
                &--map {
                    grid-area: map;
                }
                &--socials {
                    grid-area: socials;
                }
                &--address {
                    grid-area: address;
                }
            }
            &-title {
                font-size: rem(18);
                margin-bottom: rem(8);
            }
            &-link {
                width: fit-content;
                color: $c-98BBD7;
                line-height: 1.2;
                @media (pointer: fine) {
                    &:hover {
                        color: $c-FFFFFF;
                    }
                }
            }
        }
        &__info {
            grid-area: info;
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: rem(32);
            color: $c-98BBD7;
            &-copy {
                cursor: default;
                font-size: rem(14);
                opacity: 0.5;
                white-space: nowrap;
                &::before {
                    content: '\00A9';
                    font-family: 'Inter', sans-serif;
                }
            }
            &-button {
                cursor: pointer;
                font-size: rem(14);
                font-weight: $fw-semi;
                white-space: nowrap;
                @media (pointer: fine){
                    &:hover{
                        color: $c-FFFFFF;
                    }
                }
            }
            &-footnote {
                font-size: rem(12);
                font-family: 'Inter', sans-serif;
                opacity: 0.5;
            }
        }
    }

    @media (max-width: 1440px){
        .footer {
            &__container {
                grid-template-areas: 
                    'main nav'
                    'info info';
                gap: rem(64) rem(32);
            }
            &__slider {
                display: none;
            }
        }
    }

    @media (max-width: 1024px){
        .footer {
            &__container {
                grid-template-areas: 
                    'main main'
                    'nav nav'
                    'info info';
            }
            &__nav {
                justify-content: initial;
            }
        }
    }
</style>
