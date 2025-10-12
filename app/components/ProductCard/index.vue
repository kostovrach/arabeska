<template>
    <div
        :class="[
            'product',
            props.dynamic?.enable ? `product--dynamic product--${props.dynamic?.class}` : '',
        ]"
    >
        <div
            class="product__sticker product__sticker--discount"
            v-if="product.discount && !isNewProduct(product.date_created)"
        >
            <span>
                -{{ calcDiscountPercent(product.price, product.discount ?? product.price) }}%
            </span>
        </div>
        <div
            class="product__sticker product__sticker--new"
            v-if="isNewProduct(product.date_created)"
        >
            <span>new!</span>
        </div>
        <NuxtLink class="product__wrapper" :to="{ name: 'product-id', params: { id: product.id } }">
            <picture class="product__image-container">
                <img
                    class="product__image"
                    :src="product.images?.[0] || '/img/temp/placeholder-900x900.jpg'"
                    :alt="product.title || '#'"
                />
            </picture>
            <div class="product__content">
                <div class="product__titlebox">
                    <h3 class="product__title">{{ product.title || '' }}</h3>
                    <div class="product__id">{{ product.id }}</div>
                </div>
                <ul class="product__desc" v-if="product.structure">
                    <li
                        class="product__desc-item"
                        v-for="(item, idx) in product.structure.slice(0, 2)"
                        :key="idx"
                    >
                        {{ item.name }}
                    </li>
                </ul>
                <div class="product__footer">
                    <ul class="product__price">
                        <li
                            class="product__price-item product__price-item--crossed"
                            v-if="product.discount && typeof product.discount === 'number'"
                        >
                            <div>
                                {{ product.price.toLocaleString() }}
                                <span class="ruble"></span>
                            </div>
                        </li>
                        <li class="product__price-item product__price-item--current">
                            <div>
                                {{
                                    product.discount
                                        ? product.discount.toLocaleString()
                                        : product.price.toLocaleString()
                                }}
                                <span class="ruble"></span>
                            </div>
                        </li>
                    </ul>
                    <button
                        :class="['product__button', inCart ? 'product__button--checked' : '']"
                        @click.prevent="toggleCart"
                    >
                        <span class="product__button-icon product__button-icon--default">
                            <SvgSprite type="cart" :size="36" />
                        </span>
                        <span class="product__button-icon product__button-icon--checked">
                            <SvgSprite type="checkmark" :size="40" />
                        </span>
                    </button>
                </div>
            </div>
        </NuxtLink>
    </div>
</template>

<script setup lang="ts">
    import type { IProduct } from '~/interfaces/product.ts';

    const props = defineProps<{
        data: IProduct;
        dynamic?: {
            enable: boolean;
            class: 'active' | 'disable';
        };
    }>();

    const product = props.data;

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
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .product {
        $p: &;
        $border-radius: rem(24);

        position: relative;
        width: rem(345);
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
            filter: grayscale(100%);
            pointer-events: none;
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
            aspect-ratio: 1;
            overflow: hidden;
            img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
        }
        &__content {
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: rem(16) rem(24);
            border-radius: 0 0 $border-radius $border-radius;
            border: rem(1) solid $c-D4E1E7;
            border-top: none;
        }
        &__titlebox {
            display: flex;
            justify-content: space-between;
            gap: rem(16);
        }
        &__title {
            font-size: lineScale(22, 16, 480, 1440);
            font-weight: $fw-semi;
        }
        &__id {
            max-width: 7ch;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            font-size: rem(14);
            opacity: 0.5;
        }
        &__desc {
            width: 100%;
            display: flex;
            flex-wrap: wrap;
            gap: 0.5ch;
            margin-top: rem(4);
            &-item {
                width: fit-content;
                // white-space: nowrap;
                font-size: lineScale(16, 14, 480, 1440);
                opacity: 0.5;
                &:not(:last-child)::after {
                    content: ',';
                }
            }
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
                }
            }
        }
        &__button {
            cursor: pointer;
            position: relative;
            width: rem(64);
            aspect-ratio: 1;
            color: $c-FFFFFF;
            background-color: $c-secondary;
            border-radius: 50%;
            overflow: hidden;
            transition: background-color $td $tf;
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

    @media (max-width: 1024px) {
        .product {
            width: rem(280);
            &__titlebox {
                flex-direction: column-reverse;
            }
        }
    }
</style>
