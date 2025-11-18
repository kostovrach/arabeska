<template>
    <NuxtLayout>
        <FeedbackHero
            :title="page?.hero_title ?? ''"
            :subtitle="page?.hero_subtitle"
            :image-url="page?.hero_image_url ?? ''"
        />
        <FeedbackList />
        <Banner
            v-if="page?.banner_image_url"
            class="feedback-banner"
            :title="page?.banner_title ?? ''"
            :image-url="page.banner_image_url"
        >
            <div class="feedback-banner__content">
                <p class="feedback-banner__text" v-if="page?.banner_subtitle">
                    {{ page?.banner_subtitle }}
                </p>
                <div class="feedback-banner__links" v-if="page.banner_buttons.length">
                    <a
                        v-for="(button, idx) in page.banner_buttons"
                        :key="idx"
                        class="feedback-banner__link"
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
    // types ==============================================
    interface IFeedbackPage {
        id: number | string;
        hero_title: string;
        hero_subtitle: string;
        hero_image: string;
        hero_image_url: string;

        banner_title: string;
        banner_subtitle: string;
        banner_buttons: {
            title: string;
            link: string;
        }[];
        banner_image: string;
        banner_image_url: string;
    }
    // ====================================================

    // data ===============================================
    const { content: page } = useCms<IFeedbackPage>('feedback_page');
    // ====================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .feedback-banner {
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
            @include button-primary(
                $anim-color: $c-accent,
                $gap: rem(16),
                $font-size: lineScale(18, 16, 480, 1440)
            );
        }
    }
</style>
