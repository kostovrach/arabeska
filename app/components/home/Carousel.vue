<template>
    <section class="home-carousel">
        <div class="home-carousel__container">
            <div class="home-carousel__titlebox">
                <h2 class="home-carousel__title">{{ props.title }}</h2>
                <NuxtLink :to="{ name: 'index' }" class="home-carousel__link" v-if="props.wtithLink">
                    <span>Смотреть все</span>
                    <SvgSprite type="arrow" :size="12" />
                </NuxtLink>
            </div>
            <div class="home-carousel__body">
                <template v-if="status === 'pending'">Загрузка...</template>
                <ClientOnly>
                    <template v-if="status === 'success'">
                        <swiper-container
                            class="home-carousel__slider"
                            ref="sliderRef"
                            :init="status === 'success'"
                            :navigation="navigationOptions"
                            slides-per-view="auto"
                            :space-between="32"
                            :speed="800"
                        >
                            <swiper-slide class="home-carousel__slide" v-for="product in products" :key="product.id">
                                <ProductCard :product="product" :variant="props.cardVariant" />
                            </swiper-slide>
                        </swiper-container>
                        <div class="home-carousel__controls" v-if="props.wtithControls">
                            <button
                                class="home-carousel__button home-carousel__button--prev"
                                @click="goPrev"
                                :disabled="swiper.realIndex.value === 0"
                            >
                                <SvgSprite type="arrow" />
                            </button>
                            <button
                                class="home-carousel__button home-carousel__button--next"
                                @click="goNext"
                                :disabled="swiper.progress.value === 1"
                            >
                                <SvgSprite type="arrow" />
                            </button>
                        </div>
                    </template>
                </ClientOnly>

                <!-- <template v-else>Ошибка загрузки данных</template> -->
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    // types
    import type { AsyncDataRequestStatus } from '#app';
    import type { Ref } from 'vue';
    import type { IProduct } from '~/interfaces/product';

    const props = defineProps<{
        contentRef: Ref<IProduct[] | null>;
        statusRef: Ref<AsyncDataRequestStatus>;
        title?: string;
        wtithControls?: boolean;
        wtithLink?: boolean;
        cardVariant?: 'large' | null;
    }>();

    const status = computed(() => props.statusRef.value);
    const products = computed(() => props.contentRef.value ?? []);

    // отладочный watch (не выводить status в шаблон!)
    watch(
        () => props.statusRef.value,
        (s) => {
            console.log('Status changed to:', s);
        }
    );

    // slider==============================================
    const sliderRef = ref(null);

    const swiper = useSwiper(sliderRef);

    const goPrev = () => swiper.prev();
    const goNext = () => swiper.next();

    const navigationOptions = {
        prevEl: '.home-carousel__button--prev',
        nextEl: '.home-carousel__button--next',
    };
    //=====================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .home-carousel {
        @include content-block;
        &__container {
            @include content-container($padding: 0);
        }
        &__titlebox {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            grid-template-areas: '. title link';
            padding: 0 $px;
        }
        &__title {
            grid-area: title;
            justify-self: center;
            font-size: lineScale(64, 24, 480, 1440);
            font-weight: $fw-semi;
        }
        &__link {
            grid-area: link;
            justify-self: flex-end;
            align-self: flex-end;
            display: flex;
            align-items: center;
            gap: rem(4);
            @include hover-blick-line;
        }
        &__controls {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: rem(32);
        }
        &__button {
            cursor: pointer;
            display: flex;
            align-items: center;
            &::before {
                content: '';
                display: block;
                width: rem(32);
                height: rem(2);
                transform: scaleY(0.89);
                translate: 0 -0.5px;
                background-color: currentColor;
                transition: width $td $tf;
            }
            @media (pointer: fine) {
                &:hover {
                    &::before {
                        width: rem(48);
                    }
                }
            }
            &[disabled] {
                opacity: 0.5;
                &::before {
                    width: 0;
                }
            }
            &--prev {
                transform: scaleX(-1);
            }
        }
        &__slide {
            width: fit-content;
            padding: rem(40) 0;
        }
    }
</style>
