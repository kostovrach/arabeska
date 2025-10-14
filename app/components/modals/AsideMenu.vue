<template>
    <VueFinalModal class="menu">
        <div class="menu__container">
            <div class="menu__header">
                <button class="menu__button" type="button">
                    <SvgSprite type="cross" :size="32" />
                </button>
            </div>

            <nav class="menu__nav">
                <NuxtLink
                    v-for="(link, idx) in navLinks"
                    :key="idx"
                    :class="[
                        'menu__nav-link',
                        routeName === link.routeName ? 'menu__nav-link--current' : '',
                    ]"
                    :to="{ name: link.routeName }"
                >
                    <span>{{ link.label }}</span>
                </NuxtLink>
            </nav>
            <div class="menu__footer">
                <div class="menu__socials">
                    <a
                        v-for="(link, idx) in socialsLinks"
                        :key="idx"
                        class="menu__socials-link"
                        :href="link.link"
                        target="_blank"
                        rel="noopener noreferrer"
                        :style="`--mask: url('${link.maskPath}'); --anim-color: ${link.hoverColor}`"
                    ></a>
                </div>
                <div class="menu__connection">
                    <a href="tel:">8 846 050-55-10</a>
                    <a href="mailto:">support@damailn.com</a>
                </div>
            </div>
        </div>
    </VueFinalModal>
</template>

<script setup lang="ts">
    import { VueFinalModal } from 'vue-final-modal';

    // types ===================================================
    interface INavLink {
        routeName: string;
        routeParams?: object;
        label: string;
    }

    interface ISocialsLink {
        maskPath: string;
        link: string;
        hoverColor: string;
    }
    // =========================================================

    // data ====================================================
    const routeName = useRoute().name;

    const navLinks: INavLink[] = [
        {
            label: 'Главная',
            routeName: 'index',
        },
        {
            label: 'каталог',
            routeName: '',
        },
        {
            label: 'личный кабинет',
            routeName: '',
        },
        {
            label: 'корзина',
            routeName: '',
        },
        {
            label: 'подбор букета',
            routeName: '',
        },
        {
            label: 'оплата',
            routeName: '',
        },
        {
            label: 'доставка',
            routeName: '',
        },
        {
            label: 'возврат',
            routeName: '',
        },
        {
            label: 'цветочная подписка',
            routeName: '',
        },
        {
            label: 'отзывы',
            routeName: '',
        },
        {
            label: 'адреса магазинов',
            routeName: '',
        },
        {
            label: 'оптовикам',
            routeName: '',
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
    // =========================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .menu {
        $p: &;
        $px: rem(32);

        width: 100%;
        max-width: rem(540);
        height: 100vh;
        color: $c-FFFFFF;
        background-color: $c-secondary;
        &__header {
            width: 100%;
            display: flex;
            flex-direction: column;
            padding: 0 $px;
        }
        &__button {
            align-self: flex-end;
            cursor: pointer;
            width: fit-content;
            aspect-ratio: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            @include frame-scale($padding: rem(8), $border-radius: 50%);
            @media (pointer: fine) {
                transition: rotate $td $tf;
                &:hover {
                    rotate: -90deg;
                }
            }
        }
        &__container {
            width: 100%;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            gap: rem(32);
            padding: $px 0;
        }
        &__nav {
            display: flex;
            flex-direction: column;
            &-link {
                width: fit-content;
                text-transform: lowercase;
                font-size: lineScale(40, 32, 480, 1440);
                font-weight: $fw-semi;
                padding: rem(8) $px;
                @include hover-overlap();
                &--current {
                    pointer-events: none;
                    color: $c-accent;
                }
            }
        }
        &__footer {
            display: flex;
            flex-direction: column;
            gap: rem(16);
            padding: 0 $px;
        }
        &__socials {
            display: flex;
            align-items: center;
            &-link {
                display: block;
                width: rem(40);
                aspect-ratio: 1;
                mask-image: var(--mask);
                mask-size: 100%;
                mask-repeat: no-repeat;
                background: $c-98BBD7;
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
        &__connection {
            display: flex;
            flex-direction: column;
            gap: rem(16);
            > a {
                width: fit-content;
                font-family: 'Inter', sans-serif;
                color: $c-98BBD7;
                @media (pointer: fine) {
                    &:hover {
                        color: $c-FFFFFF;
                    }
                }
            }
        }
    }
</style>
