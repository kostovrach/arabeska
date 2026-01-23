<template>
    <div
        :class="[
            'product',
            props.dynamic?.enable ? `product--dynamic product--${props.dynamic?.class}` : '',
            { 'product--compact': props.compact },
        ]"
    >
        <div v-if="product.discount" class="product__sticker product__sticker--discount">
            <span>
                -{{ calcDiscountPercent(product.price, product.discount ?? product.price) }}%
            </span>
        </div>
        <div
            v-if="isNewProduct(product.date_created) && !product.discount"
            class="product__sticker product__sticker--new"
        >
            <span>new!</span>
        </div>
        <NuxtLink class="product__wrapper" :to="{ name: 'product-id', params: { id: product.id } }">
            <picture class="product__image-container">
                <img
                    class="product__image"
                    :src="
                        `/api/cms/assets/${product.images?.[0]?.directus_files_id.id}` ||
                        '/img/temp/flowers-placeholder.jpg'
                    "
                    :alt="product.title || '#'"
                />
            </picture>
            <div class="product__content">
                <span class="product__id">арт. {{ product.id }}</span>
                <h3 class="product__title" :title="product.title">{{ product.title }}</h3>
                <ul
                    v-if="product.structure"
                    class="product__desc"
                    :title="`Состав: ${product.structure.map((el) => el.structure_id?.name).join(', ')}`"
                >
                    {{
                        product.structure.map((el) => el.structure_id?.name).join(', ')
                    }}
                </ul>
                <div class="product__footer">
                    <ul class="product__price">
                        <li
                            v-if="product.discount"
                            class="product__price-item product__price-item--crossed"
                        >
                            <div>
                                <span class="ruble">
                                    {{ product.price.toLocaleString('ru-RU') }}
                                </span>
                            </div>
                        </li>
                        <li class="product__price-item product__price-item--current">
                            <div>
                                <span class="ruble">
                                    {{
                                        product.discount
                                            ? product.discount.toLocaleString('ru-RU')
                                            : product.price.toLocaleString('ru-RU')
                                    }}
                                </span>
                            </div>
                        </li>
                    </ul>
                    <ClientOnly>
                        <button
                            :class="['product__button', inCart ? 'product__button--checked' : '']"
                            :title="inCart ? 'В корзине' : 'Добавить в корзину'"
                            @click.prevent="toggleCart"
                        >
                            <span class="product__button-icon product__button-icon--default">
                                <SvgSprite type="cart" :size="24" />
                            </span>
                            <span class="product__button-icon product__button-icon--checked">
                                <SvgSprite type="checkmark" :size="24" />
                            </span>
                        </button>
                    </ClientOnly>
                </div>
            </div>
        </NuxtLink>
    </div>
</template>

<script setup lang="ts">
    import type { ICartItem } from '~~/interfaces/entities/cart-item';
    import type { IProduct } from '~~/interfaces/entities/product';

    const props = withDefaults(
        defineProps<{
            data: IProduct;
            dynamic?: { enable: boolean; class: 'active' | 'disable' };
            compact?: boolean;
        }>(),
        {
            dynamic: () => ({ enable: false, class: 'active' }),
            compact: false,
        }
    );

    const product = props.data;

    const cartStore = useCartStore();

    const defaultProductState: ICartItem = {
        product_id: product.id,
        quantity: 1,
        modifier: 'standart',
    };

    const inCart = computed(() => cartStore.checkItemInCart(defaultProductState));

    const toggleCart = useDebounceFn(() => {
        if (!inCart.value) {
            cartStore.addToCart(defaultProductState);
        } else {
            cartStore.removeFromCart(defaultProductState);
        }
    }, 200);
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .product {
        $p: &;
        $border-radius: rem(24);

        position: relative;
        width: rem(300);
        height: 100%;
        transition: translate $td $tf;
        @media (pointer: fine) {
            &:hover {
                translate: 0 rem(-8);
            }
        }
        &--dynamic {
            transition: all $td $tf;
        }
        &--disable {
            scale: 0.8;
            opacity: 0.8;
            // filter: grayscale(100%);
            // pointer-events: none;
        }

        @media (max-width: 1024px) {
            width: rem(280);
        }
        &--compact {
            width: rem(220);
        }
        &__sticker {
            position: absolute;
            top: 0;
            left: 0;
            translate: -30% -50%;
            &--discount {
                @include sticker($bg-color: $c-accent);
            }
            &--new {
                text-transform: uppercase;
                @include sticker($bg-color: $c-F5142B);
            }
            @at-root #{$p}--compact & {
                scale: 0.8;
            }
        }
        &__wrapper {
            width: 100%;
            // height: 100%;
            display: flex;
            flex-direction: column;
            border-radius: $border-radius;
            overflow: hidden;
        }
        &__image-container {
            width: 100%;
            aspect-ratio: 1.1/1;
            overflow: hidden;
        }
        &__image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        &__content {
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: rem(16) lineScale(24, 12, 480, 1440);
            border-radius: 0 0 $border-radius $border-radius;
            border: rem(1) solid $c-D4E1E7;
            border-top: none;
            @at-root #{$p}--compact & {
                padding: rem(16) lineScale(16, 12, 480, 1920);
            }
        }
        &__title {
            min-height: 2em;
            font-size: lineScale(20, 16, 480, 1440);
            font-weight: $fw-semi;
            text-wrap: balance;
            @include lineClamp(2);
            @at-root #{$p}--compact & {
                font-size: lineScale(18, 16, 480, 1920);
            }
        }
        &__id {
            align-self: flex-end;
            max-width: 15ch;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            font-size: rem(14);
            opacity: 0.5;
        }
        &__desc {
            width: 100%;
            font-size: lineScale(14, 12, 480, 1440);
            margin-top: rem(8);
            opacity: 0.5;
            @include lineClamp(1);
            // @at-root #{$p}--compact & {
            //     display: none;
            // }
        }
        &__footer {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-top: rem(12);
        }
        &__price {
            &-item {
                width: fit-content;
                &--crossed {
                    position: relative;
                    font-size: lineScale(16, 14, 480, 1440);
                    @at-root #{$p}--compact & {
                        font-size: lineScale(14, 12, 480, 1920);
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
                    > div {
                        opacity: 0.5;
                    }
                }
                &--current {
                    font-size: lineScale(24, 18, 480, 1440);
                    @at-root #{$p}--compact & {
                        font-size: lineScale(20, 18, 480, 1920);
                    }
                }
            }
        }
        &__button {
            cursor: pointer;
            position: relative;
            width: lineScale(48, 36, 480, 1920);
            min-width: lineScale(48, 36, 480, 1920);
            aspect-ratio: 1;
            color: $c-FFFFFF;
            background-color: $c-secondary;
            border-radius: 50%;
            overflow: hidden;
            transition: background-color $td $tf;
            > svg {
                height: fit-content;
                width: rem(64);
            }
            @media (pointer: fine) {
                &:not(#{$p}__button--checked):hover {
                    background-color: $c-accent;
                }
            }
            &--checked {
                background-color: $c-98BBD7;
                #{$p}__button-icon {
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
    }
</style>
