<template>
    <NuxtLayout>
        <template v-if="page">
            <InfoHero
                class="wholesale-hero"
                :image-url="page.image_url ?? ''"
                :tag="page.tag ?? ''"
                :title="page.title ?? ''"
                :desc="page.description"
            >
                <template #button>
                    <button class="wholesale-hero__button" type="button">
                        <span>Подать заявку</span>
                        <span><SvgSprite type="arrow" :size="24" /></span>
                    </button>
                </template>
            </InfoHero>
            <div class="wholesale">
                <section class="wholesale-list">
                    <ul class="wholesale-list__container">
                        <li
                            v-for="(item, idx) in page.advant"
                            :key="idx"
                            class="wholesale-list__item"
                        >
                            <picture class="wholesale-list__item-image-container">
                                <img
                                    class="wholesale-list__item-image"
                                    :src="item?.wholesale_advant_id?.image_url"
                                    :alt="`${idx}`"
                                />
                            </picture>
                            <div
                                class="wholesale-list__item-content"
                                v-html="item.wholesale_advant_id?.content"
                            ></div>
                        </li>
                    </ul>
                </section>
                <AccordionSection
                    :title="page.faq_title ?? ''"
                    :description="page.faq_description"
                    :content="page.faq_blocks"
                />
                <Banner
                    v-if="page.banner_image_url"
                    class="wholesale-banner"
                    :title="page.banner_title ?? ''"
                    :image-url="page.banner_image_url"
                >
                    <div class="wholesale-banner__content">
                        <ClientOnly>
                            <div class="wholesale-banner__text" v-html="page.banner_content"></div>
                        </ClientOnly>
                        <button class="wholesale-banner__button" type="button">
                            <span>Подать заявку</span>
                            <span><SvgSprite type="arrow" :size="24" /></span>
                        </button>
                    </div>
                </Banner>
            </div>
        </template>
    </NuxtLayout>
</template>

<script setup lang="ts">
    // types ===================================================================
    interface IWholesalePage {
        id: number | string;
        tag?: string;
        title?: string;
        description?: string;
        image?: string;
        image_url?: string;
        advant?: {
            id?: number | string;
            wholesale_id?: string;
            wholesale_advant_id?: {
                id?: number | string;
                content?: string;
                image?: string;
                image_url?: string;
            };
        }[];
        faq_title?: string;
        faq_description?: string;
        faq_blocks?: {
            title?: string;
            content?: string;
        }[];
        banner_title?: string;
        banner_content?: string;
        banner_image?: string;
        banner_image_url?: string;
    }
    // =========================================================================

    const { content: page, status } = useCms<IWholesalePage>('wholesale', [
        'advant.*',
        'advant.wholesale_advant_id.*',
    ]);
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .wholesale {
        background-color: $c-main;
    }
    .wholesale-hero {
        &__button {
            margin-top: rem(32);
            @include button-primary($anim-color: $c-accent, $gap: rem(16));
        }
    }
    .wholesale-list {
        padding: rem(64) 0;
        &__container {
            display: flex;
            flex-direction: column;
            gap: rem(32);
            @include content-container;
        }
        &__item {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            align-items: center;
            gap: rem(32);
            &:nth-child(odd) {
                grid-template-areas: 'image content';
            }
            &:nth-child(even) {
                grid-template-areas: 'content image';
            }
            &-image-container {
                grid-area: image;
                width: 100%;
                aspect-ratio: 1.3/1;
                border-radius: rem(32);
                overflow: hidden;
            }
            &-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            &-content {
                grid-area: content;
                display: flex;
                flex-direction: column;
                gap: rem(16);
                font-family: 'Inter', sans-serif;
                font-size: lineScale(18, 16, 480, 1440);
                line-height: 1.3;
                padding: rem(32);
                h2,
                h3,
                h4,
                h5,
                h6 {
                    font-size: lineScale(32, 24, 480, 1440);
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
        }
    }
    .wholesale-banner {
        &__content {
            display: flex;
            flex-direction: column;
            gap: rem(32);
        }
        &__text {
            display: flex;
            flex-direction: column;
            gap: rem(8);
            line-height: 1.4;
            font-size: lineScale(18, 16, 480, 1440);
            h2,
            h3,
            h4,
            h5,
            h6 {
                font-size: lineScale(32, 24, 480, 1440);
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
            @include button-primary($anim-color: $c-accent);
        }
    }

    @media (max-width: 1024px) {
        .wholesale-list {
            &__container {
                gap: rem(64);
            }
            &__item {
                display: flex;
                flex-direction: column;
                &-image-container {
                    aspect-ratio: auto;
                    height: rem(320);
                }
                &-content {
                    padding: 0;
                }
            }
        }
    }
</style>
