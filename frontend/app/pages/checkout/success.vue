<template>
    <NuxtLayout>
        <ClientOnly>
            <div class="order-success">
                <div class="order-success__container">
                    <div class="order-success__payload">
                        <div class="order-success__titlebox">
                            <h1 class="order-success__title">Заказ успешно оформлен!</h1>
                            <p class="order-success__desc">
                                Вы можете отследить ваш заказ в&nbsp;личном кабинете
                            </p>
                        </div>
                        <ul class="order-success__list">
                            <li
                                v-for="(item, idx) in products"
                                :key="idx"
                                class="order-success__item"
                            >
                                <NuxtLink
                                    class="order-success__item-image-container"
                                    :to="{ name: 'product-id', params: { id: item.product_id } }"
                                >
                                    <img
                                        class="order-success__item-image"
                                        :src="getProductImageById(item.product_id)"
                                        :alt="getProductTitleById(item.product_id) ?? '#'"
                                    />
                                </NuxtLink>
                                <div class="order-success__item-body">
                                    <h3 class="order-success__item-title">
                                        {{ getProductTitleById(item.product_id) }}
                                    </h3>
                                    <ul class="order-success__item-desc">
                                        <li v-if="translateProductModifier(item.modifier)">
                                            {{ translateProductModifier(item.modifier) }}
                                        </li>
                                        <li v-if="item.quantity">{{ `${item.quantity} шт.` }}</li>
                                    </ul>
                                </div>
                            </li>
                        </ul>
                        <NuxtLink class="order-success__button" :to="{ name: 'profile' }">
                            <span>В личный кабинет</span>
                            <span>
                                <SvgSprite type="arrow" :size="14" />
                            </span>
                        </NuxtLink>
                    </div>
                    <picture class="order-success__image-container">
                        <img
                            class="order-success__image"
                            src="/img/service/flowers.jpg"
                            alt="Заказ успешно оформлен"
                        />
                    </picture>
                </div>
            </div>
        </ClientOnly>
        <CHintCarousel title="Рекомендуем" />
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { ICartItem } from '~~/interfaces/entities/cart-item';

    const router = useRouter();
    const route = useRoute();
    const cartStore = useCartStore();

    const { getProductImageById, getProductTitleById, translateProductModifier } = cartStore;

    const payload = route.query.order as string | undefined;
    const products = ref<ICartItem[]>([]);

    onMounted(() => {
        if (!payload) {
            router.push('404');
            return;
        }
        products.value = JSON.parse(payload);
    });
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .order-success {
        $p: &;

        margin: lineScale(96, 64, 480, 1920) 0;
        &__container {
            width: 100%;
            max-width: rem(1280);
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            border-radius: rem(64);
            overflow: hidden;
            box-shadow: 1px 1px 5px rgba($c-98BBD7, 0.5);
            margin: 0 auto;
        }
        &__payload {
            display: flex;
            flex-direction: column;
            gap: rem(32);
            font-family: 'Inter', sans-serif;
            padding: rem(64) lineScale(64, 16, 480, 1920);
        }
        &__image-container {
            position: relative;
            display: block;
            width: 100%;
            height: 100%;
        }
        &__image {
            position: absolute;
            inset: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        &__titlebox {
            display: flex;
            flex-direction: column;
            gap: rem(16);
        }
        &__title {
            font-size: lineScale(32, 22, 480, 1920);
            font-weight: $fw-semi;
            line-height: 1.2;
        }
        &__desc {
            font-size: lineScale(18, 16, 480, 1920);
        }
        &__list {
            display: flex;
            flex-direction: column;
            gap: rem(8);
        }
        &__item {
            display: flex;
            gap: rem(8);
            &-image-container {
                display: block;
                width: rem(80);
                min-width: rem(80);
                aspect-ratio: 1;
                border-radius: rem(8);
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
                justify-content: space-between;
                padding: rem(4) 0;
            }
            &-title {
                font-size: lineScale(22, 20, 480, 1920);
                font-weight: $fw-semi;
                @include lineClamp(2);
            }
            &-desc {
                display: flex;
                flex-direction: column;
                gap: rem(8);
                font-size: rem(16);
                font-weight: $fw-semi;
                opacity: 0.5;
            }
        }
        &__button {
            justify-content: center;
            @include button-primary(
                $width: 100%,
                $border-color: $c-accent,
                $anim-color: $c-accent,
                $font-size: lineScale(20, 18, 480, 1920),
                $padding: rem(14) rem(32)
            );
        }
    }

    @media (max-width: 1280px) {
        .order-success {
            margin-top: 0;
            &__container {
                border-radius: 0 0 rem(64) rem(64);
            }
        }
    }

    @media (max-width: 1024px) {
        .order-success {
            &__container {
                display: flex;
                flex-direction: column;
                border-radius: 0 0 rem(32) rem(32);
            }
            &__image-container {
                display: none;
            }
        }
    }
</style>
