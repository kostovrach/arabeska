<template>
    <NuxtLayout>
        <FeedbackHero />
        <FeedbackList />
        <Banner
            class="feedback-banner"
            title="Поделитесь своими впечатлениями"
            image-url="/img/temp/flowers.gif"
        >
            <div class="feedback-banner__content">
                <p class="feedback-banner__text">Оставьте свой отзыв о вашем опыте заказа цветов</p>
                <div class="feedback-banner__links">
                    <a
                        class="feedback-banner__link"
                        href="https://example.com"
                        target="_blank"
                        rel="noopener noreferrer"
                    >
                        <span>Мы в 2GIS</span>
                        <span><SvgSprite type="arrow" :size="24" /></span>
                    </a>
                    <a
                        class="feedback-banner__link"
                        href="https://example.com"
                        target="_blank"
                        rel="noopener noreferrer"
                    >
                        <span>Мы на Яндекс.Картах</span>
                        <span><SvgSprite type="arrow" :size="24" /></span>
                    </a>
                    <a
                        class="feedback-banner__link"
                        href="https://example.com"
                        target="_blank"
                        rel="noopener noreferrer"
                    >
                        <span>Мы на картах Google</span>
                        <span><SvgSprite type="arrow" :size="24" /></span>
                    </a>
                </div>
            </div>
        </Banner>
    </NuxtLayout>
</template>

<script setup lang="ts"></script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .feedback-banner {
        &__content {
            display: flex;
            flex-direction: column;
            gap: rem(32);
        }
        &__links {
            display: flex;
            flex-wrap: wrap;
            gap: rem(16);
        }
        &__link {
            @include button-primary(
                $anim-color: $c-accent,
                $gap: rem(16),
                $font-size: lineScale(18, 16, 480, 1440)
            );
        }
    }
</style>
