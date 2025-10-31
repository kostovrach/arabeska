<template>
    <section class="home-advant">
        <div class="home-advant__container">
            <StarsOverlay v-if="props.title.length" class="home-advant__title">
                <h2>{{ props.title }}</h2>
            </StarsOverlay>
            <ul class="home-advant__list">
                <li v-for="(item, idx) in props.contentList" :key="idx" class="home-advant__item">
                    <div class="home-advant__item-wrapper">
                        <picture class="home-advant__item-image-container">
                            <img
                                class="home-advant__item-image"
                                :src="item.home_advant_id.image_url"
                                :alt="item.home_advant_id.title ?? '#'"
                            />
                        </picture>
                        <div class="home-advant__item-content">
                            <h3 class="home-advant__item-title" v-if="item.home_advant_id.title">
                                {{ item.home_advant_id.title }}
                            </h3>
                            <ClientOnly>
                                <p
                                    class="home-advant__item-desc"
                                    v-if="item.home_advant_id.description"
                                    v-html="item.home_advant_id.description"
                                ></p>
                            </ClientOnly>
                            <NuxtLink
                                v-if="
                                    item.home_advant_id.button_text &&
                                    item.home_advant_id.button_link
                                "
                                class="home-advant__item-button"
                                :to="{ name: item.home_advant_id.button_link }"
                            >
                                <span>{{ item.home_advant_id.button_text }}</span>
                                <span><SvgSprite type="arrow" /></span>
                            </NuxtLink>
                            <figure
                                v-if="item.home_advant_id.figure_image_url"
                                class="home-advant__item-composition"
                            >
                                <img :src="item.home_advant_id.figure_image_url" alt="#" />
                                <figcaption>
                                    Непревзойденно-высокое качество свечей, подсвечников и
                                    упаковочной продукции подарит незабываемые впечатления каждому,
                                    получившему такой презент
                                </figcaption>
                            </figure>
                            <div
                                v-if="
                                    item.home_advant_id.gallery_image_1_url ||
                                    item.home_advant_id.gallery_image_2_url ||
                                    item.home_advant_id.gallery_image_3_url
                                "
                                class="home-advant__item-gallery"
                            >
                                <picture
                                    v-show="item.home_advant_id.gallery_image_1_url"
                                    class="home-advant__item-gallery-image-container"
                                >
                                    <img
                                        class="home-advant__item-gallery-image"
                                        :src="item.home_advant_id.gallery_image_1_url"
                                        alt="#"
                                    />
                                </picture>
                                <picture
                                    v-show="item.home_advant_id.gallery_image_2_url"
                                    class="home-advant__item-gallery-image-container"
                                >
                                    <img
                                        class="home-advant__item-gallery-image"
                                        :src="item.home_advant_id.gallery_image_2_url"
                                        alt="#"
                                    />
                                </picture>
                                <picture
                                    v-show="item.home_advant_id.gallery_image_3_url"
                                    class="home-advant__item-gallery-image-container"
                                >
                                    <img
                                        class="home-advant__item-gallery-image"
                                        :src="item.home_advant_id.gallery_image_3_url"
                                        alt="#"
                                    />
                                </picture>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </section>
</template>

<script setup lang="ts">
    interface ContentList {
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
    }

    const props = withDefaults(
        defineProps<{
            title?: string;
            contentList: ContentList[];
        }>(),
        {
            title: '',
            contentList: () => [],
        }
    );
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .home-advant {
        $p: &;

        @include content-block;
        &__container {
            display: flex;
            flex-direction: column;
            gap: rem(64);
            @include content-container;
        }
        &__title {
            width: fit-content;
            align-self: center;
            font-size: lineScale(64, 32, 480, 1440);
            font-weight: $fw-semi;
            text-align: center;
        }
        &__list {
            display: flex;
            flex-direction: column;
            gap: rem(32);
        }
        &__item {
            &:nth-child(odd) {
                #{$p}__item-wrapper {
                    grid-template-areas: 'image content';
                }
            }
            &:nth-child(even) {
                #{$p}__item-wrapper {
                    grid-template-areas: 'content image';
                }
            }
            &-wrapper {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                align-items: center;
                gap: rem(32);
            }
            &-image-container {
                grid-area: image;
                width: 100%;
                height: 100%;
                max-height: rem(720);
                border-radius: rem(64);
                overflow: hidden;
                img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }
            }
            &-content {
                grid-area: content;
                display: flex;
                flex-direction: column;
                padding: lineScale(64, 16, 480, 1440);
                &--centered {
                    align-items: center;
                    text-align: center;
                }
            }
            &-title {
                font-size: lineScale(32, 24, 480, 1440);
            }
            &-desc {
                font-size: lineScale(18, 16, 480, 1440);
                line-height: 1.4;
                margin-top: rem(32);
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
            &-button {
                margin-top: rem(48);
                @include button-primary(
                    $border-color: $c-98BBD7,
                    $padding: rem(18) lineScale(48, 32, 480, 1440),
                    $anim-color: $c-accent
                );
            }
            &-composition {
                text-align: center;
                margin-top: lineScale(96, 64, 480, 1440);
                img {
                    width: 100%;
                    max-height: rem(220);
                    object-fit: cover;
                }
                figcaption {
                    margin-top: rem(16);
                    opacity: 0.5;
                }
            }
            &-gallery {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                grid-template-areas: 'image-1 . image-2 image-3';
                gap: rem(16);
                margin-top: lineScale(64, 32, 480, 1440);
                &-image-container {
                    width: 100%;
                    aspect-ratio: 1;
                    &:nth-child(1) {
                        grid-area: image-1;
                    }
                    &:nth-child(2) {
                        grid-area: image-2;
                    }
                    &:nth-child(3) {
                        grid-area: image-3;
                    }
                    img {
                        width: 100%;
                        height: 100%;
                        object-fit: cover;
                    }
                }
            }
        }
    }

    @media (max-width: 1024px) {
        .home-advant {
            &__list {
                gap: rem(96);
            }
            &__item {
                &-wrapper {
                    display: flex;
                    flex-direction: column;
                }
                &-content {
                    padding: 0;
                }
                &-image-container {
                    width: 100%;
                    height: rem(320);
                }
            }
        }
    }
</style>
