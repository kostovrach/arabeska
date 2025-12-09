<template>
    <NuxtLayout>
        <section class="product-view">
            <div class="product-view__container">
                <div v-show="status === 'pending'" class="product-view__loading">
                    <ProductLoader />
                </div>
                <div v-show="status === 'error' || status === 'idle'" class="product-view__error">
                    <FetchError />
                </div>
                <div v-show="status === 'success'" class="product-view__body">
                    <div class="product-view__slider">
                        <div class="product-view__slider-wrapper">
                            <div
                                v-if="product?.discount && !isNewProduct(product?.date_created)"
                                class="product-view__sticker product-view__sticker--discount"
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
                                v-if="isNewProduct(product?.date_created)"
                                class="product-view__sticker product-view__sticker--new"
                            >
                                <span>new!</span>
                            </div>

                            <ProductSlider :product="product" />
                        </div>
                    </div>
                    <div class="product-view__content">
                        <div class="product-view__main">
                            <div class="product-view__titlebox">
                                <h1 class="product-view__title">{{ product?.title }}</h1>
                                <ClientOnly>
                                    <div
                                        class="product-view__desc"
                                        v-if="product?.description"
                                        v-html="product?.description"
                                    ></div>
                                </ClientOnly>
                                <div class="product-view__share-menu">
                                    <ProductShare />
                                </div>
                            </div>
                            <div class="product-view__controls">
                                <ul class="product-view__variant" v-if="!isControlsDisabled">
                                    <li class="product-view__variant-item">
                                        <div class="product-view__variant-toggler">
                                            <input
                                                id="variant-standart"
                                                v-model="productModel.type"
                                                type="radio"
                                                name="variant"
                                                value="standart"
                                            />
                                        </div>
                                        <label
                                            for="variant-standart"
                                            class="product-view__type-desc"
                                        >
                                            <strong>Стандарт</strong>
                                            — собрать букет как на фото
                                        </label>
                                    </li>
                                    <li class="product-view__variant-item">
                                        <div class="product-view__variant-toggler">
                                            <input
                                                id="variant-large"
                                                v-model="productModel.type"
                                                type="radio"
                                                name="variant"
                                                value="large"
                                            />
                                        </div>
                                        <label
                                            for="variant-large"
                                            class="product-view__variant-desc"
                                        >
                                            <strong>Роскошный</strong>
                                            — на 50% больше цветов
                                        </label>
                                    </li>
                                    <li class="product-view__variant-item">
                                        <div class="product-view__variant-toggler">
                                            <input
                                                id="variant-premium"
                                                v-model="productModel.type"
                                                type="radio"
                                                name="variant"
                                                value="premium"
                                            />
                                        </div>
                                        <label
                                            for="variant-premium"
                                            class="product-view__variant-desc"
                                        >
                                            <strong>Премиум</strong>
                                            — в 2 раза больше цветов, крафтовая упаковка
                                        </label>
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

                                <div class="product-view__counter" v-if="!isSubscriptionPricing">
                                    <button
                                        type="button"
                                        :disabled="productModel.quantity <= 1"
                                        @click="removeQuantity"
                                    >
                                        <SvgSprite type="minus" :size="14" />
                                    </button>
                                    <span>{{ productModel.quantity }}</span>
                                    <button
                                        type="button"
                                        :disabled="productModel.quantity >= 5"
                                        @click="addQuantity"
                                    >
                                        <SvgSprite type="plus" :size="14" />
                                    </button>
                                </div>
                            </div>
                            <ul class="product-view__price">
                                <li v-if="product?.discount" class="product-view__price-crossed">
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
                        <div v-if="product?.structure?.length" class="product-view__sider">
                            <picture class="product-view__sider-image">
                                <img src="/img/service/flowers-placeholder.png" alt="Состав" />
                            </picture>
                            <div class="product-view__sider-list">
                                <p>Состав</p>
                                <ul>
                                    <li v-for="(item, idx) in product?.structure" :key="idx">
                                        <span>- {{ item.structure_id?.name }}</span>
                                        <!-- <span v-if="item.quantity">&mdash;{{ item.quantity }}</span> -->
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <ul class="product-view__footer">
                            <li v-if="1 === 1" class="product-view__footer-card">
                                <span><SvgSprite type="user-fill" :size="24" /></span>
                                <div>
                                    <NuxtLink :to="{ name: 'index' }">Авторизуйтесь,</NuxtLink>
                                    чтобы&nbsp;снизить цену
                                </div>
                            </li>
                            <li v-if="1 === 1" class="product-view__footer-card">
                                <span><SvgSprite type="delivery" :size="24" /></span>
                                <span>Бесплатная доставка от 1500 ₽</span>
                            </li>
                            <li v-if="product?.size" class="product-view__footer-card">
                                <span><SvgSprite type="box" :size="24" /></span>
                                <span>Размеры {{ product?.size }}</span>
                            </li>
                        </ul>
                    </div>
                    <div class="product-view__info">
                        <ProductAccordion
                            :spoilers="
                                settings?.products_info.map((el) => ({
                                    title: el.title,
                                    content: el.content,
                                })) ?? []
                            "
                            :multiply="true"
                        />
                    </div>
                </div>
            </div>
        </section>
        <HintCarousel title="Вам стоит взглянуть" />
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { IProduct } from '~~/interfaces/entities/product';
    import type { ProductModifiersType } from '~~/interfaces/product-modifiers';
    import type { ISettings } from '~~/interfaces/settings';

    // data =================================================================
    const baseUrl = useRuntimeConfig().public.siteUrl;

    const route = useRoute();

    const { content: settings } = useCms<ISettings>('settings', [
        'disable_controls.*',
        'disable_controls.categories_id.*',
        'subscription_category.*',
    ]);

    const { item: product, status } = useCmsItem<IProduct>('products', route.params.id as string, [
        'images.*',
        'images.directus_files_id.*',
        'category.*',
        'category.categories_id.*',
        'reason.*',
        'reason.reason_id.*',
        'style.*',
        'style.styles_id.*',
        'structure.*',
        'structure.structure_id.*',
    ]);

    const productCategories = computed(() =>
        product.value?.category?.map((el) => slugify(el.categories_id?.name as string))
    );

    const disabledCategories = computed(() =>
        settings.value?.disable_controls.map((el) => slugify(el.categories_id?.name as string))
    );

    const isControlsDisabled = computed(() =>
        productCategories.value?.some((el) => disabledCategories.value?.includes(el))
    );

    const isSubscriptionPricing = computed(() =>
        productCategories.value?.some((el) =>
            el.includes(slugify(settings.value?.subscription_category.name as string))
        )
    );
    // =======================================================================

    // product processing ====================================================
    // model
    const productModel: { id: IProduct['id']; type: ProductModifiersType; quantity: number } =
        reactive({
            id: product?.value?.id!,
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
    // ======================================================================

    // SEO & Meta ===========================================================
    const productMeta = computed(() => ({
        '@context': 'https://schema.org/',
        '@type': 'Product',
        name: `${product.value?.meta_title ?? product.value?.title} | Арабеска - магазин цветов в Самаре`,
        image: `${baseUrl}/api/cms/assets/${product.value?.images[0]?.directus_files_id.id}`,
        description: product.value?.meta_description ?? '',
        sku: product.value?.id,
        brand: 'Arabeska',
        offers: {
            '@type': 'Offer',
            url: `${baseUrl}${route.fullPath}`,
            priceCurrency: 'RUB',
            price: product.value?.discount ? product.value?.discount : product.value?.price,
            availability: 'https://schema.org/InStock',
        },
    }));

    useHead(() => ({
        title: `${product.value?.meta_title ?? product.value?.title ?? ''} | Арабеска - магазин цветов в Самаре`,
        meta: [
            { name: 'description', content: product.value?.meta_description },
            { name: 'keywords', content: product.value?.meta_keywords?.join(',') ?? '' },
            { property: 'og:type', content: 'product' },
            {
                property: 'og:title',
                content: `${product.value?.og_title ?? product.value?.title} | Арабеска - магазин цветов в Самаре`,
            },
            { property: 'og:description', content: product.value?.og_description ?? '' },
            {
                property: 'og:image',
                content: product.value?.og_image
                    ? `${baseUrl}/api/cms/assets/${product.value.og_image}`
                    : `${baseUrl}/api/cms/assets/${product.value?.images[0]?.directus_files_id.id}`,
            },
            { property: 'og:url', content: `${baseUrl}${route.fullPath}` },
            { property: 'og:site:name', content: 'Arabeska' },
            { name: 'twitter:card', content: 'summary_large_image' },
            {
                name: 'twitter:title',
                content: `${product.value?.og_title ?? product.value?.title} | Арабеска - магазин цветов в Самаре`,
            },
            { name: 'twitter:description', content: product.value?.og_description ?? '' },
            {
                name: 'twitter:image',
                content: product.value?.og_image
                    ? `${baseUrl}/api/cms/assets/${product.value.og_image}`
                    : `${baseUrl}/api/cms/assets/${product.value?.images[0]?.directus_files_id.id}`,
            },
        ],
        script: [
            {
                type: 'application/ld+json',
                innerHTML: JSON.stringify(productMeta.value),
            },
        ],
    }));
    // ======================================================================
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .product-view {
        margin: lineScale(64, 32, 480, 1440) 0;
        &__container {
            @include content-container;
        }
        &__body {
            display: grid;
            grid-template-columns: repeat(2, auto);
            grid-template-areas:
                'slider content'
                'slider info';
            gap: lineScale(64, 32, 1024, 1440);
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
                min-width: rem(280);
                height: fit-content;
            }
        }
        &__sticker {
            position: absolute;
            top: rem(16);
            right: rem(16);
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
            display: flex;
            flex-direction: column;
            gap: rem(24);
            font-size: lineScale(18, 16, 480, 1440);
            h2,
            h3,
            h4,
            h5,
            h6 {
                font-size: lineScale(20, 18, 480, 1440);
                font-weight: $fw-semi;
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
        &__controls {
            display: flex;
            flex-direction: column;
        }
        &__variant {
            display: flex;
            flex-direction: column;
            gap: rem(16);
            &-item {
                display: grid;
                grid-template-columns: max-content auto;
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
            font-size: lineScale(20, 16, 480, 1440);
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
                font-size: lineScale(24, 18, 480, 1440);
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

    @media (max-width: 1240px) {
        .product-view {
            &__body {
                grid-template-areas:
                    'slider content'
                    'info info';
            }
            &__content {
                grid-template-areas:
                    'main main'
                    'sider sider'
                    'footer footer';
            }
            &__sider {
                width: 100%;
                display: flex;
                flex-direction: row-reverse;
                justify-content: space-between;
                gap: rem(32);
            }
            &__footer {
                flex-wrap: wrap;
            }
        }
    }

    @media (max-width: 1024px) {
        .product-view {
            &__sider {
                &-image {
                    max-width: rem(160);
                }
            }
        }
    }

    @media (max-width: 768px) {
        .product-view {
            &__body {
                grid-template-areas:
                    'slider slider'
                    'content content'
                    'info info';
            }
        }
    }

    @media (max-width: 580px) {
        .product-view {
            &__footer {
                display: flex;
                flex-direction: column;
                &-card {
                    flex: initial;
                    width: 100%;
                    justify-content: flex-start;
                }
            }
        }
    }
</style>
