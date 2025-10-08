<template>
    <section class="home-banner">
        <div class="home-banner__container">
            <div class="home-banner__title">
                <HomeBannerCircularText text="Бесконечное внимание" />
            </div>
            <div class="home-banner__content">
                <h2 class="home-banner__subtitle">
                    Еженедельная доставка свежих цветов для ваших любимых.
                </h2>
                <p class="home-banner__desc">
                    Описание — основной смысл. Используйте 1–2 предложения в 1–3 строчки, если
                    выравнивание по центру. При большем количестве текста используйте другой тип
                    выравнивания контента
                </p>
                <CircleButton
                    class="home-banner__button"
                    type="NuxtLink"
                    to="index"
                    logic="double-line"
                >
                    <span>Подписка на&nbsp;цветы</span>
                </CircleButton>
            </div>

            <picture class="home-banner__image-container">
                <img class="home-banner__image" src="/img/temp/temp1.jpg" alt="#" />
            </picture>

            <div class="home-banner__decorative-group home-banner__decorative-group--variant-1">
                <SvgSprite type="star" size="100%" />
                <SvgSprite type="star" size="100%" />
                <SvgSprite type="star" size="100%" />
            </div>
            <div class="home-banner__decorative-group home-banner__decorative-group--variant-2">
                <SvgSprite type="star" size="100%" />
            </div>
            <div class="home-banner__decorative-group home-banner__decorative-group--variant-3">
                <SvgSprite type="star" size="100%" />
                <SvgSprite type="star" size="100%" />
            </div>
            <div class="home-banner__decorative-group home-banner__decorative-group--variant-4">
                <SvgSprite type="star" size="100%" />
                <SvgSprite type="star" size="100%" />
            </div>
        </div>
    </section>
</template>

<script setup lang="ts"></script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .home-banner {
        position: relative;
        margin: rem(128) 0;
        overflow: visible;
        @include content-container;
        &__container {
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center;
            color: $c-FFFFFF;
            border-radius: rem(64);
        }
        &__title {
            position: relative;
            width: 100%;
            font-size: lineScale(22, 22, 480, 1440);
            font-weight: $fw-semi;
            height: lineScale(280, 128, 480, 1440);
        }
        &__content {
            position: relative;
            max-width: 75ch;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: rem(16);
            text-align: center;
            padding: rem(32) rem(64);
            padding-bottom: rem(164);
        }
        &__subtitle {
            font-size: lineScale(32, 20, 480, 1440);
            font-weight: $fw-semi;
        }
        &__button {
            position: absolute;
            right: 0;
            top: 50%;
        }
        &__image-container {
            position: absolute;
            inset: 0;
            z-index: -1;
            border-radius: inherit;
            overflow: hidden;
            img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                filter: blur(3px) brightness(60%);
            }
        }
        &__decorative-group {
            $small: lineScale(20, 12, 480, 1440);
            $medium: lineScale(36, 20, 480, 1440);
            $large: lineScale(48, 30, 480, 1440);

            position: absolute;
            width: lineScale(96, 64, 480, 1440);
            aspect-ratio: 1;
            > * {
                position: absolute;
                opacity: 0.7;
            }
            &--variant {
                &-1 {
                    left: 3%;
                    bottom: 15%;
                    :nth-child(1) {
                        width: $small;
                        top: 20%;
                        left: 0;
                    }
                    :nth-child(2) {
                        width: $medium;
                        bottom: -50%;
                        left: 20%;
                    }
                    :nth-child(3) {
                        width: $large;
                        top: 0;
                        right: 0;
                    }
                }
                &-2 {
                    top: 20%;
                    left: 15%;
                    :nth-child(1) {
                        width: $small;
                    }
                }
                &-3 {
                    top: 10%;
                    right: 10%;
                    :nth-child(1) {
                        width: $medium;
                        top: 0;
                        left: 0;
                    }
                    :nth-child(2) {
                        width: $small;
                        bottom: -30%;
                        left: 30%;
                    }
                }
                &-4 {
                    bottom: 10%;
                    right: 5%;
                    :nth-child(1) {
                        width: $medium;
                        bottom: -30%;
                        right: 0;
                    }
                    :nth-child(2) {
                        width: $small;
                        top: 10%;
                        left: 30%;
                    }
                }
            }
        }
    }
</style>
