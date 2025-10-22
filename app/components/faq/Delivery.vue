<template>
    <section class="faq-delivery">
        <h2 class="faq-delivery__title">{{ section.title }}</h2>
        <p class="faq-delivery__desc">{{ section.desc }}</p>
        <ul class="faq-delivery__info">
            <li
                v-for="item in section.info"
                :key="item.id"
                class="faq-delivery__info-item"
                v-html="item.content"
            ></li>
        </ul>
        <div class="faq-delivery__address">
            <h3 class="faq-delivery__subtitle">Зоны доставки</h3>
            <h3 class="faq-delivery__desc">Проверьте свой адрес</h3>
            <div class="faq-delivery__address-validator">
                <FloatLabel
                    class="faq-delivery__address-validator-input"
                    variant="on"
                    autocomplete="off"
                >
                    <InputText id="address-validator" />
                    <label for="address-validator">Введите улицу и № дома</label>
                </FloatLabel>
                <button class="faq-delivery__address-validator-button" type="button">
                    <span>Проверить адрес</span>
                </button>
                <span class="faq-delivery__address-validator-result">
                    ✅ Доставка по указанному адресу возможна
                </span>
            </div>

            <picture class="faq-delivery__address-image">
                <img src="/img/temp/map.jpg" alt="#" />
            </picture>
            <div class="faq-delivery__hint" v-html="section.hint"></div>
        </div>

        <div class="faq-delivery__advant">
            <h3 class="faq-delivery__subtitle">{{ advant.title }}</h3>
            <p class="faq-delivery__desc">{{ advant.desc }}</p>
            <ul class="faq-delivery__advant-list">
                <li
                    v-for="(card, idx) in advant.items"
                    :key="idx"
                    class="faq-delivery__advant-item"
                >
                    <h4>{{ card.title }}</h4>
                    <p>{{ card.text }}</p>
                </li>
            </ul>
        </div>
    </section>
</template>

<script setup lang="ts">
    const section = {
        title: 'Доставка',
        desc: 'Мы осуществляем доставку по Самаре и пригородным районам. Заказы принимаем с 9:00 до 23:00, а доставляем круглосуточно. Заказы можно забрать самовывозом в одном из салонов в Самаре.',
        info: [
            {
                id: 1,
                content: `
                    <h4>Салоны в Самаре</h4>
                    <p>Самара, Проспект Кирова, 22 (БЦ Бигбен)</p>
                    <p>Самара, Улица Ленина, 15, ТЦ «Аврора», офис 21</p>
                    <p>Самара, Площадь Славы, 5</p>
                `,
            },
            {
                id: 2,
                content: `
                    <h4>Время работы</h4>
                    <p>Время работы салонов: ежедневно, c 09:00 до 23:00</p>
                    <p>Принимаем заказы: c 09:00 до 23:00</p>
                    <p>Доставка заказов: круглосуточно</p>
                `,
            },
            {
                id: 3,
                content: `
                    <h4>Условия доставки</h4>
                    <p><strong>9:00 - 21:00</strong></p>
                    <ul>
                        <li>С 9:00 - 21:00 доставим цветы по Самаре бесплатно при заказе от 1500₽;</li>
                        <li>Если стоимость заказа менее 1500₽, то стоимость доставки 300₽.</li>
                    </ul>
                    <p><strong>21:00 - 9:00</strong></p>
                    <ul>
                        <li>C 23:00 до 9:00 стоимость доставки 500₽ и не зависит от стоимости букета.</li>
                    </ul>
                `,
            },
        ],
        hint: `
                <p>
                    Более подробную информацию по возможности и стоимости доставки уточняйте у
                    менеджера компании Арабеска по телефону
                    <a href="tel:+7(812)200-50-76">+7 (812) 200-50-76</a>
                </p>
            `,
    };
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

    .faq-delivery {
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
        &__hint {
            max-width: 70ch;
            font-size: lineScale(18, 16, 480, 1440);
            line-height: 1.4;
            font-weight: $fw-bold;
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
        &__info {
            display: flex;
            flex-wrap: wrap;
            gap: rem(48) rem(16);
            &-item {
                flex: 1 1 30%;
                min-width: rem(260);
                text-wrap: balance;
                @include text-content;
                > p,
                ul,
                ol {
                    opacity: 0.8;
                }
            }
        }
        &__address {
            display: flex;
            flex-direction: column;
            gap: rem(32);
            &-validator {
                display: grid;
                grid-template-columns: auto minmax(25%, max-content);
                grid-template-areas:
                    'input button'
                    'result result';
                gap: rem(24) rem(8);
                &-input {
                    $py: rem(18);
                    $px: rem(24);

                    grid-area: input;
                    width: 100%;
                    &:has(input:focus) {
                        > input {
                            border-color: $c-accent !important;
                            background-color: transparent;
                        }
                        > label {
                            background: $c-main !important;
                            opacity: 1;
                        }
                    }
                    @media (pointer: fine) {
                        &:hover {
                            > input {
                                border-color: $c-accent !important;
                            }
                        }
                    }
                    > input {
                        width: 100%;
                        height: 100%;
                        padding: $py $px;
                        border-radius: rem(32);
                        background-color: rgba($c-D4E1E7, 0.25);
                        border: rem(1) solid transparent;
                    }
                    > label {
                        display: block;
                        z-index: 5;
                        left: $px !important;
                        transition-duration: $td !important;
                        padding: 0 rem(4) !important;
                        opacity: 0.5;
                    }
                }
                &-button {
                    grid-area: button;
                    background-color: $c-E5F2D8;
                    @include button-primary(
                        $font-size: lineScale(18, 16, 480, 1440),
                        $border-color: transparent,
                        $anim-color: $c-98BBD7,
                        $padding: rem(18) rem(64)
                    );
                    @media (pointer: fine) {
                        &:hover {
                            background-color: transparent;
                        }
                    }
                }
                &-result {
                    grid-area: result;
                    color: $c-accent;
                }
            }
            //temp
            &-image {
                width: 100%;
                aspect-ratio: 2/1;
                border-radius: rem(32);
                overflow: hidden;
                img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }
            }
            //
        }
        &__advant {
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
                color: $c-FFFFFF;
                aspect-ratio: 1.2/1;
                background-color: $c-accent;
                border-radius: rem(16);
                padding: rem(16);
                @include text-content();
            }
        }
    }

    @media (max-width: 768px) {
        .faq-delivery {
            &__advant {
                &-item {
                    aspect-ratio: initial;
                }
            }
            &__address {
                &-validator {
                    display: flex;
                    flex-direction: column;
                    &-button {
                        align-self: flex-end;
                    }
                }
            }
        }
    }

    @media (max-width: 480px) {
        .faq-delivery {
            &__address {
                &-validator {
                    &-button {
                        width: 100%;
                        align-items: center;
                        justify-content: center;
                    }
                }
            }
        }
    }
</style>
