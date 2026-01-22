<template>
    <NuxtLayout>
        <InfoHero
            class="franchise-hero"
            :image-url="page?.hero_image_url ?? ''"
            :tag="page?.hero_tag ?? ''"
            :title="page?.hero_title ?? ''"
            :desc="page?.hero_description ?? ''"
        >
            <template #button>
                <a class="franchise-hero__button" href="#about">
                    <span>{{ page?.hero_button_text ?? 'О франшизе' }}</span>
                    <span><SvgSprite type="arrow" :size="24" /></span>
                </a>
            </template>
        </InfoHero>
        <div class="franchise">
            <PFranchiseAbout
                :title="page?.advant_title ?? ''"
                :description="page?.advant_description"
                :metrics="
                    page?.advant_metrics?.map((el) => ({
                        label: el.description,
                        value: el.value,
                    })) ?? []
                "
            />
            <PFranchiseList
                :content="
                    page?.advant_info.map((el) => ({
                        imageUrl: el.franchise_advant_id.image_url,
                        title: el.franchise_advant_id.title,
                        body: el.franchise_advant_id.content,
                    })) ?? []
                "
            />
            <AccordionSection
                :title="page?.faq_title ?? ''"
                :description="page?.faq_description"
                :content="page?.faq_blocks"
            />
            <PFranchiseFeedback
                v-if="page?.feedback_available"
                :title="page?.feedback_title ?? ''"
                :description="page?.feedback_description ?? ''"
            />
            <Banner
                v-if="page?.banner_image_url"
                class="franchise-banner"
                :title="page.banner_title ?? ''"
                :image-url="page.banner_image_url"
            >
                <div class="franchise-banner__content">
                    <ClientOnly>
                        <div
                            class="franchise-banner__text"
                            v-if="page.banner_content"
                            v-html="page.banner_content"
                        ></div>
                    </ClientOnly>
                    <a
                        v-for="(button, idx) in page.banner_buttons"
                        :key="idx"
                        class="franchise-banner__button"
                        :href="button.link"
                        type="button"
                        target="_blank"
                        rel="noopener noreferrer"
                    >
                        <span>{{ button.title }}</span>
                        <span><SvgSprite type="arrow" :size="24" /></span>
                    </a>
                </div>
            </Banner>
        </div>
    </NuxtLayout>
</template>

<script setup lang="ts">
    // types ===========================================================
    interface IFranchisePage {
        id: number | string;
        date_created: string;
        date_updated?: string;

        hero_image: string;
        hero_image_url: string;
        hero_title: string;
        hero_tag?: string;
        hero_description?: string;
        hero_button_text?: string;

        advant_title: string;
        advant_description?: string;
        advant_metrics?: {
            value: string;
            description: string;
        }[];
        advant_info: {
            id: number | string;
            franchise_id: any;
            franchise_advant_id: {
                id: number | string;
                image: string;
                image_url: string;
                title: string;
                content: string;
            };
        }[];

        faq_title: string;
        faq_description?: string;
        faq_blocks?: {
            title: string;
            content: string;
        }[];

        feedback_available: boolean;
        feedback_title: string;
        feedback_description?: string;

        banner_image?: string;
        banner_image_url?: string;
        banner_title?: string;
        banner_content?: string;
        banner_buttons?: {
            title: string;
            link: string;
        }[];
    }
    // =================================================================

    // data ============================================================
    const { content: page } = await useCms<IFranchisePage>('franchise', [
        'advant_info.*',
        'advant_info.franchise_advant_id.*',
    ]);
    // =================================================================
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .franchise {
        background-color: $c-main;
    }
    .franchise-hero {
        &__button {
            margin-top: rem(64);
            @include button-primary($anim-color: $c-accent, $gap: rem(16));
            > span:has(svg) {
                rotate: 90deg;
            }
        }
    }
    .franchise-banner {
        &__content {
            display: flex;
            flex-direction: column;
            gap: rem(32);
        }
        &__text {
            display: flex;
            flex-direction: column;
            gap: rem(16);
            line-height: 1.6;
            h2,
            h3,
            h4,
            h5,
            h6 {
                font-size: lineScale(24, 18, 480, 1440);
                margin-bottom: rem(16);
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
        &__button {
            @include button-primary($anim-color: $c-accent, $gap: rem(16));
        }
    }
</style>
