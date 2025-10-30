<template>
    <Lightbox>
        <EmblaContainer ref="mainRef" class="slider slider--main" :options="mainCarouselOptions">
            <EmblaSlide
                v-for="(slide, idx) in props.product?.images"
                :key="idx"
                class="slider--main-slide"
            >
                <a
                    class="slider--main-slide-wrapper"
                    :data-fancybox="product?.title"
                    :href="`${cmsUrl}/assets/${slide.directus_files_id.id}`"
                >
                    <picture class="slider--main-slide-image">
                        <img
                            :src="`${cmsUrl}/assets/${slide.directus_files_id.id}`"
                            :alt="`Фото ${idx + 1}`"
                        />
                    </picture>
                </a>
            </EmblaSlide>
        </EmblaContainer>
    </Lightbox>
    <EmblaContainer
        v-if="props.product?.images.length && props.product?.images.length > 1"
        ref="thumbsRef"
        class="slider slider--thumbs"
        :options="thumbsCarouselOptions"
    >
        <EmblaSlide
            v-for="(slide, idx) in props.product?.images"
            :key="idx"
            class="slider--thumbs-slide"
            :class="{ 'slider--thumbs-slide--active': activeIndex === idx }"
            @click="onThumbClick(idx)"
        >
            <picture class="slider--thumbs-slide-image">
                <img
                    :src="`${cmsUrl}/assets/${slide.directus_files_id.id}`"
                    :alt="`Фото ${idx + 1}`"
                />
            </picture>
        </EmblaSlide>
    </EmblaContainer>
</template>

<script setup lang="ts">
    // types ================================================================
    import type { IProduct } from '~~/interfaces/product';
    import type { EmblaCarouselType, EmblaOptionsType } from 'embla-carousel';

    const props = defineProps<{
        product: IProduct | null;
    }>();

    const cmsUrl = useRuntimeConfig().public.apiBase;

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

    // logic =======================================================
    watchEffect((onCleanup) => {
        const main = mainRef.value?.emblaApi;
        const thumbs = thumbsRef.value?.emblaApi;

        if (!main || !thumbs) return;

        const updateActive = () => {
            activeIndex.value = main.selectedScrollSnap();
        };
        main.on('select', updateActive);

        updateActive();

        onCleanup(() => {
            main.off('select', updateActive);
        });
    });

    // methods =====================================================
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
                cursor: pointer;
                max-width: lineScale(80, 56, 480, 1440);
                aspect-ratio: 1;
                border-radius: rem(16);
                overflow: hidden;
                margin-right: rem(8);
                &--active {
                    opacity: 0.6;
                }
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
