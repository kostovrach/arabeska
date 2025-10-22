<template>
    <section class="faq-terms-of-return">
        <h2 class="faq-terms-of-return__title">{{ section.title }}</h2>
        <div class="faq-terms-of-return__content" v-html="section.content"></div>
    </section>
</template>

<script setup lang="ts">
    const section = {
        title: 'Условия возврата',
        content: `                    <p>
                        В случае отсутствия получателя по адресу доставки или его отказа от
                        получения букета, мы готовы доставить цветы по другому адресу. Данные
                        предложение касается только монобукетов. Если получатель не смог принять
                        букет по указанному адресу, мы вернём стоимость заказа за вычетом услуг
                        курьерской службы. Мы также можем оформить повторную доставку. Сборные
                        композиции можно будет доставить повторно в течение 24-х часов по новому
                        адресу в черте города с повторной оплатой доставки.
                    </p>
                    <ul>
                        <li>
                            С 9:00 - 21:00 доставим цветы по Самаре бесплатно при заказе от 1500 ₽;
                        </li>
                        <li>Если стоимость заказа менее 1500 ₽, то стоимость доставки 300 ₽.</li>
                    </ul>
                    <ol>
                        <li>Всегда делайте срез над сочленнением стебля;</li>
                        <li>Нож обязательно должен быть чистым;</li>
                        <li>Никогда не подрезайте стебли ножницами — это сминает сосуды.</li>
                    </ol>
                    <p>
                        Более подробную информацию по возможности и стоимости доставки уточняйте у
                        менеджера компании LINKO по телефону
                        <a href="">+7 (812) 200-50-76</a>
                    </p>`,
    };
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .faq-terms-of-return {
        @mixin text-content() {
            display: flex;
            flex-direction: column;
            gap: rem(8);
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

        &__title {
            font-size: lineScale(48, 24, 480, 1440);
            font-weight: $fw-semi;
        }
        &__desc {
            max-width: 70ch;
            font-size: lineScale(18, 16, 480, 1440);
            line-height: 1.4;
            opacity: 0.8;
        }
        &__subtitle {
            font-size: lineScale(32, 20, 480, 1440);
        }
        &__content {
            max-width: 80ch;
            @include text-content();
        }
    }
</style>
