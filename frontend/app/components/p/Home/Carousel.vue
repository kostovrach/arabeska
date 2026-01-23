<template>
    <section v-if="products.length" class="home-carousel">
        <div class="home-carousel__container">
            <div class="home-carousel__titlebox">
                <StarsOverlay class="home-carousel__title">
                    <h2 v-html="props.title"></h2>
                </StarsOverlay>
                <NuxtLink
                    v-if="props.wtithLink"
                    :to="{
                        name: 'catalog-category',
                        params: { category: slugify(props.category) },
                    }"
                    class="home-carousel__link"
                >
                    <span>Смотреть все</span>
                    <SvgSprite type="arrow" :size="12" />
                </NuxtLink>
            </div>
            <div class="home-carousel__body">
                <EmblaContainer
                    ref="sliderRef"
                    :options="{ loop: true, align: 'center', dragFree: true }"
                    :autoScroll="props.autoplay"
                    :autoScrollOptions="{ speed: 1 }"
                    :stop-scroll-on-hover="true"
                    padding="48px 0"
                >
                    <EmblaSlide
                        v-for="product in products"
                        :key="product.id"
                        class="home-carousel__slide"
                    >
                        <ProductCard :data="product" />
                    </EmblaSlide>
                </EmblaContainer>

                <div class="home-carousel__controls">
                    <EmblaNavigation
                        v-if="!props.autoplay"
                        :slider-ref="computed(() => sliderRef)"
                    />
                </div>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    import type { EmblaCarouselType } from 'embla-carousel';

    const props = withDefaults(
        defineProps<{
            autoplay?: boolean;
            title?: string;
            wtithLink?: boolean;
            category: string;
        }>(),
        {
            title: '',
            wtithLink: true,
            autoplay: false,
        }
    );

    const productsStore = useProductsStore();

    const products = computed(() =>
        productsStore.products.filter((product) =>
            product.category?.some(
                (category) =>
                    slugify(category.categories_id?.name ?? 'unknow') === slugify(props.category)
            )
        )
    );

    const sliderRef = ref<{ emblaApi: EmblaCarouselType | null } | null>(null);
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .home-carousel {
        @include content-block($margin: lineScale(128, 96, 480, 1440));
        &__container {
            @include content-container($padding: 0);
        }
        &__titlebox {
            display: grid;
            grid-template-columns: 1fr auto 1fr;
            grid-template-rows: repeat(2, auto);
            grid-template-areas:
                '. title .'
                'link link link';
            gap: rem(32);
            padding: 0 $px;
        }
        &__title {
            grid-area: title;
            max-width: 25ch;
            justify-self: center;
            font-size: lineScale(64, 32, 480, 1440);
            font-weight: $fw-semi;
            text-align: center;
        }
        &__link {
            grid-area: link;
            justify-self: flex-end;
            align-self: flex-end;
            display: flex;
            align-items: center;
            gap: rem(4);
            white-space: nowrap;
            @include hover-blick-line;
        }
        &__loader {
            width: 100%;
            overflow: hidden;
            padding: rem(40) 0;
            &-wrapper {
                min-width: max-content;
            }
        }
        &__error {
            width: 100%;
            min-height: rem(400);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: rem(16);
            text-align: center;
        }
        &__controls {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: rem(32);
        }
        &__button {
            @include slider-buttons;
        }
        &__slide {
            width: fit-content;
            margin-right: lineScale(24,16,480,1920);
        }
    }
</style>
