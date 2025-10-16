<template>
    <section class="home-advant">
        <div class="home-advant__container">
            <StarsOverlay class="home-advant__title">
                <h2>Наши преимущества</h2>
            </StarsOverlay>
            <ul class="home-advant__list">
                <li class="home-advant__item">
                    <div class="home-advant__item-wrapper">
                        <picture class="home-advant__item-image-container">
                            <img
                                class="home-advant__item-image"
                                src="/img/temp/placeholder-900x900.jpg"
                                alt="#"
                            />
                        </picture>
                        <div class="home-advant__item-content home-advant__item-content--centered">
                            <h3 class="home-advant__item-title">Собственная ферма</h3>
                            <p class="home-advant__item-desc">
                                Непревзойденно-высокое качество свечей, подсвечников и упаковочной
                                продукции подарит незабываемые впечатления каждому, получившему
                                такой презент
                            </p>
                            <figure class="home-advant__item-composition">
                                <img src="/img/temp/placeholder-900x900.jpg" alt="#" />
                                <figcaption>
                                    Непревзойденно-высокое качество свечей, подсвечников и
                                    упаковочной продукции подарит незабываемые впечатления каждому,
                                    получившему такой презент
                                </figcaption>
                            </figure>
                        </div>
                    </div>
                </li>
                <li class="home-advant__item">
                    <div class="home-advant__item-wrapper">
                        <picture class="home-advant__item-image-container">
                            <img
                                class="home-advant__item-image"
                                src="/img/temp/placeholder-900x900.jpg"
                                alt="#"
                            />
                        </picture>
                        <div class="home-advant__item-content">
                            <h3 class="home-advant__item-title">Быстрая доставка</h3>
                            <p class="home-advant__item-desc">
                                Непревзойденно-высокое качество свечей, подсвечников и упаковочной
                                продукции подарит незабываемые впечатления каждому, получившему
                                такой презент
                            </p>
                            <NuxtLink class="home-advant__item-button" :to="{ name: 'index' }">
                                <span>О доставке</span>
                                <span><SvgSprite type="arrow" /></span>
                            </NuxtLink>
                        </div>
                    </div>
                </li>
                <li class="home-advant__item">
                    <div class="home-advant__item-wrapper">
                        <picture class="home-advant__item-image-container">
                            <img
                                class="home-advant__item-image"
                                src="/img/temp/placeholder-900x900.jpg"
                                alt="#"
                            />
                        </picture>
                        <div class="home-advant__item-content">
                            <h3 class="home-advant__item-title">Опт для бизнеса</h3>
                            <p class="home-advant__item-desc">
                                В Arabeska мы искренне считаем, что каждая свеча должна быть
                                шедевром. Мы стремимся создавать не только функциональную продукцию,
                                но и красивые, эстетичные и долговечные предметы интерьера
                            </p>
                            <NuxtLink class="home-advant__item-button" :to="{ name: 'index' }">
                                <span>Оптовикам</span>
                                <span><SvgSprite type="arrow" /></span>
                            </NuxtLink>
                            <div class="home-advant__item-gallery">
                                <picture class="home-advant__item-gallery-image-container">
                                    <img
                                        class="home-advant__item-gallery-image"
                                        src="/img/temp/placeholder-900x900.jpg"
                                        alt="#"
                                    />
                                </picture>
                                <picture class="home-advant__item-gallery-image-container">
                                    <img
                                        class="home-advant__item-gallery-image"
                                        src="/img/temp/placeholder-900x900.jpg"
                                        alt="#"
                                    />
                                </picture>
                                <picture class="home-advant__item-gallery-image-container">
                                    <img
                                        class="home-advant__item-gallery-image"
                                        src="/img/temp/placeholder-900x900.jpg"
                                        alt="#"
                                    />
                                </picture>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </section>
</template>

<script setup lang="ts"></script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .home-advant {
        $p: &;

        @include content-block;
        &__container {
            display: flex;
            flex-direction: column;
            gap: rem(64);
            @include content-container;
        }
        &__title {
            width: fit-content;
            align-self: center;
            font-size: lineScale(64, 32, 480, 1440);
            font-weight: $fw-semi;
            text-align: center;
        }
        &__list {
            display: flex;
            flex-direction: column;
            gap: rem(32);
        }
        &__item {
            &:nth-child(odd) {
                #{$p}__item-wrapper {
                    grid-template-areas: 'image content';
                }
            }
            &:nth-child(even) {
                #{$p}__item-wrapper {
                    grid-template-areas: 'content image';
                }
            }
            &-wrapper {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                align-items: center;
                gap: rem(32);
            }
            &-image-container {
                grid-area: image;
                width: 100%;
                height: 100%;
                max-height: rem(720);
                border-radius: rem(64);
                overflow: hidden;
                img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }
            }
            &-content {
                grid-area: content;
                display: flex;
                flex-direction: column;
                padding: lineScale(64, 16, 480, 1440);
                &--centered {
                    align-items: center;
                    text-align: center;
                }
            }
            &-title {
                font-size: lineScale(32, 24, 480, 1440);
            }
            &-desc {
                font-size: lineScale(18, 16, 480, 1440);
                line-height: 1.4;
                margin-top: rem(32);
            }
            &-button {
                margin-top: rem(48);
                @include button-primary(
                    $border-color: $c-98BBD7,
                    $padding: rem(18) lineScale(48, 32, 480, 1440),
                    $anim-color: $c-accent
                );
            }
            &-composition {
                margin-top: lineScale(96, 64, 480, 1440);
                img {
                    width: 100%;
                    max-height: rem(220);
                    object-fit: cover;
                }
                figcaption {
                    margin-top: rem(16);
                    opacity: 0.5;
                }
            }
            &-gallery {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                grid-template-areas: 'image-1 . image-2 image-3';
                gap: rem(16);
                margin-top: lineScale(64, 32, 480, 1440);
                &-image-container {
                    width: 100%;
                    height: 100%;
                    &:nth-child(1) {
                        grid-area: image-1;
                    }
                    &:nth-child(2) {
                        grid-area: image-2;
                    }
                    &:nth-child(3) {
                        grid-area: image-3;
                    }
                    img {
                        width: 100%;
                        height: 100%;
                        object-fit: cover;
                    }
                }
            }
        }
    }

    @media (max-width: 1024px) {
        .home-advant {
            &__list {
                gap: rem(96);
            }
            &__item {
                &-wrapper {
                    display: flex;
                    flex-direction: column;
                }
                &-content {
                    padding: 0;
                }
                &-image-container {
                    width: 100%;
                    height: rem(320);
                }
            }
        }
    }
</style>
