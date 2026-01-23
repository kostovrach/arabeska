<template>
    <div v-if="props.data" class="cart-product">
        <NuxtLink
            class="cart-product__image-container"
            :to="{ name: 'product-id', params: { id: props.data.product_id } }"
        >
            <img
                class="cart-product__image"
                :src="getProductImageById(props.data.product_id)"
                :alt="getProductTitleById(props.data.product_id) ?? '#'"
            />
        </NuxtLink>
        <div class="cart-product__body">
            <div class="cart-product__field">
                <h2 class="cart-product__title">
                    {{ getProductTitleById(props.data.product_id) }}
                </h2>
                <button
                    class="cart-product__button"
                    type="button"
                    @click.prevent="removeProduct(props.data)"
                >
                    Удалить
                </button>
            </div>
            <div class="cart-product__field">
                <p class="cart-product__field-name">Размер</p>
                <span class="cart-product__field-value">
                    {{ translateProductModifier(props.data.modifier) }}
                </span>
            </div>
            <div class="cart-product__field">
                <p class="cart-product__field-name">Количество</p>
                <div class="cart-product__field-controls">
                    <button
                        type="button"
                        :disabled="Number(props.data.quantity) <= 1"
                        @click="removeQty(props.data)"
                    >
                        <SvgSprite type="minus" :size="14" />
                    </button>
                    <span>{{ props.data.quantity }}</span>
                    <button
                        type="button"
                        :disabled="Number(props.data.quantity) >= 5"
                        @click="addQty(props.data)"
                    >
                        <SvgSprite type="plus" :size="14" />
                    </button>
                </div>
            </div>
            <div class="cart-product__field">
                <p class="cart-product__field-name">Стоимость</p>
                <div class="cart-product__field-price">
                    <p
                        class="cart-product__field-price-crossed"
                        v-if="getProductDiscountById(props.data.product_id)"
                    >
                        <span class="ruble">
                            {{
                                (
                                    getProductDiscountById(props.data.product_id)! *
                                    props.data.quantity
                                ).toLocaleString('ru-RU')
                            }}
                        </span>
                    </p>
                    <p class="cart-product__field-price-common ruble">
                        <span>
                            {{
                                (
                                    getProductPriceById(props.data.product_id) * props.data.quantity
                                ).toLocaleString('ru-RU')
                            }}
                        </span>
                    </p>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
    import type { ICartItem } from '~~/interfaces/entities/cart-item';

    const props = withDefaults(
        defineProps<{
            data: ICartItem | null;
        }>(),
        {
            data: null,
        }
    );

    const cartStore = useCartStore();

    const {
        getProductDiscountById,
        getProductImageById,
        getProductPriceById,
        getProductTitleById,
        translateProductModifier,
    } = cartStore;

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
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;
    
        .cart-product {
            display: flex;
            align-items: flex-start;
            gap: rem(24);
            &__image-container {
                display: block;
                width: lineScale(140, 96, 480, 1920);
                min-width: lineScale(140, 96, 480, 1920);
                aspect-ratio: 1;
                border-radius: rem(16);
                overflow: hidden;
            }
            &__image {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            &__body {
                width: 100%;
                display: flex;
                flex-direction: column;
                gap: rem(12);
                padding: rem(8) 0;
            }
            &__title {
                font-size: lineScale(22, 16, 480, 1920);
                text-wrap: balance;
                font-weight: $fw-semi;
                margin-bottom: rem(8);
            }
            &__field {
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
            &__button {
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
</style>
