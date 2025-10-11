<template>
    <ClientOnly>
        <EmblaContainer ref="mainRef" class="slider slider--main" :options="mainCarouselOptions">
            <EmblaSlide
                class="slider--main-slide"
                v-for="(slide, idx) in props.product?.images"
                :key="idx"
            >
                <picture class="slider--main-slide-image">
                    <img :src="slide" :alt="`Фото ${idx + 1}`" />
                </picture>
            </EmblaSlide>
        </EmblaContainer>
        <EmblaContainer
            ref="thumbsRef"
            class="slider slider--thumbs"
            :options="thumbsCarouselOptions"
        >
            <EmblaSlide
                class="slider--thumbs-slide"
                v-for="(slide, idx) in props.product?.images"
                :key="idx"
                :class="{ 'slider--thumbs-slide--active': activeIndex === idx }"
                @click="onThumbClick(idx)"
            >
                <picture class="slider--thumbs-slide-image">
                    <img :src="slide" :alt="`Фото ${idx + 1}`" />
                </picture>
            </EmblaSlide>
        </EmblaContainer>
    </ClientOnly>
</template>

<script setup lang="ts">
    // types ================================================================
    import type { IProduct } from '~/interfaces/product';
    import type { EmblaCarouselType, EmblaOptionsType } from 'embla-carousel';

    const props = defineProps<{
        product: IProduct | null;
    }>();

    // refs =================================================================
    const mainRef = ref<{ emblaApi: EmblaCarouselType | null } | null>(null);
    const thumbsRef = ref<{ emblaApi: EmblaCarouselType | null } | null>(null);
    const activeIndex = ref(0);

    // options =============================================================
    const mainCarouselOptions: EmblaOptionsType = {
        loop: true,
        align: 'start',
        dragFree: false,
        duration: 35,
    };
    const thumbsCarouselOptions: EmblaOptionsType = {
        loop: false,
        align: 'start',
        dragFree: true,
        duration: 25,
    };

    // Logic =======================================================
    onMounted(() => {
        const main = mainRef.value?.emblaApi;
        const thumbs = thumbsRef.value?.emblaApi;

        if (!main || !thumbs) return;

        const updateActive = () => {
            activeIndex.value = main.selectedScrollSnap();
        };
        main.on('select', updateActive);

        updateActive();
    });

    // Methods =====================================================
    function onThumbClick(index: number) {
        const main = mainRef.value?.emblaApi;
        if (main) main.scrollTo(index);
    }
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .slider {
        &--main {
            width: 100%;
            aspect-ratio: 1;
            border-radius: rem(32);
            &-slide {
                min-width: 100%;
                max-width: 100%;
                height: 100%;
                margin-right: 0;
                overflow: hidden;
                &-image {
                    width: 100%;
                    height: 100%;
                    img {
                        width: 100%;
                        height: 100%;
                        object-fit: cover;
                    }
                }
            }
        }
        &--thumbs {
            width: 100%;
            height: fit-content;
            margin-top: rem(8);
            &-slide {
                max-width: rem(80);
                aspect-ratio: 1;
                border-radius: rem(16);
                overflow: hidden;
                margin-right: rem(8);
                &-image {
                    width: 100%;
                    height: 100%;
                    img {
                        width: 100%;
                        height: 100%;
                        object-fit: cover;
                    }
                }
            }
        }
    }
</style>
