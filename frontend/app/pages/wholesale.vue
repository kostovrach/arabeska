<template>
    <NuxtLayout>
        <!-- <InfoHero
            class="wholesale-hero"
            :image-url="content.hero.image_url"
            :tag="content.hero.tag"
            :title="content.hero.title"
            :desc="content.hero.description"
        >
            <template #button>
                <button class="wholesale-hero__button" type="button">
                    <span>Подать заявку</span>
                    <span><SvgSprite type="arrow" :size="24" /></span>
                </button>
            </template>
        </InfoHero> -->
        <div class="wholesale">
            <!-- <section class="wholesale-list">
                <ul class="wholesale-list__container">
                    <li v-for="(item, idx) in content.advant" :key="idx" class="wholesale-list__item">
                        <picture class="wholesale-list__item-image-container">
                            <img
                                class="wholesale-list__item-image"
                                :src="item.wholesale_advant_id.image_url"
                                :alt="`${idx}`"
                            />
                        </picture>
                        <div
                            class="wholesale-list__item-content"
                            v-html="item.wholesale_advant_id.content"
                        ></div>
                    </li>
                </ul>
            </section> -->
            <FaqSection
                title="Популярные вопросы"
                description="Это самые часто задаваемые вопросы и ответы на них. Если вы не нашли ответа на свой вопрос - напишите нам на почту: <a href='mailto:'>info@intheplace.ru</a>"
                :content="faqList"
            />
            <Banner
                class="wholesale-banner"
                title="Начните работать с нами!"
                image-url="/img/temp/flowers.gif"
            >
                <div class="wholesale-banner__content">
                    <p class="wholesale-banner__text">
                        Наши официальные оптовики получают неоспоримые преимущества партнёрства:
                        доступ к многоуровневой партнёрской программе, скидки на продукцию, подарки
                        и многое другое
                    </p>
                    <button class="wholesale-banner__button" type="button">
                        <span>Подать заявку</span>
                        <span><SvgSprite type="arrow" :size="24" /></span>
                    </button>
                </div>
            </Banner>
        </div>
    </NuxtLayout>
</template>

<script setup lang="ts">
    // types =================================================================
    import type { IFaqItem } from '~~/interfaces/faq-item';

    interface IListItem {
        imageUrl: string;
        content: string;
    }
    // =======================================================================

    // test directus
    const { content, pending, error } = useCms('wholesale', [
        'hero.*',
        'advant.*',
        'advant.wholesale_advant_id.*',
    ]);
    console.log(content);

    

    // data ==================================================================
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

    const listItems: IListItem[] = [
        {
            imageUrl: '/img/temp/temp1.jpg',
            content: `
            <h2>Для флористов, маркетинговых и свадебных агентств</h2>
            <p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>
            <ul>
            <li>
            Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы
            получаете бонусы, которые можно использовать для получения скидок.
            </li>
            <li>
                                Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в
                                следующем месяце.
                            </li>
                            <li>
                            Качество от производителя: Все цветы поступают с нашей фермы, что
                            гарантирует свежесть и высокое качество.
                            </li>
                            </ul>
                            `,
        },
        {
            imageUrl: '/img/temp/temp1.jpg',
            content: `
                            <h2>Минимальные партии для заказа</h2>
                            <p>
                            При оптовых покупках цветов с нашей фермы вы можете воспользоваться
                            следующими условиями:
                            </p>
                            <ol>
                            <li>Минимальная партия составляет всего 10 букетов.</li>
                            <li>
                            Заказы на сумму от 5000 рублей дают вам право на накопление бонусов,
                            которые можно использовать для получения скидок на будущие покупки.
                            </li>
                            <li>
                            Для доступа к личному кабинету, где вы сможете отслеживать свои бонусы и
                            прогресс, необходимо зарегистрироваться на нашем сайте или ввести номер
                            телефона, указанный при оформлении заказа. Обратите внимание, что
                            информация о бонусах обновляется с небольшой задержкой.
                            </li>
                            </ol>
                            `,
        },
        {
            imageUrl: '/img/temp/temp1.jpg',
            content: `
            <h2>Оптовые цены</h2>
                        <p>
                        При оптовых закупках цветов с нашей фермы вы можете воспользоваться
                        уникальной системой скидок, которая зависит от объёма ваших покупок. Чем
                        больше вы заказываете, тем выше ваша скидка на следующие заказы!
                        </p>
                        <p>Уровни скидок:</p>
                        <ul>
                        <li>Начальный — скидка 0% для новых клиентов.</li>
                        <li>Постоянный — скидка 5% при заказе от 100 000 рублей.</li>
                        <li>Премиум — скидка 15% при заказе от 300 000 рублей.</li>
                        <li>Элитный — скидка 25% при заказе от 1 000 000 рублей.</li>
                        </ul>
                        `,
        },
    ];
    // =======================================================================
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .wholesale {
        background-color: $c-main;
    }
    .wholesale-hero {
        &__button {
            margin-top: rem(32);
            @include button-primary($anim-color: $c-accent, $gap: rem(16));
        }
    }
    .wholesale-list {
        padding: rem(64) 0;
        &__container {
            display: flex;
            flex-direction: column;
            gap: rem(32);
            @include content-container;
        }
        &__item {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            align-items: center;
            gap: rem(32);
            &:nth-child(odd) {
                grid-template-areas: 'image content';
            }
            &:nth-child(even) {
                grid-template-areas: 'content image';
            }
            &-image-container {
                grid-area: image;
                width: 100%;
                aspect-ratio: 1.3/1;
                border-radius: rem(32);
                overflow: hidden;
            }
            &-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            &-content {
                grid-area: content;
                display: flex;
                flex-direction: column;
                gap: rem(16);
                font-family: 'Inter', sans-serif;
                font-size: lineScale(18, 16, 480, 1440);
                line-height: 1.3;
                padding: rem(32);
                h2 {
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
    .wholesale-banner {
        &__content {
            display: flex;
            flex-direction: column;
            gap: rem(32);
        }
        &__text {
            line-height: 1.2;
        }
        &__button {
            @include button-primary($anim-color: $c-accent);
        }
    }

    @media (max-width: 1024px) {
        .wholesale-list {
            &__container {
                gap: rem(64);
            }
            &__item {
                display: flex;
                flex-direction: column;
                &-image-container {
                    aspect-ratio: auto;
                    height: rem(320);
                }
                &-content {
                    padding: 0;
                }
            }
        }
    }
</style>
