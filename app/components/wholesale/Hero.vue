<template>
    <section class="wholesale-hero">
        <picture class="wholesale-hero__image-container">
            <img
                class="wholesale-hero__image"
                src="/img/temp/temp1.jpg"
                alt="Всегда свежие цветы для бизнеса"
            />
        </picture>
        <div class="wholesale-hero__container">
            <span class="wholesale-hero__tag">Оптовикам</span>
            <h1 class="wholesale-hero__title">Всегда свежие цветы для бизнеса</h1>
            <p class="wholesale-hero__desc">
                Свежие цветы с нашей собственной фермы в Самарской области. Наши официальные
                оптовики получают доступ к многоуровневой партнёрской программе, скидки на
                продукцию, подарки и многое другое
            </p>
            <button class="wholesale-hero__button" type="button">
                <span>Подать заявку</span>
                <span><SvgSprite type="arrow" :size="24" /></span>
            </button>
        </div>
    </section>
</template>

<script setup lang="ts"></script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .wholesale-hero {
        position: relative;
        width: 100%;
        color: $c-FFFFFF;
        overflow: hidden;
        &__image-container {
            position: fixed;
            top: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            filter: brightness(60%);
        }
        &__image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        &__container {
            position: relative;
            z-index: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            @include content-container($padding: rem(96) $px);
        }
        &__tag {
            width: fit-content;
            font-family: 'Inter', sans-serif;
            background-color: $c-accent;
            padding: rem(5) rem(16);
            border-radius: rem(32);
        }
        &__title {
            max-width: 18ch;
            font-size: lineScale(96, 48, 480, 1440);
            line-height: 0.8;
            font-weight: $fw-semi;
            margin-top: rem(16);
        }
        &__desc {
            max-width: 60ch;
            font-size: lineScale(18, 16, 480, 1440);
            line-height: 1.2;
            margin-top: rem(64);
        }
        &__button {
            margin-top: rem(32);
            @include button-primary($anim-color: $c-accent, $gap: rem(16));
        }
    }
</style>
