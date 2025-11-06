<template>
    <NuxtLayout>
        <section class="contact">
            <div class="contact__container">
                <div class="contact__item">
                    <div class="contact__item-content">
                        <h1 class="contact__title">{{ page?.title ?? 'Адреса магазинов' }}</h1>
                        <ul class="contact__addresses">
                            <li
                                v-for="(item, idx) in page?.addresses"
                                :key="idx"
                                class="contact__addresses-item"
                            >
                                <span class="contact__addresses-item-icon">
                                    <SvgSprite type="globe" :size="32" />
                                </span>
                                <div class="contact__addresses-item-content">
                                    <h3 class="contact__addresses-item-title">
                                        {{ item.full_address }}
                                    </h3>
                                    <p class="contact__addresses-item-desc" v-if="item.description">
                                        {{ item.description }}
                                    </p>
                                    <span class="contact__addresses-item-footnote">
                                        {{ item.working_hours }}
                                    </span>
                                    <div class="contact__addresses-item-tel" v-if="item.phone">
                                        Телефон:
                                        <a :href="`tel:${item.phone.trim().split(' ').join('')}`">
                                            {{ item.phone }}
                                        </a>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div class="contact__item-sider">
                        <div class="contact__item-sider-wrapper">
                            <div class="contact__map">
                                <MapWrapper />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="contact__item">
                    <div class="contact__item-content">
                        <ul class="contact__info">
                            <li
                                v-for="(item, idx) in page?.info_blocks"
                                :key="idx"
                                class="contact__info-item"
                            >
                                <span class="contact__info-item-title">{{ item.title }}</span>
                                <div class="contact__info-item-content" v-html="item.content"></div>
                            </li>
                            <li class="contact__info-item">
                                <span class="contact__info-item-title">
                                    Следите за нами в соцсетях
                                </span>
                                <div class="contact__info-item-socials">
                                    <ClientOnly>
                                        <a
                                            v-for="(link, idx) in socialsLinks.filter(
                                                (el) => el.link.length
                                            )"
                                            :key="idx"
                                            class="contact__info-item-socials-link"
                                            :href="link.link"
                                            target="_blank"
                                            rel="noopener noreferrer"
                                            :style="`--mask: url('${link.maskPath}'); --anim-color: ${link.hoverColor}`"
                                        ></a>
                                    </ClientOnly>
                                </div>
                            </li>
                            <li class="contact__info-item">
                                <span class="contact__info-item-title">
                                    Для вопросов и предложений
                                </span>
                                <a
                                    class="contact__info-item-link"
                                    :href="`mailto:${page?.mail.trim()}`"
                                >
                                    {{ page?.mail }}
                                </a>
                            </li>
                            <li class="contact__info-item">
                                <span class="contact__info-item-title">Единый номер</span>
                                <a
                                    class="contact__info-item-link contact__info-item-link--large"
                                    :href="`tel:${page?.phone.trim().split(' ').join('')}`"
                                >
                                    {{ page?.phone }}
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div class="contact__item-sider">
                        <div class="contact__item-sider-wrapper">
                            <div class="contact__decorative">
                                <StarsOverlay
                                    class="contact__decorative-title"
                                    v-if="page?.info_title"
                                >
                                    <h2>{{ page?.info_title }}</h2>
                                </StarsOverlay>
                                <picture class="contact__decorative-image-container">
                                    <img
                                        class="contact__decorative-image"
                                        :src="page?.info_image_url ?? '/img/service/flowers.jpg'"
                                        alt="decorative"
                                    />
                                </picture>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <Banner
            v-if="page?.banner_image_url"
            class="contact__banner"
            :title="page.banner_title ?? ''"
            :image-url="page.banner_image_url"
        >
            <p class="contact__banner-content" v-if="page.banner_content">
                {{ page.banner_content }}
            </p>

            <SubscribeForm v-if="page.banner_form_enabled" />
        </Banner>
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { IContacts } from '~~/interfaces/contacts';

    interface ISocialsLink {
        maskPath: string;
        link: string;
        hoverColor: string;
    }

    const { content: page } = useCms<IContacts>('contact');

    const socialsLinks: ISocialsLink[] = [
        {
            maskPath: '/img/masks/vk.svg',
            link: page.value?.vk ?? '',
            hoverColor: '#016FCC',
        },
        {
            maskPath: '/img/masks/telegram.svg',
            link: page.value?.telegram ?? '',
            hoverColor: '#03A4DF',
        },
        {
            maskPath: '/img/masks/ok.svg',
            link: page.value?.ok ?? '',
            hoverColor: '#FF7700',
        },
        {
            maskPath: '/img/masks/instagram.svg',
            link: page.value?.instagram ?? '',
            hoverColor:
                'linear-gradient(45deg, #feda75 0%, #fa7e1e 25%, #d62976 50%, #962fbf 75%, #4f5bd5 100%)',
        },
    ];

    // SEO & Meta ============================================================
    useHead({
        title: 'Контакты | Арабеска - магазин цветов в Самаре',
        meta: [
            {
                name: 'description',
                content:
                    'Магазин цветов в Самаре Арабеска: адрес, телефон и режим работы. Доставка свежих цветов по Самаре и области.',
            },
            {},
        ],
    });
    // =======================================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .contact {
        $p: &;

        @include content-block($margin: rem(64));
        &__container {
            display: flex;
            flex-direction: column;
            gap: rem(128);
            @include content-container($max-width: rem(1440));
        }
        &__item {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: lineScale(64, 32, 480, 1440);
            &:nth-child(odd) {
                grid-template-areas: 'content sider';
            }
            &:nth-child(even) {
                grid-template-areas: 'sider content';
            }
            &-content {
                grid-area: content;
            }
            &-sider {
                grid-area: sider;
            }
            &-sider {
                height: 100%;
                position: relative;
                &-wrapper {
                    position: sticky;
                    top: rem(136);
                }
            }
        }
        &__title {
            font-size: lineScale(64, 48, 480, 1440);
            font-weight: $fw-semi;
        }
        &__addresses {
            display: flex;
            flex-direction: column;
            gap: lineScale(32, 16, 480, 1440);
            margin-top: rem(64);
            &-item {
                display: flex;
                align-items: flex-start;
                gap: rem(16);
                &-icon {
                    color: $c-accent;
                }
                &-content {
                    display: flex;
                    flex-direction: column;
                    gap: rem(8);
                }
                &-tel {
                    font-family: 'Inter', sans-serif;
                    font-size: lineScale(16, 16, 480, 1440);
                    > a {
                        color: $c-accent;
                        text-decoration: underline;
                        @media (pointer: fine) {
                            &:hover {
                                text-decoration: none;
                            }
                        }
                    }
                }
                &-title {
                    font-size: lineScale(22, 18, 480, 1440);
                    font-weight: $fw-semi;
                }
                &-footnote {
                    opacity: 0.5;
                }
            }
        }
        &__map {
            width: 100%;
            aspect-ratio: 1.5/1;
            border-radius: rem(32);
            overflow: hidden;
        }
        &__info {
            display: flex;
            flex-direction: column;
            gap: lineScale(64, 32, 480, 1440);
            &-item {
                display: flex;
                flex-direction: column;
                gap: rem(16);
                &-title {
                    font-family: 'Inter', sans-serif;
                    font-size: lineScale(16, 14, 480, 1440);
                    font-weight: $fw-semi;
                    opacity: 0.5;
                }
                &-text,
                &-link {
                    font-size: lineScale(22, 18, 480, 1440);
                    font-weight: $fw-semi;
                }
                &-content {
                    display: flex;
                    flex-direction: column;
                    gap: rem(8);
                    font-size: lineScale(20, 18, 480, 1440);
                    font-weight: $fw-semi;
                    line-height: 1.6;
                    h2,
                    h3,
                    h4,
                    h5,
                    h6 {
                        font-size: lineScale(24, 18, 480, 1440);
                        margin-bottom: rem(16);
                        font-weight: $fw-bold;
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
                &-list {
                    display: flex;
                    flex-direction: column;
                    gap: rem(8);
                }
                &-socials {
                    display: flex;
                    align-items: center;
                    &-link {
                        display: block;
                        width: rem(40);
                        aspect-ratio: 1;
                        mask-image: var(--mask);
                        mask-size: 100%;
                        mask-repeat: no-repeat;
                        background: $c-accent;
                        @media (pointer: fine) {
                            &:hover {
                                background: var(--anim-color);
                                &:nth-of-type(2n + 1) {
                                    rotate: 5.6deg;
                                }
                                &:nth-of-type(2n + 2) {
                                    rotate: -9deg;
                                }
                            }
                        }
                    }
                }
                &-link {
                    width: fit-content;
                    font-family: 'Inter', sans-serif;
                    white-space: nowrap;
                    @include hover-blick-line;
                    &--large {
                        font-size: lineScale(64, 24, 480, 1440);
                    }
                }
            }
        }
        &__decorative {
            &-title {
                font-size: lineScale(48, 24, 480, 1440);
                font-weight: $fw-semi;
                margin-right: rem(32);
            }
            &-image-container {
                width: rem(230);
                aspect-ratio: 1/1.2;
                rotate: -6.5deg;
                margin-top: rem(64);
            }
            &-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
        }
        &__banner {
            &-content {
                font-size: lineScale(18, 16, 480, 1440);
                line-height: 1.4;
            }
        }
    }

    @media (max-width: 1024px) {
        .contact {
            &__item {
                display: flex;
                flex-direction: column;
            }
            &__map {
                height: rem(320);
            }
            &__decorative {
                display: flex;
                flex-direction: column;
                align-items: center;
                margin-top: rem(64);
                &-title {
                    text-align: center;
                }
            }
        }
    }
</style>
