<template>
    <NuxtLayout>
        <div class="faq">
            <div class="faq__header">
                <picture class="faq__header-image-container">
                    <img
                        class="faq__header-image"
                        :src="page?.head_image_url ?? '/img/service/flowers.jpg'"
                        alt="#"
                    />
                </picture>
            </div>
            <div class="faq__container">
                <div class="faq__wrapper">
                    <article class="faq__body">
                        <aside class="faq__sider">
                            <nav class="faq__nav">
                                <a
                                    class="faq__nav-link"
                                    :href="`#${slugify(page?.delivery_title ?? '') ?? '#delivery-rules'}`"
                                >
                                    <span>{{ page?.delivery_title ?? 'Доставка' }}</span>
                                </a>
                                <a
                                    v-for="(link, idx) in page?.additional_blocks"
                                    :key="idx"
                                    class="faq__nav-link"
                                    :href="`#${slugify(link.title) ?? '#'}`"
                                >
                                    <span>{{ link.title }}</span>
                                </a>
                            </nav>
                        </aside>
                        <div class="faq__content">
                            <PFaqDelivery
                                :id="slugify(page?.delivery_title ?? '') ?? 'delivery-rules'"
                                class="faq__section"
                                :title="page?.delivery_title ?? ''"
                                :content="page?.delivery_content ?? ''"
                                :info-blocks="page?.delivery_additional ?? []"
                                :map-footnote="page?.delivery_footnote ?? ''"
                                :advant-title="page?.delivery_advant_title ?? ''"
                                :advant-subtitle="page?.delivery_advant_subtitle ?? ''"
                                :advant-cards="page?.delivery_advant_cards ?? []"
                            />
                            <PFaqTypeSection
                                v-for="(section, idx) in page?.additional_blocks"
                                :key="idx"
                                :id="slugify(section.title)"
                                class="faq__section"
                                :title="section.title"
                                :content="section.content"
                            />
                            <BlockFaq
                                v-if="page?.accordion_blocks.length"
                                class="faq__section"
                                :title="page?.accordion_title ?? 'Популярные вопросы'"
                                :description="page?.accordion_description"
                                :content="page?.accordion_blocks"
                                vertical
                            />
                        </div>
                    </article>
                </div>
            </div>
        </div>
    </NuxtLayout>
</template>

<script setup lang="ts">
    // types =========================================================
    interface IFaqPage {
        id: number | string;
        head_image: string;
        head_image_url: string;

        delivery_title: string;
        delivery_content: string;
        delivery_additional: {
            title: string;
            content: string;
        }[];
        delivery_footnote: string;
        delivery_advant_title: string;
        delivery_advant_subtitle: string;
        delivery_advant_cards: {
            title: string;
            content: string;
        }[];

        additional_blocks: {
            title: string;
            content: string;
        }[];

        accordion_title: string;
        accordion_description: string;
        accordion_blocks: {
            title: string;
            content: string;
        }[];
    }
    // ===============================================================

    // data ==========================================================
    const { content: page } = await useCms<IFaqPage>('faq');
    // ===============================================================
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .faq {
        $p: &;

        &__header {
            $cover-height: lineScale(240, 160, 480, 1440);

            height: $cover-height;
            &-image-container {
                position: fixed;
                z-index: -1;
                top: 0;
                width: 100%;
                height: calc($cover-height + rem(128));
            }
            &-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
        }
        &__container {
            background-color: $c-main;
        }
        &__wrapper {
            @include content-container;
        }
        &__body {
            display: grid;
            grid-template-columns: 30% auto;
            gap: lineScale(64, 32, 480, 1440);
            padding: lineScale(64, 32, 480, 1440) 0;
        }
        &__sider {
            position: relative;
            height: 100%;
        }
        &__nav {
            position: sticky;
            top: rem(128);
            display: flex;
            flex-direction: column;
            border-radius: rem(32);
            box-shadow: 1px 1px 5px rgba($c-D4E1E7, 0.7);
            &-link {
                font-size: lineScale(22, 18, 480, 1440);
                @include frame-scale($padding: rem(18) rem(32), $border-radius: rem(32));
            }
        }
        &__content {
            display: flex;
            flex-direction: column;
            gap: rem(64);
        }
        &__section {
            display: flex;
            flex-direction: column;
            gap: rem(64);
            border: rem(1) solid $c-D4E1E7;
            font-family: 'Inter', sans-serif;
            border-radius: rem(32);
            padding: rem(32);
            scroll-margin: rem(128);
        }
    }

    @media (max-width: 1024px) {
        .faq {
            &__sider {
                display: none;
            }
            &__body {
                grid-template-columns: 100%;
            }
        }
    }

    @media (max-width: 768px) {
        .faq {
            &__section {
                padding: 0;
                border: initial;
            }
        }
    }
</style>
