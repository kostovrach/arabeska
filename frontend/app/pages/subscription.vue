<template>
    <NuxtLayout>
        <SubscriptionHero
            :image-url="page?.hero_image_url ?? ''"
            :tag="page?.hero_tag"
            :description="page?.hero_description"
            :title="page?.hero_title ?? ''"
            :info-tags="page?.hero_info"
            :button-text="page?.hero_button_text ?? 'Выбрать тариф'"
        />
        <SubscriptionPricing
            :title="page?.pricing_title ?? 'Тарифы'"
            :description="page?.pricing_description"
        />
        <AccordionSection
            :title="page?.faq_title ?? ''"
            :description="page?.faq_description"
            :content="page?.faq_blocks"
        />
        <Banner
            v-if="page?.banner_image_url"
            class="subscription-banner"
            :title="page.banner_title"
            :image-url="page.banner_image_url"
        >
            <div class="subscription-banner__content">
                <ClientOnly>
                    <p
                        class="subscription-banner__text"
                        v-if="page.banner_content"
                        v-html="page.banner_content"
                    ></p>
                </ClientOnly>
                <div class="subscription-banner__links" v-if="page.banner_buttons?.length">
                    <a
                        v-for="(button, idx) in page.banner_buttons"
                        :key="idx"
                        class="subscription-banner__link"
                        :href="button.link"
                        target="_blank"
                        rel="noopener noreferrer"
                    >
                        <span>{{ button.title }}</span>
                        <span><SvgSprite type="arrow" :size="24" /></span>
                    </a>
                </div>
            </div>
        </Banner>
    </NuxtLayout>
</template>

<script setup lang="ts">
    // types ======================================================
    interface ISubscriptionPage {
        id: number | string;
        date_created: string;
        date_updated?: string;

        hero_image: string;
        hero_image_url: string;
        hero_tag?: string;
        hero_title: string;
        hero_description?: string;
        hero_info?: string[];
        hero_button_text?: string;

        pricing_title?: string;
        pricing_description?: string;

        faq_title: string;
        faq_description?: string;
        faq_blocks?: {
            title: string;
            content: string;
        }[];

        banner_image: string;
        banner_image_url: string;
        banner_title: string;
        banner_content?: string;
        banner_buttons?: {
            title: string;
            link: string;
        }[];
    }
    // ============================================================

    // data =======================================================
    const { content: page } = useCms<ISubscriptionPage>('subscription');
    // ============================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .subscription-banner {
        &__content {
            display: flex;
            flex-direction: column;
            gap: rem(32);
        }
        &__links {
            display: flex;
            flex-wrap: wrap;
            gap: rem(16);
        }
        &__link {
            @include button-primary($anim-color: $c-accent, $gap: rem(16));
        }
    }
</style>
