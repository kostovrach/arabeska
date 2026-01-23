<template>
    <div class="call-to-action">
        <SpeedDial
            class="call-to-action__body"
            :model="links"
            :radius="120"
            direction="up"
            :transition-delay="80"
        >
            <template #button="{ toggleCallback }">
                <button class="call-to-action__button" type="button" @click="toggleCallback">
                    <SvgSprite type="chat" :size="32" />
                </button>
            </template>
            <template #item="{ item }">
                <a
                    class="call-to-action__item"
                    :href="item.href"
                    :target="item.target"
                    :style="{ backgroundColor: item.color }"
                >
                    <SvgSprite :type="item.icon ?? ''" :size="22" :style="item.iconStyle" />
                </a>
            </template>
        </SpeedDial>
    </div>
</template>

<script setup lang="ts">
    import type { HTMLAttributes } from 'vue';
    import type { IContacts } from '~~/interfaces/contacts';

    const { content: contacts } = await useCms<IContacts>('contact');

    const links: {
        icon: string;
        href: string;
        target: string;
        color: string;
        iconStyle?: HTMLAttributes['style'];
    }[] = [];

    if (contacts.value?.vk)
        links.push({
            icon: 'socials-vk-nofill',
            href: `${contacts.value?.vk?.trim().replace(/\s+/g, '')}`,
            target: '_blank',
            color: '#016FCC',
        });

    if (contacts.value?.telegram)
        links.push({
            icon: 'socials-telegram-nofill',
            href: `${contacts.value?.telegram?.trim().replace(/\s+/g, '')}`,
            target: '_blank',
            color: '#03A4DF',
            iconStyle: { translate: `-1px 0` },
        });

    if (contacts.value?.phone)
        links.push({
            icon: 'phone',
            href: `tel:${contacts.value?.phone?.trim().replace(/\s+/g, '')}`,
            target: '_parent',
            color: '#99CC65',
        });
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .call-to-action {
        position: fixed;
        bottom: lineScale(32, 16, 480, 1920);
        right: lineScale(32, 16, 480, 1920);
        z-index: 10;
        &__button {
            cursor: pointer;
            position: relative;
            color: $c-FFFFFF;
            width: rem(64);
            height: rem(64);
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: $c-accent;
            border-radius: 50%;
            margin-top: rem(8);
            &::before {
                content: '';
                position: absolute;
                z-index: -1;
                inset: 0;
                background-color: inherit;
                border-radius: 50%;
                pointer-events: none;
                animation: blick 2s linear infinite;
            }
            @keyframes blick {
                0% {
                    scale: 0;
                    opacity: 0.7;
                }
                75% {
                    scale: 1.5;
                }
                100% {
                    scale: 1.7;
                    opacity: 0;
                }
            }
        }
        &__item {
            width: rem(34);
            aspect-ratio: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            color: $c-FFFFFF;
            margin: rem(6);
            border-radius: rem(8);
            @media (pointer: fine) {
                &:hover {
                    rotate: -6.5deg;
                    scale: 1.05;
                }
            }
        }
    }
</style>
