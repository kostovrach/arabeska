<template>
    <section id="pricing" class="subscription-pricing">
        <div class="subscription-pricing__container">
            <div class="subscription-pricing__titlebox">
                <h2 class="subscription-pricing__title">Тарифы</h2>
                <p class="subscription-pricing__desc">
                    Вам больше не нужно заботиться о поиске цветов каждую неделю. Вы оформляете
                    подписку один раз и наслаждаетесь цветами целый месяц.
                </p>
            </div>
            <ul class="subscription-pricing__list">
                <li
                    v-for="(card, idx) in subscriptionItems"
                    :key="idx"
                    class="subscription-pricing__item"
                >
                    <div
                        v-if="card.discount"
                        class="subscription-pricing__item-sticker subscription-pricing__item-sticker--discount"
                    >
                        <span>
                            -{{ calcDiscountPercent(card.price, card.discount ?? card.price) }}%
                        </span>
                    </div>
                    <div class="subscription-pricing__item-wrapper">
                        <picture class="subscription-pricing__item-image-container">
                            <img
                                class="subscription-pricing__item-image"
                                :src="card.imageUrl"
                                :alt="card.name"
                            />
                        </picture>
                        <div class="subscription-pricing__item-content">
                            <h3 class="subscription-pricing__item-title">{{ card.name }}</h3>
                            <div
                                class="subscription-pricing__item-desc"
                                v-html="card.description"
                            ></div>
                            <div class="subscription-pricing__item-footer">
                                <div class="subscription-pricing__item-price">
                                    <span
                                        v-if="card.discount && typeof card.discount === 'number'"
                                        class="subscription-pricing__item-price-crossed"
                                    >
                                        {{ card.price.toLocaleString() }}
                                        <span class="ruble"></span>
                                    </span>
                                    <span class="subscription-pricing__item-price-current">
                                        {{
                                            card.discount
                                                ? card.discount.toLocaleString()
                                                : card.price.toLocaleString()
                                        }}
                                        <span class="ruble"></span>
                                        /мес
                                    </span>
                                </div>
                                <button
                                    :class="[
                                        'subscription-pricing__item-button',
                                        inCart ? 'subscription-pricing__item-button--checked' : '',
                                    ]"
                                    @click.prevent="toggleCart"
                                >
                                    <span
                                        class="subscription-pricing__item-button-icon subscription-pricing__item-button-icon--default"
                                    >
                                        <SvgSprite type="cart" :size="32" />
                                    </span>
                                    <span
                                        class="subscription-pricing__item-button-icon subscription-pricing__item-button-icon--checked"
                                    >
                                        <SvgSprite type="checkmark" :size="32" />
                                    </span>
                                </button>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </section>
</template>

<script setup lang="ts">
    import type { ISubscriptionItem } from '~~/interfaces/subscription-item';

    // temp cart processing==============================

    // state
    const inCart = ref(false);

    // actions
    function toggleCart() {
        if (inCart.value) {
            inCart.value = false;
        } else {
            inCart.value = true;
        }
    }
    //====================================================

    // temp data ===========================================================
    const subscriptionItems: ISubscriptionItem[] = [
        {
            imageUrl: '/img/temp/temp1.jpg',
            name: 'Стандарт',
            description: `
                            <ul>
                                <li>4 букета в месяц</li>
                                <li>Размер букетов «Стандарт»</li>
                                <li>Ваза в подарок</li>
                                <li>Открытка</li>
                            </ul>
                        `,
            price: 8950,
        },
        {
            imageUrl: '/img/temp/temp1.jpg',
            name: 'Роскошный',
            description: `
                            <ul>
                                <li>4 букета в месяц</li>
                                <li>Размер букетов «Стандарт»</li>
                                <li>Ваза в подарок</li>
                                <li>Открытка</li>
                            </ul>
                        `,
            price: 15000,
            discount: 10250,
        },
        {
            imageUrl: '/img/temp/temp1.jpg',
            name: 'Премиум',
            description: `
                            <ul>
                                <li>4 букета в месяц</li>
                                <li>Размер букетов «Стандарт»</li>
                                <li>Ваза в подарок</li>
                                <li>Открытка</li>
                            </ul>
                        `,
            price: 17650,
            discount: 15095,
        },
        {
            imageUrl: '/img/temp/temp1.jpg',
            name: 'Супер-Премиум',
            description: `
                            <ul>
                                <li>4 букета в месяц</li>
                                <li>Размер букетов «Стандарт»</li>
                                <li>Ваза в подарок</li>
                                <li>Открытка</li>
                            </ul>
                        `,
            price: 25650,
            discount: 19500,
        },
    ];
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .subscription-pricing {
        $p: &;

        scroll-margin: rem(128);
        @include content-block($margin: rem(64));
        &__container {
            @include content-container;
        }
        &__titlebox {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            gap: rem(48);
        }
        &__title {
            font-size: lineScale(48, 24, 480, 1440);
            font-weight: $fw-semi;
        }
        &__desc {
            max-width: 50ch;
            font-size: lineScale(24, 18, 480, 1440);
            line-height: 1.25;
        }
        &__list {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: lineScale(32, 8, 480, 1440);
            margin-top: rem(96);
        }
        &__item {
            position: relative;
            aspect-ratio: 1/1.3;
            @media (pointer: fine) {
                &:hover {
                    #{$p}__item-desc {
                        flex: 1;
                    }
                }
            }
            &-sticker {
                position: absolute;
                z-index: 2;
                top: rem(16);
                left: rem(16);
                translate: -50% -50%;
                @include sticker($bg-color: $c-F5142B);
            }
            &-wrapper {
                position: relative;
                min-width: 100%;
                height: 100%;
                display: flex;
                flex-direction: column;
                justify-content: flex-end;
                color: $c-FFFFFF;
                border-radius: rem(32);
                overflow: hidden;
            }
            &-image-container {
                position: absolute;
                z-index: -1;
                inset: 0;
                filter: brightness(70%);
            }
            &-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            &-content {
                position: relative;
                z-index: 1;
                display: flex;
                flex-direction: column;
                justify-content: flex-end;
                gap: rem(16);
                padding: lineScale(24, 16, 480, 1440) lineScale(32, 16, 480, 1440);
                &::before {
                    content: '';
                    position: absolute;
                    z-index: -1;
                    inset: 0;
                    backdrop-filter: blur(5px) brightness(80%);
                    mask-image: linear-gradient(to top, #000 60%, transparent 100%);
                    mask-size: 100%;
                    mask-repeat: no-repeat;
                    pointer-events: none;
                }
                > * {
                    position: relative;
                    z-index: 2;
                }
            }
            &-title {
                font-size: lineScale(32, 20, 480, 1440);
                font-weight: $fw-semi;
            }
            &-desc {
                font-family: 'Inter', sans-serif;
                font-size: rem(16);
                line-height: 1.2;
                opacity: 0.8;
                @media (pointer: fine) {
                    flex: 0;
                    min-height: 0;
                    overflow: hidden;
                    transition: flex $td $tf;
                }
                h2,
                h3,
                h4,
                h5,
                h6 {
                    font-size: lineScale(20, 18, 480, 1440);
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
            &-footer {
                display: flex;
                align-items: flex-end;
                justify-content: space-between;
            }
            &-button {
                cursor: pointer;
                position: relative;
                width: rem(48);
                aspect-ratio: 1;
                color: $c-FFFFFF;
                border-radius: 50%;
                overflow: hidden;
                transition: background-color $td $tf;
                @media (pointer: fine) {
                    &:not(#{$p}__item-button--checked):hover {
                        background-color: $c-accent;
                    }
                }
                &--checked {
                    background-color: $c-98BBD7;
                    #{$p}__item-button-icon {
                        &--default {
                            transform: translateY(200%);
                        }
                        &--checked {
                            transform: translateY(0);
                        }
                    }
                }
                &-icon {
                    position: absolute;
                    top: 50%;
                    left: 50%;
                    translate: -50% -50%;
                    transition: transform $td $tf-spring;
                    &--checked {
                        transform: translateY(-200%);
                    }
                }
            }
            &-price {
                width: fit-content;
                display: flex;
                flex-direction: column;
                gap: rem(4);
                font-family: 'Inter', sans-serif;
                &-crossed {
                    position: relative;
                    width: fit-content;
                    font-size: lineScale(16, 14, 480, 1440);
                    opacity: 0.5;
                    &::before {
                        content: '';
                        position: absolute;
                        top: 50%;
                        left: 50%;
                        translate: -50% -50%;
                        width: 110%;
                        height: rem(2);
                        background-color: $c-accent;
                        rotate: -8deg;
                    }
                    > div {
                        opacity: 0.5;
                    }
                }
                &-current {
                    width: fit-content;
                    font-size: lineScale(20, 16, 480, 1440);
                }
            }
        }
    }

    @media (max-width: 1100px) {
        .subscription-pricing {
            &__list {
                grid-template-columns: repeat(2, 1fr);
            }
            &__item {
                aspect-ratio: 1.2/1;
            }
        }
    }

    @media (max-width: 768px) {
        .subscription-pricing {
            &__item {
                aspect-ratio: 1/1.2;
            }
        }
    }

    @media (max-width: 540px) {
        .subscription-pricing {
            &__list {
                display: flex;
                flex-direction: column;
            }
            &__item {
                aspect-ratio: 1.1/1;
            }
        }
    }
</style>
