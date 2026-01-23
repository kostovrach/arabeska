<template>
    <footer class="footer">
        <div class="footer__container">
            <TheFooterSlider class="footer__slider" />
            <div class="footer__main">
                <NuxtLink class="footer__logo" :to="{ name: 'index' }">
                    <SvgSprite type="logo-full" size="100%" />
                </NuxtLink>
                <div class="footer__links">
                    <a :href="`tel:${contacts?.phone.trim().split(' ').join('')}`">
                        {{ contacts?.phone }}
                    </a>
                    <a :href="`mailto:${contacts?.mail.trim()}`">{{ contacts?.mail }}</a>
                </div>
                <CSubscribeForm class="footer__form" title="Сэкономьте 5% за подписку!" />
            </div>
            <div class="footer__nav">
                <div class="footer__nav-list footer__nav-list--map">
                    <h4 class="footer__nav-title">Карта сайта</h4>
                    <NuxtLink
                        v-show="route.name !== 'index'"
                        class="footer__nav-link"
                        :to="{ name: 'index' }"
                    >
                        Главная
                    </NuxtLink>
                    <button class="footer__nav-link" type="button" @click="openCatalog">
                        Каталог
                    </button>
                    <NuxtLink
                        v-show="route.name !== 'feedback'"
                        class="footer__nav-link"
                        :to="{ name: 'feedback' }"
                    >
                        Отзывы
                    </NuxtLink>
                    <NuxtLink
                        v-show="route.name !== ''"
                        class="footer__nav-link"
                        :to="{ name: 'index' }"
                    >
                        Личный кабинет
                    </NuxtLink>
                    <NuxtLink
                        v-show="route.name !== 'faq'"
                        class="footer__nav-link"
                        :to="{ name: 'faq' }"
                    >
                        Частые вопросы
                    </NuxtLink>
                    <NuxtLink
                        v-show="route.name !== 'wholesale'"
                        class="footer__nav-link"
                        :to="{ name: 'wholesale' }"
                    >
                        Оптовикам
                    </NuxtLink>
                    <NuxtLink
                        v-show="route.name !== 'franchise'"
                        class="footer__nav-link"
                        :to="{ name: 'franchise' }"
                    >
                        Франшиза
                    </NuxtLink>
                    <NuxtLink
                        v-show="route.name !== 'contact'"
                        class="footer__nav-link"
                        :to="{ name: 'contact' }"
                    >
                        Контакты
                    </NuxtLink>
                </div>
                <div class="footer__nav-list footer__nav-list--socials">
                    <h4 class="footer__nav-title">Мы в соцсетях</h4>
                    <ClientOnly>
                        <a
                            v-for="(link, idx) in socials.filter((el) => el.link.length)"
                            class="footer__nav-link"
                            :href="link.link"
                            target="_blank"
                            rel="noopener noreferrer"
                        >
                            {{ link.label }}
                            <span v-if="link.marked" class="symbol">*</span>
                        </a>
                    </ClientOnly>
                </div>
                <div class="footer__nav-list footer__nav-list--address">
                    <h4 class="footer__nav-title">Магазины</h4>
                    <NuxtLink
                        v-for="(item, idx) in contacts?.addresses"
                        :key="idx"
                        class="footer__nav-link"
                        :to="{ name: 'contact' }"
                    >
                        {{ item.short_address }}
                    </NuxtLink>
                </div>
            </div>
            <div class="footer__info">
                <span class="footer__info-copy">&copy; {{ contacts?.copyright }}</span>
                <div class="footer__info-buttons">
                    <button
                        class="footer__info-button"
                        type="button"
                        v-for="modal in docsData"
                        :key="modal.id"
                        @click="
                            openDocsModal(
                                modal.title,
                                modal.date_updated ?? modal.date_created,
                                modal.content
                            )
                        "
                    >
                        {{ modal.title }}
                    </button>
                </div>
                <span class="footer__info-footnote">
                    *Instagram — продукт компании Meta, которая признана экстремистской организацией
                    в России
                </span>
            </div>
        </div>
    </footer>
</template>

<script setup lang="ts">
    import type { IContacts } from '~~/interfaces/contacts';

    import { ModalsCatalog, ModalsDocs } from '#components';
    import { useModal } from 'vue-final-modal';

    interface IDocs {
        id: number | string;
        date_created: string;
        date_updated?: string;
        title: string;
        content: string;
    }

    const route = useRoute();

    const { content: docsData, status: docsStatus } = await useCms<IDocs[]>('docs');
    const { content: contacts } = await useCms<IContacts>('contact');

    const socials: {
        label: string;
        link: string;
        marked?: boolean;
    }[] = [
        {
            label: 'VK',
            link: contacts?.value?.vk ?? '',
        },
        {
            label: 'instagram',
            link: contacts?.value?.instagram ?? '',
            marked: true,
        },
        {
            label: 'Telegram',
            link: contacts?.value?.telegram ?? '',
        },
        {
            label: 'OK',
            link: contacts?.value?.ok ?? '',
        },
    ];

    function openDocsModal(title: string, dateUpdated: string, content: string) {
        const { open: openModal, close: closeModal } = useModal({
            component: ModalsDocs,
            attrs: {
                title: title,
                dateUpdated: dateUpdated,
                content: content,
                status: docsStatus.value,
                onClose() {
                    closeModal();
                },
            },
        });
        openModal();
    }

    const { open: openCatalog, close: closeCatalog } = useModal({
        component: ModalsCatalog,
        attrs: {
            onClose() {
                closeCatalog();
            },
        },
    });
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .footer {
        $p: &;

        color: $c-FFFFFF;
        padding: rem(64) 0 rem(16) 0;
        background-color: $c-secondary;
        &__container {
            display: grid;
            grid-template-columns: 30% auto 30%;
            grid-template-areas:
                'slider main nav'
                'info info info';
            gap: rem(32);
            @include content-container;
            @media (max-width: 1440px) {
                grid-template-columns: repeat(2, 1fr);
                grid-template-areas:
                    'main nav'
                    'info info';
                gap: rem(64) rem(32);
            }
            @media (max-width: 1024px) {
                grid-template-areas:
                    'main main'
                    'nav nav'
                    'info info';
            }
        }
        &__slider {
            grid-area: slider;
            @media (max-width: 1440px) {
                display: none;
            }
        }
        &__main {
            grid-area: main;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            gap: rem(32);
        }
        &__form {
            color: $c-D4E1E7;
        }
        &__logo {
            display: block;
            max-width: rem(384);
            max-height: rem(48);
            @media (pointer: fine) {
                &:hover {
                    color: $c-accent;
                }
            }
        }
        &__links {
            display: flex;
            flex-direction: column;
            a,
            button {
                width: fit-content;
                font-family: 'Inter', sans-serif;
                font-size: lineScale(24, 18, 480, 1440);
                @include hover-blick-line($init-color: inherit);
            }
        }
        &__nav {
            grid-area: nav;
            width: 100%;
            display: grid;
            grid-template-areas:
                'map socials'
                'map address';
            justify-content: space-between;
            gap: rem(32) lineScale(64, 32, 480, 1440);
            @media (max-width: 1024px) {
                justify-content: initial;
            }
            &-list {
                max-width: 20ch;
                display: flex;
                flex-direction: column;
                gap: rem(18);
                &--map {
                    grid-area: map;
                }
                &--socials {
                    grid-area: socials;
                }
                &--address {
                    grid-area: address;
                }
            }
            &-title {
                font-size: rem(18);
                margin-bottom: rem(8);
            }
            &-link {
                cursor: pointer;
                width: fit-content;
                color: $c-98BBD7;
                line-height: 1.2;
                @media (pointer: fine) {
                    &:hover {
                        color: $c-FFFFFF;
                    }
                }
            }
        }
        &__info {
            grid-area: info;
            display: grid;
            grid-template-areas:
                'copy buttons'
                'footnote footnote';
            justify-content: space-between;
            gap: rem(32);
            color: $c-98BBD7;
            @media (max-width: 768px) {
                display: flex;
                flex-direction: column;
            }
            &-copy {
                grid-area: copy;
                cursor: default;
                font-size: rem(14);
                opacity: 0.5;
                white-space: nowrap;
                font-family: 'Inter', sans-serif;
            }
            &-buttons {
                grid-area: buttons;
                display: flex;
                flex-wrap: wrap;
                gap: rem(16);
            }
            &-button {
                cursor: pointer;
                font-size: rem(14);
                font-weight: $fw-semi;
                white-space: nowrap;
                @media (pointer: fine) {
                    &:hover {
                        color: $c-FFFFFF;
                    }
                }
            }
            &-footnote {
                grid-area: footnote;
                font-size: rem(12);
                font-family: 'Inter', sans-serif;
                opacity: 0.5;
            }
        }
    }
</style>
