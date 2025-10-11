<template>
    <SpeedDial class="share-menu" :model="shareLinks" direction="down" :transitionDelay="80">
        <template #button="{ toggleCallback }">
            <div class="share-menu__button" @click="toggleCallback">
                <SvgSprite type="share" :size="40" />
            </div>
        </template>
        <template #item="{ item }">
            <div class="share-menu__item" :style="`--hover-color: ${item.hoverColor}`">
                <SvgSprite :type="item.icon ?? 'arrow'" :size="36" />
            </div>
        </template>
    </SpeedDial>
</template>

<script setup lang="ts">
    interface IShareLink {
        icon: string;
        handler: () => void;
        hoverColor?: string;
    }

    const shareLinks: IShareLink[] = [
        {
            icon: 'socials-vk',
            handler: () => {},
            hoverColor: '#016FCC',
        },
        {
            icon: 'socials-telegram',
            handler: () => {},
            hoverColor: '#03A4DF',
        },
        {
            icon: 'socials-ok',
            handler: () => {},
            hoverColor: '#FF7700',
        },
    ];
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .share-menu {
        position: absolute;
        &__button {
            cursor: pointer;
        }
        &__item {
            cursor: pointer;
            @media (pointer: fine) {
                &:hover {
                    color: var(--hover-color);
                }
            }
        }
        > ul {
            gap: rem(4);
            > li:nth-of-type(1) {
                margin-top: rem(8);
            }
            > li:nth-of-type(3n + 1) {
                @media (pointer: fine) {
                    &:hover {
                        rotate: 12deg;
                    }
                }
            }
            > li:nth-of-type(3n + 2) {
                @media (pointer: fine) {
                    &:hover {
                        rotate: -8deg;
                    }
                }
            }
            > li:nth-of-type(3n + 3) {
                @media (pointer: fine) {
                    &:hover {
                        rotate: 15deg;
                    }
                }
            }
        }
    }
</style>
