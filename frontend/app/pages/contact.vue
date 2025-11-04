<template>
    <NuxtLayout>
        <section class="contact">
            <div class="contact__container">
                <div class="contact__item">
                    <div class="contact__item-content">
                        <h1 class="contact__title">Адреса магазинов</h1>
                        <ul class="contact__addresses">
                            <li
                                v-for="(item, idx) in addresses"
                                :key="idx"
                                class="contact__addresses-item"
                            >
                                <span class="contact__addresses-item-icon">
                                    <SvgSprite type="globe" :size="32" />
                                </span>
                                <div class="contact__addresses-item-content">
                                    <h3 class="contact__addresses-item-title">{{ item.title }}</h3>
                                    <p class="contact__addresses-item-desc">{{ item.desc }}</p>
                                    <span class="contact__addresses-item-footnote">
                                        {{ item.footnote }}
                                    </span>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div class="contact__item-sider">
                        <div class="contact__item-sider-wrapper">
                            <!-- <div class="contact__map">
                                <picture class="contact__map-image-container">
                                    <img src="/img/temp/map.jpg" alt="#" />
                                </picture>
                            </div> -->
                            <div class="contact__map">
                                <MapWrapper />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="contact__item">
                    <div class="contact__item-content">
                        <ul class="contact__info">
                            <li class="contact__info-item">
                                <span class="contact__info-item-title">Головной офис</span>
                                <p class="contact__info-item-text">
                                    Самара, ул. Пресненская набережная, 12, башня «Федерация.
                                    Восток», 30 этаж
                                </p>
                            </li>
                            <li class="contact__info-item">
                                <span class="contact__info-item-title">Рабочие часы</span>
                                <ul class="contact__info-item-list">
                                    <li class="contact__info-item-text">
                                        ПН – ПТ: cс 09:00 до 16:00
                                    </li>
                                    <li class="contact__info-item-text">СБ – ВС: Выходной</li>
                                </ul>
                            </li>
                            <li class="contact__info-item">
                                <span class="contact__info-item-title">
                                    Следите за нами в соцсетях
                                </span>
                                <div class="contact__info-item-socials">
                                    <a
                                        v-for="(link, idx) in socialsLinks"
                                        :key="idx"
                                        class="contact__info-item-socials-link"
                                        :href="link.link"
                                        target="_blank"
                                        rel="noopener noreferrer"
                                        :style="`--mask: url('${link.maskPath}'); --anim-color: ${link.hoverColor}`"
                                    ></a>
                                </div>
                            </li>
                            <li class="contact__info-item">
                                <span class="contact__info-item-title">
                                    Для вопросов и предложений
                                </span>
                                <a class="contact__info-item-link" href="mailto:">
                                    hello@fsarabeska.ru
                                </a>
                            </li>
                            <li class="contact__info-item">
                                <span class="contact__info-item-title">Горячая линия 24/7</span>
                                <a
                                    class="contact__info-item-link contact__info-item-link--large"
                                    href="tel:"
                                >
                                    +7 (999) 856-74-31
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div class="contact__item-sider">
                        <div class="contact__item-sider-wrapper">
                            <div class="contact__decorative">
                                <StarsOverlay class="contact__decorative-title">
                                    <h2>Свежие цветы рядом с вашим домом</h2>
                                </StarsOverlay>
                                <picture class="contact__decorative-image-container">
                                    <img
                                        class="contact__decorative-image"
                                        src="/img/temp/temp1.jpg"
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
            class="contact__banner"
            title="Будьте в курсе новых скидок и предложений!"
            image-url="/img/temp/flowers.gif"
        >
            <SubscribeForm
                title="Подпишитесь на нашу рассылку! Обещаем присылать письма не чаще раза в неделю, только важное и по делу."
            />
        </Banner>
    </NuxtLayout>
</template>

<script setup lang="ts">
    interface IAddressesItem {
        title: string;
        desc?: string;
        footnote?: string;
    }

    interface ISocialsLink {
        maskPath: string;
        link: string;
        hoverColor: string;
    }

    const addresses: IAddressesItem[] = [
        {
            title: 'г. Самара, ул. Ленина, 45, 443011, Россия',
            desc: 'Рядом со станкозаводом',
            footnote: 'пн–пт 10.00–19.00, сб 10.00–16.00, вс — выходной',
        },
        {
            title: 'г. Самара, пр.. Карла Маркса, 78, 443072, Россия',
            desc: 'Вблизи завода по производству станков',
            footnote: 'пн–пт 8.00–17.00, сб — выходной, вс — выходной',
        },
        {
            title: 'г. Самара, ул. Советская, 21, 443028, Россия',
            desc: 'Соседство с заводом станкостроения',
            footnote: 'пн–пт 9.00 - 18.00, сб–вс - выходной',
        },
        {
            title: 'г. Самара, ул. Гагарина, 10, 443020, Россия',
            desc: 'Недалеко от станкостроительного предприятия',
            footnote: 'пн–пт 9.00 - 17.00, сб–вс - выходной',
        },
        {
            title: 'г. Самара, пр. Строителей, 5, 443002, Россия',
            desc: 'Поблизости от завода по изготовлению станков',
            footnote: 'пн–пт 9.00 - 18.00, сб–вс - выходной',
        },
    ];

    const socialsLinks: ISocialsLink[] = [
        {
            maskPath: '/img/masks/vk.svg',
            link: 'https://example.com',
            hoverColor: '#016FCC',
        },
        {
            maskPath: '/img/masks/telegram.svg',
            link: 'https://example.com',
            hoverColor: '#03A4DF',
        },
        {
            maskPath: '/img/masks/ok.svg',
            link: 'https://example.com',
            hoverColor: '#FF7700',
        },
        {
            maskPath: '/img/masks/instagram.svg',
            link: 'https://example.com',
            hoverColor:
                'linear-gradient(45deg, #feda75 0%, #fa7e1e 25%, #d62976 50%, #962fbf 75%, #4f5bd5 100%)',
        },
    ];
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
            font-size: lineScale(96, 64, 480, 1440);
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
            &-image-container {
                width: 100%;
                height: 100%;
                img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }
            }
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
