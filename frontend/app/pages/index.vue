<template>
    <NuxtLayout>
        <template v-if="page">
            <HomeHero :slides="page?.hero_slides" />
            <HomeCarousel
                v-for="carousel in page?.carousels"
                :key="carousel.id"
                :title="carousel.home_carousels_id.title"
                :category="slugify(carousel.home_carousels_id.category.name)"
                :content-ref="
                    computed(
                        () =>
                            productsList?.filter((element) =>
                                element.category?.some(
                                    (el) =>
                                        el.categories_id?.name?.trim().toLowerCase() ==
                                        carousel.home_carousels_id.category.name
                                            .trim()
                                            .toLowerCase()
                                )
                            ) ?? null
                    )
                "
                :status-ref="ref(productsStatus)"
                :wtith-link="carousel.home_carousels_id.link"
                :autoplay="carousel.home_carousels_id.autoplay"
            />
            <HomeBanner
                :image-url="page?.banner_image_url"
                :title="page?.banner_title ?? ''"
                :subtitle="page?.banner_subtitle ?? ''"
                :description="page?.banner_text ?? ''"
                :button-text="page?.banner_button_text ?? 'Подписаться на цветы'"
            />
            <HomeAdvant :title="page?.advant_title" :content-list="page?.advant_blocks ?? []" />
            <HomeFeedback :title="page?.feedback_title" :subtitle="page?.feedback_subtitle" />
            <HomeMap />
        </template>
    </NuxtLayout>
</template>

<script setup lang="ts">
    // types ===============================================
    interface IHomePage {
        id: number | string;
        date_updated: string;
        hero_slides: {
            id: number | string;
            home_id: any;
            home_slider_id: {
                id: number | string;
                title: string;
                content: string;
                image: string;
                image_url: string;
            };
        }[];
        carousels: {
            id: number | string;
            home_id: any;
            home_carousels_id: {
                id: number | string;
                date_created: string;
                date_updated: string;
                title: string;
                autoplay: boolean;
                link: boolean;
                sort: number;
                category: {
                    id: number | string;
                    name: string;
                    image?: string | null;
                    image_url?: string;
                    available: boolean;
                    sort: number;
                };
            };
        }[];
        banner_image: string;
        banner_image_url: string;
        banner_title: string;
        banner_subtitle: string;
        banner_text: string;
        banner_button_text: string;
        advant_title: string;
        advant_blocks: {
            id: number | string;
            home_id: any;
            home_advant_id: {
                id: number | string;

                image: string;
                image_url: string;

                description?: string;
                title?: string;

                button_text?: string;
                button_link?: string;

                figure_caption?: string;
                figure_image?: string;
                figure_image_url?: string;

                gallery_image_1?: string;
                gallery_image_1_url?: string;
                gallery_image_2?: string;
                gallery_image_2_url?: string;
                gallery_image_3?: string;
                gallery_image_3_url?: string;
            };
        }[];
        feedback_title: string;
        feedback_subtitle?: string;
    }

    // data ================================================
    const productsStore = useProductsStore();

    const { productsList, productsStatus } = storeToRefs(productsStore);

    const { content: page } = useCms<IHomePage>('home', [
        'hero_slides.*',
        'hero_slides.home_slider_id.*',
        'carousels.*',
        'carousels.home_carousels_id.*',
        'carousels.home_carousels_id.category.*',
        'advant_blocks.*',
        'advant_blocks.home_advant_id.*',
    ]);
    //======================================================
</script>
