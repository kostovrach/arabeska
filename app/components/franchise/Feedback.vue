<template>
    <section class="franchise-feedback">
        <div class="franchise-feedback__container">
            <div class="franchise-feedback__titlebox">
                <h2 class="franchise-feedback__title">>100 человек уже прошли обучение</h2>
                <p class="franchise-feedback__desc">
                    Мы ценим каждого партнера и стремимся создать для Вас комфортные условия работы,
                    чтобы помочь им достичь своих целей и обеспечить стабильный и прибыльный
                    источник дохода.
                </p>
            </div>
            <div class="franchise-feedback__body">
                <FeedbackCarousel />
            </div>
        </div>
    </section>
</template>

<script setup lang="ts"></script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .franchise-feedback {
        @include content-block($margin: rem(64));
        &__container {
            @include content-container;
        }
        &__titlebox {
            display: flex;
            flex-direction: column;
            gap: rem(32);
        }
        &__title {
            max-width: 20ch;
            text-wrap: balance;
            font-family: 'Inter', sans-serif;
            font-size: lineScale(64, 32, 480, 1440);
            font-weight: $fw-semi;
        }
        &__desc {
            max-width: 60ch;
            font-size: lineScale(18, 16, 480, 1440);
            line-height: 1.25;
            opacity: 0.8;
        }
        &__body {
            margin-top: rem(64);
        }
    }
</style>
