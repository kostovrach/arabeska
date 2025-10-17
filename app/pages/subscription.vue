<template>
    <NuxtLayout>
        <SubscriptionHero />
        <SubscriptionPricing />
        <FaqSection
            title="Что вы получаете с подпиской?"
            description=' Это самые часто задаваемые вопросы и ответы на них. Если ты не нашел свой вопрос - напиши нам на почту: <a href="mailto:">info@intheplace.ru</a>'
            :content="faqList"
        />
        <Banner
            class="subscription-banner"
            title="Остались вопросы?"
            image-url="/img/temp/flowers.gif"
        >
            <div class="subscription-banner__content">
                <p class="subscription-banner__text">
                    Напишите нам в официальный профиль в telegram или whatsapp. Отвечаем в течение
                    24 часов
                </p>
                <div class="subscription-banner__links">
                    <a
                        class="subscription-banner__link"
                        href="https://example.com"
                        target="_blank"
                        rel="noopener noreferrer"
                    >
                        <span>Мы в Telegram</span>
                        <span><SvgSprite type="arrow" :size="24" /></span>
                    </a>
                    <a
                        class="subscription-banner__link"
                        href="https://example.com"
                        target="_blank"
                        rel="noopener noreferrer"
                    >
                        <span>Мы в Whatsapp</span>
                        <span><SvgSprite type="arrow" :size="24" /></span>
                    </a>
                </div>
            </div>
        </Banner>
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { IFaqItem } from '~/interfaces/faq-item';

    const faqList: IFaqItem[] = [
        {
            title: 'Как я могу присоединиться к бонусной программе?',
            body: `
                        <p>Мы узнаем все важные детали: какие букеты вам нравятся, какая упаковка, какая цветовая гамма. Какую задачу решают букеты: оправляем одному человеку с учетом его вкусов, или разным под каждый важный для вас повод.</p>
                    `,
        },
        {
            title: 'Сколько бонусов я могу накопить за один заказ?',
            body: `
                        <p>Мы узнаем все важные детали: какие букеты вам нравятся, какая упаковка, какая цветовая гамма. Какую задачу решают букеты: оправляем одному человеку с учетом его вкусов, или разным под каждый важный для вас повод.</p>
                    `,
        },
        {
            title: 'Какие преимущества мне дает бонусная программа?',
            body: `
                        <p>Мы узнаем все важные детали: какие букеты вам нравятся, какая упаковка, какая цветовая гамма. Какую задачу решают букеты: оправляем одному человеку с учетом его вкусов, или разным под каждый важный для вас повод.</p>
                    `,
        },
        {
            title: 'Какой срок действия скидки?',
            body: `
                        <p>Мы узнаем все важные детали: какие букеты вам нравятся, какая упаковка, какая цветовая гамма. Какую задачу решают букеты: оправляем одному человеку с учетом его вкусов, или разным под каждый важный для вас повод.</p>
                    `,
        },
    ];
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .subscription-banner {
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
            @include button-primary($anim-color: $c-accent, $gap: rem(16));
        }
    }
</style>
