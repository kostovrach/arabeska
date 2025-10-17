<template>
    <NuxtLayout>
        <section class="not-found-hero">
            <div class="not-found-hero__container">
                <picture class="not-found-hero__image-container">
                    <img class="not-found-hero__image" src="/img/service/404.jpg" alt="404" />
                </picture>
                <div class="not-found-hero__content">
                    <h1 class="not-found-hero__title">Страница не найдена</h1>
                    <p class="not-found-hero__desc">
                        Запрашиваемая страница не существует. Вы сможете найти интересующие цветы в
                        каталоге
                    </p>
                    <CircleButton
                        class="not-found-hero__button"
                        type="NuxtLink"
                        logic="double-line"
                        to="index"
                    >
                        <span>открыть каталог</span>
                    </CircleButton>
                </div>
            </div>
        </section>
    </NuxtLayout>
</template>

<script setup lang="ts"></script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .not-found-hero {
        @include content-block($margin: rem(32));
        &__container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            align-items: center;
            gap: rem(64);
            @include content-container;
        }
        &__image-container {
            width: 100%;
            aspect-ratio: 1.5/1;
            border-radius: rem(256);
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
        }
        &__title {
            font-size: lineScale(64, 32, 480, 1440);
        }
        &__desc {
            font-size: lineScale(22, 18, 480, 1440);
            line-height: 1.25;
            opacity: 0.8;
            margin-top: rem(40);
        }
        &__button {
            align-self: center;
            rotate: -8deg;
        }
    }

    @media (max-width: 1024px) {
        .not-found-hero {
            &__container {
                display: flex;
                flex-direction: column;
            }
        }
    }
</style>
