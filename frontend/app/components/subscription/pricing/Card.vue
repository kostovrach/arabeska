<template>
    <NuxtLink class="pricing-card" :to="{ name: 'product-id', params: { id: card.id } }">
        <div v-if="card.discount" class="pricing-card__sticker pricing-card__sticker--discount">
            <span>-{{ calcDiscountPercent(card.price, card.discount ?? card.price) }}%</span>
        </div>
        <div class="pricing-card__wrapper">
            <picture class="pricing-card__image-container">
                <img
                    class="pricing-card__image"
                    :src="`/api/cms/assets/${card.images[0]?.directus_files_id.id}`"
                    :alt="card.title"
                />
            </picture>
            <div class="pricing-card__content">
                <h3 class="pricing-card__title">{{ card.title }}</h3>
                <!-- <div class="pricing-card__desc" v-html="card.description"></div> -->
                <div class="pricing-card__footer">
                    <div class="pricing-card__price">
                        <span
                            v-if="card.discount && typeof card.discount === 'number'"
                            class="pricing-card__price-crossed"
                        >
                            {{ card.price.toLocaleString() }}
                            <span class="ruble"></span>
                        </span>
                        <span class="pricing-card__price-current">
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
                            'pricing-card__button',
                            inCart ? 'pricing-card__button--checked' : '',
                        ]"
                        :title="inCart ? 'В корзине' : 'Добавить в корзину'"
                        @click.prevent="toggleCart"
                    >
                        <span class="pricing-card__button-icon pricing-card__button-icon--default">
                            <SvgSprite type="cart" :size="32" />
                        </span>
                        <span class="pricing-card__button-icon pricing-card__button-icon--checked">
                            <SvgSprite type="checkmark" :size="32" />
                        </span>
                    </button>
                </div>
            </div>
        </div>
    </NuxtLink>
</template>

<script setup lang="ts">
    import type { ICartItem } from '~~/interfaces/entities/cart-item';
    import type { IProduct } from '~~/interfaces/entities/product';

    const props = defineProps<{
        data: IProduct;
    }>();

    const card = props.data;

    const instance: ICartItem = {
        product_id: card.id,
        quantity: 1,
        modifier: 'standart',
    };

    const cartStore = useCartStore();

    const inCart = computed(() => cartStore.checkItemInCart(instance));

    const toggleCart = useDebounceFn(() => {
        if (!inCart.value) {
            cartStore.addToCart(instance);
        } else {
            cartStore.removeFromCart(instance);
        }
    }, 200);
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .pricing-card {
        $p: &;

        position: relative;
        aspect-ratio: 1/1.3;
        @media (pointer: fine) {
            &:hover {
                #{$p}__desc {
                    flex: 1;
                }
            }
        }
        &__sticker {
            position: absolute;
            z-index: 2;
            top: rem(16);
            left: rem(16);
            translate: -50% -50%;
            @include sticker($bg-color: $c-F5142B);
        }
        &__wrapper {
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
        &__image-container {
            position: absolute;
            z-index: -1;
            inset: 0;
            filter: brightness(70%);
        }
        &__image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        &__content {
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
        &__title {
            font-size: lineScale(32, 20, 480, 1440);
            font-weight: $fw-semi;
        }
        &__desc {
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
        &__footer {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
        }
        &__button {
            cursor: pointer;
            position: relative;
            width: rem(48);
            aspect-ratio: 1;
            color: $c-FFFFFF;
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
        &__price {
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

    @media (max-width: 1100px) {
        .pricing-card {
            aspect-ratio: 1.2/1;
        }
    }

    @media (max-width: 768px) {
        .pricing-card {
            aspect-ratio: 1/1.2;
        }
    }

    @media (max-width: 540px) {
        .pricing-card {
            aspect-ratio: 1.1/1;
        }
    }
</style>
