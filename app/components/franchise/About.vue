<template>
    <section id="about" class="franchise-about">
        <div class="franchise-about__container">
            <div class="franchise-about__titlebox">
                <h2 class="franchise-about__title">
                    Мы понимаем, как тяжело во всем разобраться самостоятельно
                </h2>
                <p class="franchise-about__desc">
                    Мы имеем 15-летний опыт по упаковке бизнеса. С нами работают более 40 тысяч
                    клиентов. Среди них - Redmond, Ozon, Додо Пицца, Гарант, Nikon, Grow Food и др.
                </p>
            </div>
            <ul class="franchise-about__body">
                <li class="franchise-about__item">
                    <span class="franchise-about__item-value">+12%</span>
                    <p class="franchise-about__item-desc">к среднему чеку</p>
                </li>
                <li class="franchise-about__item">
                    <span class="franchise-about__item-value">+40%</span>
                    <p class="franchise-about__item-desc">к конверсии покупателей</p>
                </li>
                <li class="franchise-about__item">
                    <span class="franchise-about__item-value">+35%</span>
                    <p class="franchise-about__item-desc">к охвату в социальных сетях</p>
                </li>
            </ul>
        </div>
    </section>
</template>

<script setup lang="ts"></script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .franchise-about {
        scroll-margin: rem(128);
        padding: rem(64) 0;
        &__container {
            @include content-container;
        }
        &__titlebox {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: rem(40);
            text-align: center;
        }
        &__title {
            max-width: 30ch;
            font-size: lineScale(48, 32, 480, 1440);
            font-weight: $fw-semi;
        }
        &__desc {
            max-width: 50ch;
            font-family: 'Inter', sans-serif;
            font-size: lineScale(22, 18, 480, 1440);
            line-height: 1.3;
        }
        &__body {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: rem(64) rem(32);
            margin-top: rem(64);
        }
        &__item {
            flex: 1 1 30%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: rem(8);
            text-align: center;
            &-value {
                font-family: 'Inter', sans-serif;
                color: $c-accent;
                font-size: lineScale(128, 96, 480, 1440);
                font-weight: $fw-black;
            }
            &-desc {
                text-transform: lowercase;
                font-size: lineScale(24, 18, 480, 1440);
                font-weight: $fw-semi;
            }
        }
    }
</style>
