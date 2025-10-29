<template>
    <NuxtLayout>
        <div class="faq">
            <div class="faq__header">
                <picture class="faq__header-image-container">
                    <img class="faq__header-image" src="/img/service/flowers.jpg" alt="#" />
                </picture>
            </div>
            <div class="faq__container">
                <div class="faq__wrapper">
                    <article class="faq__body">
                        <aside class="faq__sider">
                            <nav class="faq__nav">
                                <a class="faq__nav-link" href="#delivery-rules">
                                    <span>Доставка</span>
                                </a>
                                <a class="faq__nav-link" href="#payment"><span>Оплата</span></a>
                                <a class="faq__nav-link" href="#terms-of-return">
                                    <span>Условия возврата</span>
                                </a>
                            </nav>
                        </aside>
                        <div class="faq__content">
                            <FaqDelivery id="delivery-rules" class="faq__section" />
                            <FaqPayment id="payment" class="faq__section" />
                            <FaqTermsOfReturn id="terms-of-return" class="faq__section" />
                            <FaqSection
                                class="faq__section"
                                title="Популярные вопросы"
                                description="Это самые часто задаваемые вопросы и ответы на них. Если вы не нашли ответа на свой вопрос - напишите нам на почту: <a href='mailto:'>info@intheplace.ru</a>"
                                :content="faqList"
                                vertical
                            />
                        </div>
                    </article>
                </div>
            </div>
        </div>
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { IFaqItem } from '~~/interfaces/faq-item';

    // mock-data =====================================================
    const faqList: IFaqItem[] = [
        {
            title: 'Как я могу присоединиться к бонусной программе?',
            content: `
            <p>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</p>
            `,
        },
        {
            title: 'Сколько бонусов я могу накопить за один заказ?',
            content: `
            <p>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</p>
            `,
        },
        {
            title: 'Какие преимущества мне дает бонусная программа?',
            content: `
            <p>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</p>
            `,
        },
        {
            title: 'Какой срок действия скидки?',
            content: `
                        <p>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</p>
                    `,
        },
    ];

    // ===============================================================
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .faq {
        $p: &;

        &__header {
            $cover-height: lineScale(320, 160, 480, 1440);

            height: $cover-height;
            &-image-container {
                position: fixed;
                z-index: -1;
                top: 0;
                width: 100%;
                height: calc($cover-height + rem(128));
            }
            &-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
        }
        &__container {
            background-color: $c-main;
        }
        &__wrapper {
            @include content-container;
        }
        &__body {
            display: grid;
            grid-template-columns: 30% auto;
            gap: lineScale(64, 32, 480, 1440);
            padding: lineScale(64, 32, 480, 1440) 0;
        }
        &__sider {
            position: relative;
            height: 100%;
        }
        &__nav {
            position: sticky;
            top: rem(128);
            display: flex;
            flex-direction: column;
            border-radius: rem(32);
            box-shadow: 5px 5px 15px rgba(#000, 0.3);
            &-link {
                font-size: lineScale(24, 18, 480, 1440);
                @include frame-scale($padding: rem(18) rem(32), $border-radius: rem(32));
            }
        }
        &__content {
            display: flex;
            flex-direction: column;
            gap: rem(64);
        }
        &__section {
            display: flex;
            flex-direction: column;
            gap: rem(64);
            border: rem(1) solid $c-D4E1E7;
            font-family: 'Inter', sans-serif;
            border-radius: rem(32);
            padding: rem(32);
            scroll-margin: rem(128);
        }
    }

    @media (max-width: 1024px) {
        .faq {
            &__sider {
                display: none;
            }
            &__body {
                grid-template-columns: 100%;
            }
        }
    }

    @media (max-width: 768px) {
        .faq {
            &__section {
                padding: 0;
                border: initial;
            }
        }
    }
</style>
