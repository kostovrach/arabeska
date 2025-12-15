<template>
    <NuxtLayout>
        <ClientOnly>
            <div class="cart">
                <div class="cart__container">
                    <div class="cart__titlebox">
                        <h1 class="cart__title">Корзина</h1>
                        <span class="cart__counter" v-if="cartCounter >= 1">
                            ({{ cartCounter }})
                        </span>
                    </div>
                    <section class="cart__body">
                        <div class="cart__hint" v-if="cartAmount !== 0">
                            <div class="cart__hint-indicator">
                                <SvgSprite type="delivery" :size="24" />
                                <div class="cart__hint-indicator-progress">
                                    <svg viewBox="0 0 64 64">
                                        <circle
                                            class="cart__hint-indicator-progress-bg"
                                            :cx="32"
                                            :cy="32"
                                            :r="radius"
                                        />
                                        <circle
                                            class="cart__hint-indicator-progress-inner"
                                            :cx="32"
                                            :cy="32"
                                            :r="radius"
                                            :stroke-dasharray="circumference"
                                            :stroke-dashoffset="dashOffset"
                                        />
                                    </svg>
                                </div>
                            </div>
                            <p class="cart__hint-content" v-if="remainsToFreeDelivery > 0">
                                Осталось совсем немного: добавьте товаров в корзину ещё на
                                <span class="ruble">
                                    {{ remainsToFreeDelivery.toLocaleString('ru-RU') }}
                                </span>
                                , чтобы доставка стала бесплатной!
                            </p>
                            <p class="cart__hint-content" v-else>
                                Товаров в корзине достаточно. Доставка бесплатная!
                            </p>
                        </div>
                        <div class="cart__hint cart__hint--empty" v-else>
                            <p class="cart__hint--empty-text">В корзине нет товаров</p>
                            <NuxtLink class="cart__hint--empty-button" :to="{ name: 'catalog' }">
                                <span>За покупками</span>
                                <span><SvgSprite type="arrow" :size="18" /></span>
                            </NuxtLink>
                        </div>
                        <ul class="cart__list" v-if="cartAmount !== 0">
                            <li v-for="item in cart" :key="item.product_id" class="cart__item">
                                <NuxtLink
                                    class="cart__item-image-container"
                                    :to="{ name: 'product-id', params: { id: item.product_id } }"
                                >
                                    <img
                                        class="cart__item-image"
                                        :src="getProductImageById(item.product_id)"
                                        :alt="getProductTitleById(item.product_id) ?? '#'"
                                    />
                                </NuxtLink>
                                <div class="cart__item-body">
                                    <div class="cart__item-field">
                                        <h2 class="cart__item-title">
                                            {{ getProductTitleById(item.product_id) }}
                                        </h2>
                                        <button
                                            class="cart__item-button"
                                            type="button"
                                            @click.prevent="removeProduct(item)"
                                        >
                                            Удалить
                                        </button>
                                    </div>
                                    <div class="cart__item-field">
                                        <p class="cart__item-field-name">Размер</p>
                                        <span class="cart__item-field-value">
                                            {{ translateProductModifier(item.modifier) }}
                                        </span>
                                    </div>
                                    <div class="cart__item-field">
                                        <p class="cart__item-field-name">Количество</p>
                                        <div class="cart__item-field-controls">
                                            <button
                                                type="button"
                                                :disabled="Number(item.quantity) <= 1"
                                                @click="removeQty(item)"
                                            >
                                                <SvgSprite type="minus" :size="14" />
                                            </button>
                                            <span>{{ item.quantity }}</span>
                                            <button
                                                type="button"
                                                :disabled="Number(item.quantity) >= 5"
                                                @click="addQty(item)"
                                            >
                                                <SvgSprite type="plus" :size="14" />
                                            </button>
                                        </div>
                                    </div>
                                    <div class="cart__item-field">
                                        <p class="cart__item-field-name">Стомость</p>
                                        <div class="cart__item-field-price">
                                            <p
                                                class="cart__item-field-price-crossed"
                                                v-if="getProductDiscountById(item.product_id)"
                                            >
                                                <span class="ruble">
                                                    {{ getProductDiscountById(item.product_id) }}
                                                </span>
                                            </p>
                                            <p class="cart__item-field-price-common ruble">
                                                <span>
                                                    {{ getProductPriceById(item.product_id) }}
                                                </span>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </ul>
                        <aside class="cart__sider">
                            <div class="cart__sider-wrapper">
                                <div class="cart__sider-head">
                                    <p>Сумма</p>
                                    <span class="ruble">
                                        {{ cartAmount.toLocaleString('ru-RU') }}
                                    </span>
                                </div>
                                <ul class="cart__sider-details" v-if="cartAmount !== 0">
                                    <li class="cart__sider-details-item">
                                        <p>Доставка</p>
                                        <span
                                            :class="['ruble', { warn: remainsToFreeDelivery > 0 }]"
                                        >
                                            {{ totalDeliveryPrice.toLocaleString('ru-RU') }}
                                        </span>
                                    </li>
                                </ul>
                                <NuxtLink
                                    v-if="cartAmount !== 0"
                                    class="cart__button"
                                    :to="{ name: 'checkout' }"
                                >
                                    <span>Перейти к оформлению</span>
                                    <span>
                                        <SvgSprite type="arrow" :size="18" />
                                    </span>
                                </NuxtLink>
                            </div>
                        </aside>
                        <NuxtLink
                            v-if="cartAmount !== 0"
                            class="cart__button cart__button--sticky"
                            :to="{ name: 'checkout' }"
                        >
                            <span>Перейти к оформлению</span>
                            <span>
                                <SvgSprite type="arrow" :size="18" />
                            </span>
                        </NuxtLink>
                    </section>
                </div>
            </div>
        </ClientOnly>
        <HintCarousel title="Вам стоит взглянуть" />
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { ICartItem } from '~~/interfaces/entities/cart-item';
    import type { ISettings } from '~~/interfaces/settings';

    const cartStore = useCartStore();

    const {
        getProductDiscountById,
        getProductImageById,
        getProductPriceById,
        getProductTitleById,
        translateProductModifier,
    } = cartStore;
    // data ======================================================
    const cartCounter = computed(() => cartStore.cartCount);
    const cartAmount = computed(() => cartStore.cartAmount);

    const cart = computed(() => cartStore.cartList);

    const { content: settings } = useCms<ISettings>('settings');

    const deliveryPrice = computed(() => settings.value?.delivery_price ?? 0);
    const deliveryRequiredPrice = computed(() => settings.value?.delivery_disable_price ?? 0);

    const {
        remains: remainsToFreeDelivery,
        remainsPercent: remainsToFreeDeliveryPercent,
        price: totalDeliveryPrice,
    } = useDeliveryPriceCalculator(cartAmount, deliveryPrice, deliveryRequiredPrice);

    // progressbar ----------------------------------
    const radius = 28;
    const circumference = 2 * Math.PI * radius;
    const dashOffset = computed(() => {
        const percent = remainsToFreeDeliveryPercent.value / 100;
        if (percent >= 1) {
            return 0 * circumference;
        }
        return (remainsToFreeDeliveryPercent.value / 100) * circumference;
    });
    // ----------------------------------------------
    // ===========================================================

    // methods ===================================================
    const addQty = useDebounceFn(async (product: ICartItem): Promise<void> => {
        await cartStore.addQty(product);
    }, 200);

    const removeQty = useDebounceFn(async (product: ICartItem): Promise<void> => {
        await cartStore.removeQty(product);
    }, 200);

    const removeProduct = async (product: ICartItem): Promise<void> => {
        await cartStore.removeFromCart(product);
    };
    // ===========================================================

    // SEO & Meta ================================================
    useHead({
        title: 'Корзина | Arabeska - Магазин цветов в Самаре',
        meta: [{ name: 'robots', content: 'noindex, nofollow' }],
    });
    // ===========================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .cart {
        $p: &;

        margin: lineScale(64, 32, 480, 1440) 0;
        &__container {
            display: flex;
            flex-direction: column;
            gap: rem(96);
            @include content-container;
        }
        &__titlebox {
            display: flex;
            align-items: flex-start;
            justify-content: center;
        }
        &__title {
            font-size: lineScale(128, 64, 480, 1920);
            font-weight: $fw-semi;
        }
        &__counter {
            font-family: 'Inter', sans-serif;
            font-weight: $fw-bold;
            font-size: lineScale(24, 18, 480, 1920);
        }

        &__body {
            width: 100%;
            max-width: rem(1340);
            margin: 0 auto;
            display: grid;
            grid-template-columns: 60% auto;
            grid-template-areas:
                'hint sider'
                'list sider';
            gap: rem(32) lineScale(64, 32, 480, 1920);
        }
        &__hint {
            grid-area: hint;
            display: flex;
            align-items: center;
            gap: rem(16);
            padding: rem(24) lineScale(32, 24, 480, 1920);
            border-radius: rem(64);
            background-color: $c-E5F2D8;
            &-indicator {
                position: relative;
                width: rem(40);
                min-width: rem(40);
                aspect-ratio: 1;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 50%;
                &-progress {
                    position: absolute;
                    top: 50%;
                    left: 50%;
                    translate: -50% -50%;
                    width: rem(56);
                    aspect-ratio: 1;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    svg {
                        width: 100%;
                        height: 100%;
                        rotate: -90deg;
                    }
                    &-bg {
                        fill: none;
                        stroke-width: 3;
                    }
                    &-inner {
                        fill: none;
                        stroke: $c-accent;
                        stroke-width: 4;
                        stroke-linecap: round;
                        will-change: stroke-dashoffset;
                        transition: stroke-dashoffset 0.1s linear;
                    }
                }
            }
            &-content {
                font-family: 'Inter', sans-serif;
                font-size: lineScale(16, 14, 480, 1920);
                line-height: 1.4;
                > span {
                    font-weight: $fw-bold;
                }
            }
            &--empty {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                gap: rem(32);
                background-color: transparent;
                border: rem(1.5) solid rgba($c-98BBD7, 0.5);
                padding: rem(64) rem(32);
                &-text {
                    font-size: lineScale(32, 24, 480, 1920);
                }
                &-button {
                    @include button-primary(
                        $border-color: $c-accent,
                        $gap: rem(16),
                        $anim-color: $c-accent
                    );
                }
            }
        }
        &__list {
            grid-area: list;
            display: flex;
            flex-direction: column;
            gap: rem(32);
            padding: lineScale(32, 16, 480, 1920);
            border-radius: rem(32);
            border: rem(1.5) solid rgba($c-98BBD7, 0.5);
        }
        &__sider {
            grid-area: sider;
            position: relative;
            height: 100%;
            &-wrapper {
                position: sticky;
                top: rem(128);
                padding: lineScale(32, 16, 480, 1920);
                box-shadow: 5px 5px 25px rgba($c-082535, 0.1);
                border-radius: rem(32);
            }
            &-head {
                display: flex;
                align-items: flex-end;
                justify-content: space-between;
                flex-wrap: wrap;
                gap: rem(16);
                font-size: lineScale(22, 20, 480, 1920);
                font-weight: $fw-semi;
                padding-bottom: rem(24);
                border-bottom: rem(1) solid rgba($c-98BBD7, 0.5);
                > span {
                    font-weight: normal;
                    font-size: lineScale(32, 24, 480, 1920);
                }
            }
            &-details {
                display: flex;
                flex-direction: column;
                gap: rem(16);
                margin-top: rem(16);
                &-item {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    flex-wrap: wrap;
                    gap: rem(16);
                    > p {
                        font-size: rem(14);
                        font-weight: $fw-semi;
                        opacity: 0.5;
                    }
                    > span {
                        color: $c-accent;
                        font-weight: $fw-semi;
                        &.warn {
                            color: $c-F5142B;
                        }
                    }
                }
            }
        }
        &__item {
            display: flex;
            align-items: flex-start;
            gap: rem(24);
            &-image-container {
                display: block;
                width: lineScale(140, 96, 480, 1920);
                min-width: lineScale(140, 96, 480, 1920);
                aspect-ratio: 1;
                border-radius: rem(16);
                overflow: hidden;
            }
            &-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            &-body {
                width: 100%;
                display: flex;
                flex-direction: column;
                gap: rem(12);
                padding: rem(8) 0;
            }
            &-title {
                font-size: lineScale(22, 16, 480, 1920);
                text-wrap: balance;
                font-weight: $fw-semi;
                margin-bottom: rem(8);
            }
            &-field {
                display: flex;
                align-items: flex-start;
                justify-content: space-between;
                gap: rem(32);
                &-name {
                    font-size: lineScale(14, 12, 480, 1920);
                    font-weight: $fw-semi;
                    opacity: 0.5;
                }
                &-value {
                    font-weight: $fw-semi;
                    font-size: lineScale(16, 12, 480, 1920);
                    opacity: 0.5;
                }
                &-controls {
                    display: flex;
                    align-items: center;
                    gap: rem(16);
                    font-size: lineScale(16, 14, 480, 1920);
                    > button {
                        cursor: pointer;
                        &:disabled {
                            pointer-events: none;
                            opacity: 0.5;
                        }
                    }
                }
                &-price {
                    display: flex;
                    align-items: flex-end;
                    justify-content: flex-end;
                    flex-wrap: wrap;
                    gap: rem(8) rem(16);
                    font-size: lineScale(24, 20, 480, 1920);
                    font-weight: $fw-semi;
                    &-crossed {
                        position: relative;
                        width: fit-content;
                        font-size: lineScale(16, 14, 480, 1440);
                        > span {
                            opacity: 0.5;
                        }
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
                    }
                }
            }
            &-button {
                cursor: pointer;
                width: fit-content;
                text-transform: uppercase;
                font-size: rem(12);
                font-weight: $fw-semi;
                color: $c-F5142B;
                text-decoration: underline;
                @media (pointer: fine) {
                    &:hover {
                        text-decoration: none;
                    }
                }
            }
        }
        &__button {
            align-items: center;
            justify-content: center;
            margin-top: rem(40);
            @include button-primary(
                $width: 100%,
                $gap: rem(8),
                $font-size: lineScale(20, 16, 480, 1920),
                $border-color: $c-accent,
                $padding: rem(12) rem(24),
                $anim-color: $c-accent
            );
            &:not(#{$p}__button--sticky) {
                @media (max-width: 960px) {
                    display: none;
                }
            }
            &--sticky {
                grid-area: button;
                position: sticky;
                bottom: rem(64);
                margin: 0;
                color: $c-FFFFFF;
                background-color: $c-accent;
                @media (min-width: 961px) {
                    display: none;
                }
            }
        }
    }

    @media (max-width: 960px) {
        .cart {
            &__body {
                grid-template-columns: 100%;
                grid-template-areas:
                    'hint'
                    'list'
                    'sider'
                    'button';
            }
            &__sider {
                &-wrapper {
                    box-shadow: none;
                    padding: 0;
                }
            }
            &__list {
                padding: {
                    left: 0;
                    right: 0;
                }
                border: {
                    left: none;
                    right: none;
                }
                border-radius: initial;
            }
            &__item {
                &-field {
                    &-price {
                        flex-direction: column;
                    }
                }
            }
        }
    }
</style>
