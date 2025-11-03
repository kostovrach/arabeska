<template>
    <NuxtLayout>
        <SubscriptionHero />
        <SubscriptionPricing />
        <AccordionSection
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
    // types ======================================================
    interface ISubscriptionPage {
        id: number | string;
        date_created: string;
        date_updated?: string;

        hero_image: string;
        hero_image_url: string;
        hero_tag?: string;
        hero_title: string;
        hero_description?: string;
        hero_info?: string[];
        hero_button_text?: string;

        pricing_title?: string;
        pricing_description?: string;

        faq_title: string;
        faq_description?: string;
        faq_blocks?: {
            title: string;
            content: string;
        }[];

        banner_image: string;
        banner_image_url: string;
        banner_title: string;
        banner_content?: string;
        banner_buttons?: {
            title: string;
            link: string;
        }[];
    }
    // ============================================================

    // data =======================================================
    const { content: page } = useCms<ISubscriptionPage>('subscription');
    // ============================================================
    const faqList = [
        {
            title: 'Как я могу присоединиться к бонусной программе?',
            content: `
                        <p>Мы узнаем все важные детали: какие букеты вам нравятся, какая упаковка, какая цветовая гамма. Какую задачу решают букеты: оправляем одному человеку с учетом его вкусов, или разным под каждый важный для вас повод.</p>
                    `,
        },
        {
            title: 'Сколько бонусов я могу накопить за один заказ?',
            content: `
                        <p>Мы узнаем все важные детали: какие букеты вам нравятся, какая упаковка, какая цветовая гамма. Какую задачу решают букеты: оправляем одному человеку с учетом его вкусов, или разным под каждый важный для вас повод.</p>
                    `,
        },
        {
            title: 'Какие преимущества мне дает бонусная программа?',
            content: `
                        <p>Мы узнаем все важные детали: какие букеты вам нравятся, какая упаковка, какая цветовая гамма. Какую задачу решают букеты: оправляем одному человеку с учетом его вкусов, или разным под каждый важный для вас повод.</p>
                    `,
        },
        {
            title: 'Какой срок действия скидки?',
            content: `
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
