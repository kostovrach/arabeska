<template>
    <section class="wholesale-list">
        <ul class="wholesale-list__container">
            <li class="wholesale-list__item" v-for="(item, idx) in listItems" :key="idx">
                <picture class="wholesale-list__item-image-container">
                    <img class="wholesale-list__item-image" :src="item.imageUrl" :alt="`${idx}`" />
                </picture>
                <div class="wholesale-list__item-content" v-html="item.content"></div>
            </li>
        </ul>
    </section>
</template>

<script setup lang="ts">
    interface IListItem {
        imageUrl: string;
        content: string;
    }

    const listItems: IListItem[] = [
        {
            imageUrl: '/img/temp/placeholder-900x900.jpg',
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
            imageUrl: '/img/temp/placeholder-900x900.jpg',
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
            imageUrl: '/img/temp/placeholder-900x900.jpg',
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
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

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
