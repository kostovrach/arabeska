<template>
    <NuxtLayout>
        <section class="product-view">
            <div class="product-view__container">
                <div class="product-view__loading" v-show="status === 'pending'">
                    <ProductPageLoader />
                </div>
                <div class="product-view__error" v-show="status === 'error' || status === 'idle'">
                    <FetchError />
                </div>
                <div class="product-view__body" v-show="status === 'success'">
                    <div class="product-view__slider">
                        <div class="product-view__slider-wrapper">
                            <div
                                class="product-view__sticker product-view__sticker--discount"
                                v-if="product?.discount && !isNewProduct(product?.date_created)"
                            >
                                <span>
                                    -{{
                                        calcDiscountPercent(
                                            product.price,
                                            product.discount ?? product.price
                                        )
                                    }}%
                                </span>
                            </div>
                            <div
                                class="product-view__sticker product-view__sticker--new"
                                v-if="isNewProduct(product?.date_created)"
                            >
                                <span>new!</span>
                            </div>

                            <ProductPageSlider :product="product" />
                        </div>
                    </div>
                    <div class="product-view__content">
                        <div class="product-view__main">
                            <div class="product-view__titlebox">
                                <h1 class="product-view__title">{{ product?.title }}</h1>
                                <p class="product-view__desc">{{ product?.description }}</p>
                                <div class="product-view__share-menu">
                                    <ProductPageShare />
                                </div>
                            </div>
                            <div class="product-view__controls">
                                <ul class="product-view__variant">
                                    <li class="product-view__variant-item">
                                        <div class="product-view__variant-toggler">
                                            <input
                                                v-model="productModel.type"
                                                type="radio"
                                                name="variant"
                                                value="standart"
                                                id="variant-standart"
                                            />
                                        </div>
                                        <p class="product-view__type-desc">
                                            <strong>Стандарт</strong>
                                            — собрать букет как на фото
                                        </p>
                                    </li>
                                    <li class="product-view__variant-item">
                                        <div class="product-view__variant-toggler">
                                            <input
                                                v-model="productModel.type"
                                                type="radio"
                                                name="variant"
                                                value="large"
                                                id="variant-large"
                                            />
                                        </div>
                                        <p class="product-view__variant-desc">
                                            <strong>Роскошный</strong>
                                            — на 50% больше цветов
                                        </p>
                                    </li>
                                    <li class="product-view__variant-item">
                                        <div class="product-view__variant-toggler">
                                            <input
                                                v-model="productModel.type"
                                                type="radio"
                                                name="variant"
                                                value="premium"
                                                id="variant-premium"
                                            />
                                        </div>
                                        <p class="product-view__variant-desc">
                                            <strong>Премиум</strong>
                                            — в 2 раза больше цветов, крафтовая упаковка
                                        </p>
                                    </li>
                                </ul>

                                <div class="product-view__button-container">
                                    <CircleButton
                                        class="product-view__button"
                                        type="button"
                                        logic="double-line"
                                    >
                                        <span>Добавить в&nbsp;корзину</span>
                                    </CircleButton>
                                </div>

                                <div class="product-view__counter">
                                    <button
                                        type="button"
                                        @click="removeQuantity"
                                        :disabled="productModel.quantity <= 1"
                                    >
                                        <SvgSprite type="minus" :size="14" />
                                    </button>
                                    <span>{{ productModel.quantity }}</span>
                                    <button
                                        type="button"
                                        @click="addQuantity"
                                        :disabled="productModel.quantity >= 5"
                                    >
                                        <SvgSprite type="plus" :size="14" />
                                    </button>
                                </div>
                            </div>
                            <ul class="product-view__price">
                                <li class="product-view__price-crossed" v-if="product?.discount">
                                    <span>
                                        {{
                                            product?.discount
                                                ? totalPrice.toLocaleString()
                                                : discountPrice.toLocaleString()
                                        }}
                                    </span>
                                    <span class="ruble"></span>
                                </li>
                                <li class="product-view__price-current">
                                    <span>
                                        {{
                                            product?.discount
                                                ? discountPrice.toLocaleString()
                                                : totalPrice.toLocaleString()
                                        }}
                                    </span>
                                    <span class="ruble"></span>
                                </li>
                            </ul>
                        </div>
                        <div class="product-view__sider" v-if="product?.structure">
                            <picture class="product-view__sider-image">
                                <img src="/img/service/flowers-placeholder.png" alt="Состав" />
                            </picture>
                            <div class="product-view__sider-list">
                                <p>Состав</p>
                                <ul>
                                    <li v-for="(item, idx) in product?.structure" :key="idx">
                                        <span>{{ item.name }}</span>
                                        <span v-if="item.quantity">&mdash;{{ item.quantity }}</span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <ul class="product-view__footer">
                            <li class="product-view__footer-card" v-if="1 === 1">
                                <span><SvgSprite type="user-fill" :size="24" /></span>
                                <div>
                                    <NuxtLink :to="{ name: 'index' }">Авторизуйтесь,</NuxtLink>
                                    чтобы&nbsp;снизить цену
                                </div>
                            </li>
                            <li class="product-view__footer-card" v-if="1 === 1">
                                <span><SvgSprite type="delivery" :size="24" /></span>
                                <span>Бесплатная доставка от 1500 ₽</span>
                            </li>
                            <li class="product-view__footer-card" v-if="product?.size">
                                <span><SvgSprite type="box" :size="24" /></span>
                                <span>Размеры {{ product?.size }}</span>
                            </li>
                        </ul>
                    </div>
                    <div class="product-view__info">
                        <ProductPageAccordion />
                    </div>
                </div>
            </div>
        </section>
    </NuxtLayout>
</template>

<script setup lang="ts">
    // data =================================================================
    const route = useRoute();

    const productsStore = useProductsStore();

    productsStore.getProductById(route.params.id);

    const { productsItem, singleProductStatus } = storeToRefs(productsStore);

    const product = computed(() => productsItem.value);
    const status = computed(() => singleProductStatus.value);
    // =====================================================================

    // SEO & Meta ===========================================================
    useHead(() => ({
        title: `Букет "${product.value?.title}" - Arabeska`,
        meta: [
            {
                name: 'description',
                content: `Купить букет "${product.value?.title}" в Самаре или заказать с доставкой.`,
            },
            {
                property: 'og:title',
                content: `Купить букет "${product.value?.title}" в Самаре или заказать с доставкой.`,
            },
            {
                property: 'og:description',
                content: `${product.value?.description}`,
            },
            {
                property: 'og:image',
                content: product.value?.images[0],
            },
            {
                name: 'twitter:card',
                content: 'summary_large_image',
            },
        ],
    }));
    // ======================================================================

    // product processing ===================================================
    // model
    const productModel = reactive({
        type: 'standart',
        quantity: 1,
    });

    // multipliers
    const variantMultipliers: Record<string, number> = {
        standart: 1,
        large: 1.5,
        premium: 2,
    };

    // price
    const discountPrice = computed(() => {
        if (!product?.value?.discount) return 0;

        const multiplier = variantMultipliers[productModel.type] || 1;
        return product?.value?.discount * multiplier * productModel.quantity;
    });

    const totalPrice = computed(() => {
        if (!product?.value?.price) return 0;

        const multiplier = variantMultipliers[productModel.type] || 1;
        return product?.value?.price * multiplier * productModel.quantity;
    });

    // counter
    const addQuantity = () => {
        if (productModel.quantity < 5) productModel.quantity++;
    };
    const removeQuantity = () => {
        if (productModel.quantity > 1) productModel.quantity--;
    };
    // =====================================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .product-view {
        margin: lineScale(64, 32, 480, 1440) 0;
        &__container {
            @include content-container;
        }
        &__body {
            display: grid;
            grid-template-columns: minmax(20%, rem(634)) auto;
            grid-template-areas:
                'slider content'
                'slider info';
            gap: rem(64);
        }
        &__slider {
            grid-area: slider;
            position: relative;
            width: fit-content;
            height: 100%;
            &-wrapper {
                position: sticky;
                top: rem(136);
                width: 100%;
                height: fit-content;
            }
        }
        &__sticker {
            position: absolute;
            top: 0;
            right: 0;
            z-index: 2;
            translate: 50% -50%;
            &--discount {
                @include sticker($bg-color: $c-accent);
            }
            &--new {
                text-transform: uppercase;
                @include sticker($bg-color: $c-F5142B);
            }
        }
        &__content {
            grid-area: content;
            width: 100%;
            display: grid;
            grid-template-areas:
                'main sider'
                'footer footer';
            gap: lineScale(64, 32, 480, 1440);
        }
        &__main {
            grid-area: main;
            width: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            gap: rem(32);
        }
        &__titlebox {
            width: 100%;
            display: grid;
            grid-template-areas:
                'title share'
                'desc share';
            justify-content: space-between;
            gap: rem(32);
        }
        &__title {
            grid-area: title;
            font-size: lineScale(64, 32, 480, 1440);
            line-height: 1;
            font-weight: $fw-semi;
        }
        &__share-menu {
            grid-area: share;
            color: $c-98BBD7;
        }
        &__desc {
            grid-area: desc;
            font-size: lineScale(18, 16, 480, 1440);
        }
        &__variant {
            display: flex;
            flex-direction: column;
            gap: rem(16);
            &-item {
                display: flex;
                align-items: center;
                gap: rem(8);
            }
            &-toggler {
                @include toggler();
            }
            &-desc {
                font-family: 'Inter', sans-serif;
                line-height: 1.4;
            }
        }
        &__button-container {
            max-height: rem(128);
            align-self: flex-end;
            justify-self: flex-end;
            translate: 0 30%;
            overflow: visible;
            pointer-events: none;
        }
        &__button {
            font-size: lineScale(24, 20, 480, 1440);
            pointer-events: auto;
        }
        &__counter {
            width: fit-content;
            display: flex;
            align-items: center;
            gap: rem(24);
            border: rem(1) solid $c-accent;
            border-radius: rem(32);
            overflow: hidden;
            user-select: none;
            span {
                font-size: lineScale(18, 16, 480, 1440);
            }
            button {
                cursor: pointer;
                padding: rem(8) rem(12);
                translate: 0 rem(2);
                @media (pointer: fine) {
                    &:hover {
                        color: $c-accent;
                    }
                }
                &[disabled] {
                    opacity: 0.5;
                    pointer-events: none;
                }
            }
        }
        &__price {
            display: flex;
            flex-direction: column;
            gap: rem(4);
            &-crossed {
                position: relative;
                width: fit-content;
                font-size: rem(24);
                > span {
                    opacity: 0.5;
                }
                &::before {
                    content: '';
                    position: absolute;
                    top: 50%;
                    left: 50%;
                    translate: -50% -50%;
                    width: 120%;
                    height: rem(2);
                    background-color: $c-accent;
                    rotate: -8deg;
                }
            }
            &-current {
                font-size: lineScale(48, 24, 480, 1440);
            }
        }
        &__sider {
            grid-area: sider;
            justify-self: flex-end;
            &-image {
                max-width: rem(228);
                aspect-ratio: 1;
                img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }
            }
            &-list {
                margin-top: rem(32);
                > p {
                    font-size: lineScale(18, 16, 480, 1440);
                    font-weight: $fw-bold;
                }
                > ul {
                    display: flex;
                    flex-direction: column;
                    gap: rem(8);
                    font-family: 'Inter', sans-serif;
                    font-size: rem(14);
                    margin-top: rem(16);
                }
            }
        }
        &__footer {
            grid-area: footer;
            display: flex;
            align-items: center;
            gap: rem(8);
            &-card {
                flex: 1 1 30%;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: rem(16);
                padding: rem(16) rem(24);
                border-radius: rem(32);
                font-family: 'Inter', sans-serif;
                text-wrap: balance;
                line-height: 1.2;
                background-color: $c-E5F2D8;
                > span:has(svg) {
                    width: rem(48);
                    height: rem(48);
                    aspect-ratio: 1;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    color: $c-FFFFFF;
                    border-radius: 50%;
                    background-color: $c-accent;
                }
                a {
                    text-decoration: underline;
                    @media (pointer: fine) {
                        &:hover {
                            text-decoration: none;
                        }
                    }
                }
            }
        }
        &__info {
            grid-area: info;
        }
    }
</style>
