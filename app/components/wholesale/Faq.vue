<template>
    <section class="wholesale-faq">
        <div class="wholesale-faq__container">
            <div class="wholesale-faq__titlebox">
                <h3 class="wholesale-faq__title">Популярные вопросы</h3>
                <p class="wholesale-faq__desc">
                    Это самые часто задаваемые вопросы и ответы на них. Если вы не нашли ответа на
                    свой вопрос - напишите нам на почту:
                    <a href="mailto:">info@intheplace.ru</a>
                </p>
            </div>
            <div class="wholesale-faq__body">
                <Accordion class="wholesale-faq__list" multiple>
                    <template #expandicon>
                        <span
                            class="wholesale-faq__item-icon wholesale-faq__item-icon--expand"
                        ></span>
                    </template>
                    <template #collapseicon>
                        <span
                            class="wholesale-faq__item-icon wholesale-faq__item-icon--collapse"
                        ></span>
                    </template>
                    <AccordionPanel
                        v-for="(item, idx) in faqList"
                        :key="idx"
                        class="wholesale-faq__item"
                        :value="idx"
                    >
                        <AccordionHeader>
                            <h4 class="wholesale-faq__item-title">{{ item.title }}</h4>
                        </AccordionHeader>
                        <AccordionContent>
                            <div class="wholesale-faq__item-content" v-html="item.content"></div>
                        </AccordionContent>
                    </AccordionPanel>
                </Accordion>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    interface IFaqItem {
        title: string;
        content: string;
    }

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
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .wholesale-faq {
        padding: rem(64) 0;
        &__container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: rem(48);
            @include content-container;
        }
        &__titlebox {
            display: flex;
            flex-direction: column;
            gap: rem(16);
        }
        &__title {
            font-size: lineScale(32, 24, 480, 1440);
        }
        &__desc {
            max-width: 50ch;
            font-family: 'Inter', sans-serif;
            font-size: lineScale(18, 16, 480, 1440);
            line-height: 1.3;
            a {
                color: $c-accent;
                text-decoration: underline;
                @media (pointer: fine) {
                    &:hover {
                        text-decoration: none;
                    }
                }
            }
        }
        &__titlebox,
        &__body {
            padding: rem(32);
        }
        &__list {
            display: flex;
            flex-direction: column;
            gap: rem(16);
            * {
                border-style: hidden !important;
            }
        }
        &__item {
            font-family: 'Inter', sans-serif;
            box-shadow: 0 3px 5px rgba($c-secondary, 0.2);
            border-radius: rem(16);
            &-icon {
                display: block;
                min-width: rem(8);
                max-width: rem(8);
                aspect-ratio: 1;
                margin-right: rem(16);
                &--expand {
                    background-color: currentColor;
                    border-radius: 50%;
                }
                &--collapse {
                    background-color: $c-accent;
                    border-radius: 0;
                }
            }
            &-title {
                font-size: rem(18);
                font-weight: $fw-semi;
                padding: rem(16) rem(32);
            }
            &-content {
                display: flex;
                flex-direction: column;
                gap: rem(16);
                font-size: lineScale(18, 16, 480, 1440);
                line-height: 1.3;
                padding: rem(16) rem(32);
                h2,
                h3,
                h4,
                h5,
                h6 {
                    font-size: lineScale(32, 24, 480, 1440);
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
        }
    }

    @media (max-width: 1024px) {
        .wholesale-faq {
            &__container {
                display: flex;
                flex-direction: column;
            }
            &__titlebox,
            &__body {
                padding: 0;
            }
        }
    }
</style>
