<template>
    <footer class="footer">
        <div class="footer__container">
            <TheFooterSlider class="footer__slider" />
            <div class="footer__main">
                <NuxtLink class="footer__logo" :to="{ name: 'index' }">
                    <SvgSprite type="logo-full" size="100%" />
                </NuxtLink>
                <div class="footer__links">
                    <a href="tel:+">8 846 489-31-17</a>
                    <a href="mailto:">info@arabeska.ru</a>
                </div>
                <SubscribeForm class="footer__form" title="Сэкономьте 5% за подписку!" />
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

<script setup lang="ts"></script>

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
        }
        &__main {
            grid-area: main;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            gap: rem(32);
        }
        &__form {
            color: $c-D4E1E7;
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
            gap: rem(32) lineScale(64, 32, 480, 1440);
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
                @media (pointer: fine) {
                    &:hover {
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

    @media (max-width: 1440px) {
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

    @media (max-width: 1024px) {
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
