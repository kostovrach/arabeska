<template>
    <section class="subscription-hero">
        <div class="subscription-hero__container">
            <picture class="subscription-hero__image-container">
                <img class="subscription-hero__image" src="/img/temp/temp1.jpg" alt="#" />
            </picture>
            <div class="subscription-hero__content">
                <div class="subscription-hero__titlebox">
                    <span class="subscription-hero__tag">Цветочная подписка</span>
                    <h1 class="subscription-hero__title">Красота свежих цветов каждую неделю!</h1>
                </div>
                <ul class="subscription-hero__list">
                    <li class="subscription-hero__list-item">4 тарифа на выбор</li>
                    <li class="subscription-hero__list-item">Бесплатная доставка</li>
                    <li class="subscription-hero__list-item">Ваза в подарок</li>
                    <li class="subscription-hero__list-item">Подарочный сертификат</li>
                </ul>
                <p class="subscription-hero__desc">
                    Букет для подарка в нашей цветочной подписке — это букет, собранный точно в
                    соответствии с вашими пожеланиями, с заданными Вами параметрами доставки и
                    приятной скидкой.
                </p>
                <a class="subscription-hero__button" href="#pricing">
                    <span>Выбрать тариф</span>
                    <span><SvgSprite type="arrow" :size="18" /></span>
                </a>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts"></script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .subscription-hero {
        @include content-block($margin: rem(32));
        &__container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            @include content-container;
        }
        &__image-container {
            width: 100%;
            aspect-ratio: 1.1/1;
            border-radius: rem(32);
            overflow: hidden;
        }
        &__image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        &__content {
            display: flex;
            flex-direction: column;
            gap: rem(64);
            padding: rem(64) lineScale(64, 16, 480, 1920);
        }
        &__titlebox {
            display: flex;
            flex-direction: column;
            gap: rem(16);
            font-family: 'Inter', sans-serif;
        }
        &__tag {
            width: fit-content;
            color: $c-FFFFFF;
            background-color: $c-secondary;
            border-radius: rem(16);
            padding: rem(6) rem(16);
        }
        &__title {
            font-size: lineScale(48, 28, 480, 1440);
            font-weight: $fw-semi;
        }
        &__list {
            display: flex;
            flex-wrap: wrap;
            gap: rem(16);
            &-item {
                flex: 1 1 rem(300);
                font-size: lineScale(20, 16, 480, 1440);
                background-color: $c-E5F2D8;
                border-radius: rem(16) rem(16) rem(16) 0;
                padding: rem(16) rem(24);
            }
        }
        &__desc {
            font-size: lineScale(18, 16, 480, 1440);
            line-height: 1.3;
        }
        &__button {
            @include button-primary(
                $anim-color: $c-accent,
                $gap: rem(16),
                $padding: rem(12) rem(40),
                $font-size: rem(18),
                $border-color: $c-accent
            );
            > span:has(svg) {
                rotate: 90deg;
            }
        }
    }

    @media (max-width: 1024px) {
        .subscription-hero {
            margin: 0;
            &__container {
                grid-template-columns: 100%;
                padding: 0;
            }
            &__image-container {
                border-radius: 0;
                aspect-ratio: initial;
                height: rem(240);
            }
        }
    }
</style>
