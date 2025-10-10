<template>
    <NuxtLayout>
        <section class="product-view">
            <div class="product-view__container">
                <div class="product-view__loading" v-show="status === 'pending'">Загрузка...</div>
                <div class="product-view__body" v-show="status === 'success'">
                    <ClientOnly>
                        <div class="product-view__slider">
                            <div class="product-view__slider-wrapper">
                                <ProductPageSlider :product="product" />
                            </div>
                        </div>
                        <div class="product-view__content">
                            <div class="product-view__main">
                                <div class="product-view__titlebox">
                                    <h1 class="product-view__title">{{ product?.title }}</h1>
                                    <p class="product-view__desc">{{ product?.description }}</p>
                                    <div class="product-view__share-menu">
                                        <SvgSprite type="share" :size="32" />
                                    </div>
                                </div>
                                <form class="product-view__controls">
                                    <ul class="product-view__type">
                                        <li class="product-view__type-item">
                                            <div class="product-view__type-toggler">
                                                <input
                                                    type="radio"
                                                    name="type"
                                                    id="type-standart"
                                                    checked
                                                />
                                            </div>
                                            <p class="product-view__type-desc">
                                                <span>Стандарт</span>
                                                — собрать букет как на фото
                                            </p>
                                        </li>
                                        <li class="product-view__type-item">
                                            <div class="product-view__type-toggler">
                                                <input type="radio" name="type" id="type-large" />
                                            </div>
                                            <p class="product-view__type-desc">
                                                <span>Роскошный</span>
                                                — на 50% больше цветов
                                            </p>
                                        </li>
                                        <li class="product-view__type-item">
                                            <div class="product-view__type-toggler">
                                                <input type="radio" name="type" id="type-premium" />
                                            </div>
                                            <p class="product-view__type-desc">
                                                <span>Премиум</span>
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
                                        <button><SvgSprite type="minus" :size="20" /></button>
                                        <span>1</span>
                                        <button><SvgSprite type="plus" :size="20" /></button>
                                    </div>
                                </form>
                                <ul class="product-view__price">
                                    <li
                                        class="product-view__price-crossed"
                                        v-if="product?.discount"
                                    >
                                        <span>{{ product.discount }}</span>
                                        <span class="ruble"></span>
                                    </li>
                                    <li class="product-view__price-current">
                                        <span>{{ product?.price }}</span>
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
                                            <span v-if="item.quantity">
                                                &mdash;{{ item.quantity }}
                                            </span>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <ul class="product-view__footer">
                                <li class="product-view__footer-card" v-if="1 === 1">
                                    <span><SvgSprite type="user-fill" :size="40" /></span>
                                    <div>
                                        <NuxtLink :to="{ name: 'index' }">Авторизуйтесь,</NuxtLink>
                                        чтобы&nbsp;снизить цену
                                    </div>
                                </li>
                                <li class="product-view__footer-card" v-if="1 === 1">
                                    <span><SvgSprite type="delivery" :size="40" /></span>
                                    <span>Бесплатная доставка от 1500 ₽</span>
                                </li>
                                <li class="product-view__footer-card" v-if="product?.size">
                                    <span><SvgSprite type="box" :size="40" /></span>
                                    <span>Размеры {{ product?.size }}</span>
                                </li>
                            </ul>
                        </div>
                    </ClientOnly>
                </div>
            </div>
        </section>
    </NuxtLayout>
</template>

<script setup lang="ts">
    // data=================================================================
    const route = useRoute().params.id;
    const productsStore = useProductsStore();

    productsStore.getProductById(route);

    const { productsItem, singleProductStatus } = storeToRefs(productsStore);

    const product = computed(() => productsItem.value);
    const status = computed(() => singleProductStatus.value);
    // =====================================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .product-view {
        margin: rem(64) 0;
        &__container {
            @include content-container;
        }
        &__body {
            display: grid;
            grid-template-columns: minmax(20%, rem(634)) auto;
            gap: rem(64);
        }
        &__slider-container {
            position: relative;
            width: 100%;
            height: 100%;
        }
        &__slider-wrapper {
            width: 100%;
            height: fit-content;
        }
        &__slider {
            position: relative;
            width: fit-content;
            height: 100%;
            &-wrapper {
                position: sticky;
                top: rem(132);
            }
        }
        &__content {
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
            font-weight: $fw-semi;
        }
        &__share-menu {
            grid-area: share;
        }
        &__desc {
            grid-area: desc;
            font-size: lineScale(18, 16, 480, 1440);
        }
        &__share-menu {
            cursor: pointer;
            color: $c-98BBD7;
        }
        &__type {
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
                span {
                    font-weight: $fw-bold;
                }
            }
        }
        &__button-container {
            max-height: rem(128);
            align-self: flex-end;
            justify-self: flex-end;
            translate: -50% 50%;
            overflow: visible;
            pointer-events: none;
        }
        &__button {
            pointer-events: auto;
        }
        &__counter {
            width: fit-content;
            display: flex;
            align-items: center;
            gap: rem(40);
            border: rem(1) solid $c-accent;
            border-radius: rem(32);
            overflow: hidden;
            span {
                font-size: lineScale(24, 18, 480, 1440);
            }
            button {
                cursor: pointer;
                padding: rem(12);
                @media (pointer: fine) {
                    &:hover {
                        color: $c-accent;
                    }
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
                font-size: lineScale(64, 48, 480, 1440);
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
        }
    }
</style>
