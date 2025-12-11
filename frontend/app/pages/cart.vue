<template>
    <NuxtLayout>
        <div class="cart">
            <div class="cart__container">
                <div class="cart__titlebox">
                    <h1 class="cart__title">Корзина</h1>
                    <span class="cart__counter" v-if="cartCounter >= 1">({{ cartCounter }})</span>
                </div>
                <section class="cart__body">
                    <div class="cart__hint">
                        <div
                            class="cart__hint-indicator"
                            :style="`--progress: ${deliveryRemainsPricePercent}%`"
                        >
                            <SvgSprite type="box" :size="24" />
                        </div>
                        <p class="cart__hint-content">
                            Осталось совсем немного: добавьте товаров в корзину ещё на
                            <span class="ruble">{{ deliveryRemainsPrice }}</span>
                            , чтобы доставка стала бесплатной!
                        </p>
                    </div>
                    <div class="cart__list"></div>
                    <aside class="cart__sider">
                        <div class="cart__sider-wrapper">
                            <div class="cart__sider-head">
                                <p>Сумма</p>
                                <span class="ruble">{{ cartAmount }}</span>
                            </div>
                            <ul class="cart__sider-details">
                                <li
                                    :class="[
                                        'cart__sider-details-item',
                                        { warn: deliveryRemainsPrice > 0 },
                                    ]"
                                >
                                    <p>Доставка</p>
                                    <span class="ruble">
                                        {{
                                            deliveryRemainsPrice > 0 ? settings?.delivery_price : 0
                                        }}
                                    </span>
                                </li>
                            </ul>
                            <button class="cart__sider" type="button">
                                <span>Перейти к оформлению</span>
                                <span><SvgSprite type="arrow" :size="18" /></span>
                            </button>
                        </div>
                    </aside>
                </section>
            </div>
        </div>
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { ISettings } from '~~/interfaces/settings';

    // data ======================================================
    const cartStore = useCartStore();
    const productsStore = useProductsStore();

    const cartCounter = computed(() => cartStore.cartCount);
    const cartAmount = computed(() => cartStore.cartAmount);
    const cartProducts = computed(() => cartStore.cartList);

    const products = computed(() => productsStore.productsList);

    const { content: settings } = useCms<ISettings>('settings');

    const cart = computed(() => {
        const inCart = new Set(cartProducts.value.flatMap((el) => el.product_id));

        return products.value.filter((el) => inCart.has(el.id));
    });
    console.log(cart.value);

    const deliveryPrice = computed(() => settings.value?.delivery_price);
    // const deliveryRequiredPrice = computed(() => settings.value?.delivery_disable_price);
    const deliveryRequiredPrice = ref(50000);
    const deliveryRemainsPrice = computed(() => {
        if (!deliveryPrice.value || !deliveryRequiredPrice.value) return 0;
        if (deliveryRequiredPrice.value <= 0 || cartAmount.value >= deliveryRequiredPrice.value)
            return 0;

        return deliveryRequiredPrice.value - cartAmount.value;
    });
    const deliveryRemainsPricePercent = computed(() => {
        if (!deliveryPrice.value || !deliveryRequiredPrice.value) return 0;
        if (deliveryRequiredPrice.value <= 0 || cartAmount.value >= deliveryRequiredPrice.value)
            return 100;

        const missing = deliveryRequiredPrice.value - cartAmount.value;
        return Math.round((missing / deliveryRequiredPrice.value) * 100);
    });

    // ===========================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .cart {
        $p: &;

        margin: lineScale(64, 32, 480, 1440) 0;
        &__container {
            @include content-container;
        }
        &__titlebox {
            display: flex;
            align-items: flex-start;
            justify-content: center;
        }
        &__title {
            font-size: lineScale(128, 96, 480, 1920);
            font-weight: $fw-semi;
        }
        &__counter {
            font-family: 'Inter', sans-serif;
            font-weight: $fw-bold;
            font-size: lineScale(24, 18, 480, 1920);
        }
    }
</style>
