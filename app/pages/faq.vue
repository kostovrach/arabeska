<template>
    <NuxtLayout>
        <div class="faq">
            <div class="faq__header">
                <picture class="faq__header-image-container">
                    <img class="faq__header-image" src="/img/service/flowers.jpg" alt="#" />
                </picture>
            </div>
            <div class="faq__container">
                <article class="faq__body">
                    <aside class="faq__sider">
                        <nav class="faq__nav">
                            <a class="faq__nav-link" href="#delivery"><span>Доставка</span></a>
                            <a class="faq__nav-link" href="#payment"><span>Оплата</span></a>
                            <a class="faq__nav-link" href="#terms-of-return">
                                <span>Условия возврата</span>
                            </a>
                        </nav>
                    </aside>
                    <div class="faq__content">
                        <section id="delivery" class="faq__section faq__section--delivery">
                            <h2 class="faq__section-title">Доставка</h2>
                            <div class="faq__section--delivery-about"></div>
                            <div class="faq__section-validator"></div>
                            <div class="faq__section--delivery-advant">
                                <h3 class="faq__section-subtitle">
                                    {{ advant.title }}
                                </h3>
                                <p class="faq__section--delivery-advant-desc">{{ advant.desc }}</p>
                                <ul class="faq__section--delivery-advant-list">
                                    <li
                                        v-for="(card, idx) in advant.items"
                                        :key="idx"
                                        class="faq__section--delivery-advant-item"
                                    >
                                        <h4>{{ card.title }}</h4>
                                        <p>{{ card.text }}</p>
                                    </li>
                                </ul>
                            </div>
                        </section>
                        <section id="payment" class="faq__section faq__section--payment">
                            <h2 class="faq__section-title">Оплата</h2>
                            <div class="faq__section-content"></div>
                        </section>
                        <section
                            id="terms-of-return"
                            class="faq__section faq__section--terms-of-return"
                        >
                            <h2 class="faq__section-title">Условия возврата</h2>
                            <div class="faq__section-content"></div>
                        </section>
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
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { IFaqItem } from '~/interfaces/faq-item';

    const faqList: IFaqItem[] = [
        {
            title: 'Как я могу присоединиться к бонусной программе?',
            body: `
            <p>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</p>
            `,
        },
        {
            title: 'Сколько бонусов я могу накопить за один заказ?',
            body: `
            <p>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</p>
            `,
        },
        {
            title: 'Какие преимущества мне дает бонусная программа?',
            body: `
            <p>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</p>
            `,
        },
        {
            title: 'Какой срок действия скидки?',
            body: `
                        <p>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</p>
                    `,
        },
    ];

    const advant = {
        title: 'Наши преимущества',
        desc: 'Вы можете выбрать интересующие опции при оформления заказа.',
        items: [
            {
                title: 'Анонимная доставка',
                text: 'Сохраните сюрприз до последнего момента с анонимной доставкой цветов. Напишите об этом в поле для комментария при оформлении заказа.',
            },
            {
                title: 'Если не знаете адрес получателя',
                text: 'Доставим заказ по номеру телефона получателя — мы созвонимся с получателем букета, выясним удобное время и адрес доставки. По телефону сохраним сюрприз, можем представиться курьерской службой.',
            },
            {
                title: 'Доставка к указанному времени',
                text: 'Вы можете заказать цветы у нас и быть уверенными в доставке ровно к указанному времени, чтобы порадовать своих любимых.',
            },
            {
                title: 'Встреча в аэропорту или на вокзале',
                text: 'Мы доставим свежие цветы сразу в руки, чтобы порадовать и оживить эмоции после путешествия.',
            },
            {
                title: 'SMS-уведомления',
                text: 'Мы доставим свежие цветы сразу в руки, чтобы порадовать и оживить эмоции после путешествия.',
            },
        ],
    };
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .faq {
        $p: &;
        @mixin text-content() {
            line-height: 1.3;
            h2,
            h3,
            h4,
            h5,
            h6 {
                font-size: lineScale(24, 18, 480, 1440);
                margin-bottom: rem(16);
            }
            ul,
            ol {
                display: flex;
                flex-direction: column;
                gap: rem(8);
                li {
                    margin-left: rem(22);
                }
            }
            ul > li {
                list-style: disc outside;
            }
            ol > li {
                list-style: decimal outside;
            }
        }

        &__header {
            $cover-height: rem(320);

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
            @include content-container;
        }
        &__body {
            display: grid;
            grid-template-columns: 30% auto;
            gap: rem(64);
            padding: rem(64) 0;
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
            gap: lineScale(96, 48, 480, 1440);
        }
        &__section {
            display: flex;
            flex-direction: column;
            gap: rem(64);
            border: rem(1) solid $c-D4E1E7;
            border-radius: rem(32);
            padding: rem(32);
            &--delivery {
                &-advant {
                    display: flex;
                    flex-direction: column;
                    gap: rem(32);
                    &-list {
                        display: grid;
                        grid-template-columns: repeat(auto-fill, minmax(rem(320), 1fr));
                        gap: rem(16);
                    }
                    &-item {
                        display: flex;
                        flex-direction: column;
                        gap: rem(32);
                        font-family: 'Inter', sans-serif;
                        color: $c-FFFFFF;
                        aspect-ratio: 1.2/1;
                        background-color: $c-accent;
                        border-radius: rem(16);
                        padding: rem(16);
                        @include text-content();
                    }
                }
            }
            &-title {
                font-size: lineScale(48, 24, 480, 1440);
                font-weight: $fw-semi;
            }
            &-subtitle {
                font-size: lineScale(32, 20, 480, 1440);
            }
            &-content {
                display: flex;
                flex-direction: column;
                gap: rem(16);
                font-size: lineScale(18, 16, 480, 1440);
                line-height: 1.3;
                padding: rem(16) rem(32);
                @include text-content();
            }
        }
    }
</style>
