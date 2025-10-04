<template>
    <div :class="['product', props.variant ? `product--${props.variant}` : '']">
        <div class="product__sticker" v-if="props.product.discount">
            <span>-{{ props.product.discount }}</span>
            <span class="symbol">%</span>
        </div>
        <div class="product__wrapper">
            <picture class="product__image-container">
                <img
                    class="product__image"
                    :src="props.product.images?.[0] || '/img/temp/placeholder-900x900.jpg'"
                    :alt="props.product.title || ''"
                />
            </picture>
            <div class="product__content">
                <div class="product__titlebox">
                    <h3 class="product__title">{{ props.product.title || '' }}</h3>
                    <div class="product__id">{{ props.product.id }}</div>
                </div>
                <ul class="product__desc" v-if="props.product.structure">
                    <li
                        class="product__desc-item"
                        v-for="(item, idx) in props.product.structure.slice(0, 2)"
                        :key="idx"
                    >
                        {{ item.name }}
                    </li>
                </ul>
                <div class="product__footer">
                    <ul class="product__price">
                        <li
                            class="product__price-item product__price-item--crossed"
                            v-if="props.product.discount && typeof props.product.discount === 'number'"
                        >
                            <div>
                                {{ calcOldPrice(props.product.price, props.product.discount) }}
                                <span class="ruble"></span>
                            </div>
                        </li>
                        <li class="product__price-item product__price-item--current">
                            <div>
                                {{ props.product.price }}
                                <span class="ruble"></span>
                            </div>
                        </li>
                    </ul>
                    <button :class="['product__button', inCart ? 'product__button--checked' : '']" @click="toggleCart">
                        <span class="product__button-icon product__button-icon--default">
                            <SvgSprite type="cart" :size="36" />
                        </span>
                        <span class="product__button-icon product__button-icon--checked">
                            <SvgSprite type="checkmark" :size="40" />
                        </span>
                    </button>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
    import type { Product } from '~/interfaces/product.ts';

    const props = defineProps({
        product: {
            type: Object as () => Product,
            required: true,
            default: () => ({}) as Product,
        },
        variant: {
            type: String as () => 'large' | null,
            default: null,
            validator: (val: string) => ['large'].includes(val),
        },
    });

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

    // utils
    function calcOldPrice(price: number, discount: number): string {
        const result = (price / (1 - discount / 100)).toFixed(0);
        return result;
    }
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .product {
        $p: &;
        $border-radius: rem(24);

        position: relative;
        max-width: rem(345);
        &--large {
            max-width: rem(415);
        }
        &__sticker {
            position: absolute;
            top: 0;
            left: 0;
            translate: -30% -50%;
            width: rem(80);
            aspect-ratio: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: rem(20);
            color: $c-FFFFFF;
            rotate: -15deg;
            @supports (mask-image: url()) {
                > * {
                    position: relative;
                    z-index: 1;
                }
                &::before {
                    content: '';
                    position: absolute;
                    z-index: 0;
                    inset: 0;
                    mask-image: url('/img/masks/pinion.svg');
                    mask-size: 100% 100%;
                    background-color: $c-accent;
                    animation: sticker-spin 15s linear infinite;
                }
                @keyframes sticker-spin {
                    from {
                        rotate: 0;
                    }
                    to {
                        rotate: -360deg;
                    }
                }
            }
            @supports not (mask-image: url()) {
                background-color: $c-accent;
                border-radius: 50%;
            }
        }
        &__wrapper {
            display: flex;
            flex-direction: column;
            border-radius: $border-radius;
            overflow: hidden;
        }
        &__image-container {
            // flex: 0 1 80%;
            width: 100%;
            height: 100%;
            img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
        }
        &__content {
            // flex: 0 1 20%;
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
            gap: 0.5ch;
            margin-top: rem(4);
            &-item {
                width: fit-content;
                white-space: nowrap;
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
</style>
