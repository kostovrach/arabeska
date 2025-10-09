<template>
    <header class="header">
        <div class="header__container">
            <div class="header__overview">
                <NuxtLink class="header__logo" :to="{ name: 'index' }">
                    <div class="header__logo-image--desktop">
                        <SvgSprite type="logo-full" size="100%" />
                    </div>
                    <div class="header__logo-image--touch">
                        <SvgSprite type="logo-icon" size="100%" />
                    </div>
                </NuxtLink>
                <TheHeaderDropDown class="header__dropdown" />
                <nav class="header__nav">
                    <NuxtLink class="header__nav-link" :to="{ name: 'index' }">
                        <span>Тренды</span>
                    </NuxtLink>
                    <NuxtLink class="header__nav-link" :to="{ name: 'index' }">
                        <span>Хиты</span>
                    </NuxtLink>
                    <NuxtLink class="header__nav-link" :to="{ name: 'index' }">
                        <span>Акции</span>
                    </NuxtLink>
                    <NuxtLink class="header__nav-link" :to="{ name: 'index' }">
                        <span>Подарки</span>
                    </NuxtLink>
                </nav>
            </div>
            <div class="header__controls">
                <div class="header__location">
                    <SvgSprite type="map-pin" :size="20" />
                    <span>Самара</span>
                </div>
                <TheHeaderNumberList class="header__number-list" />
                <TheHeaderSearchbar class="header__searchbar" />
                <NuxtLink class="header__action header__action--profile" :to="{ name: 'index' }">
                    <SvgSprite type="user" :size="24" />
                </NuxtLink>
                <NuxtLink class="header__action header__action--cart" :to="{ name: 'index' }">
                    <SvgSprite type="bag" :size="24" />
                    <span class="header__action-indicator">48</span>
                </NuxtLink>
                <TheHeaderBurger class="header__burger" />
            </div>
        </div>
    </header>
</template>

<script setup lang="ts"></script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .header {
        $p: &;

        position: sticky;
        top: 0;
        z-index: 10;
        width: 100%;
        color: $c-98BBD7;
        background-color: $c-secondary;
        padding: rem(16) 0;
        &__container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: lineScale(32,16,480,1440);
            @include content-container;
        }

        // left bar
        &__overview {
            display: flex;
            align-items: center;
            gap: lineScale(16,8,480,1440);
            font-size: rem(14);
            font-weight: $fw-semi;
        }
        &__logo {
            width: fit-content;
            color: $c-accent;
            translate: 0 rem(-4);
            @media (pointer: fine) {
                &:hover {
                    color: $c-FFFFFF;
                }
            }
            &-image {
                &--desktop {
                    width: rem(250);
                    height: rem(40);
                    @media (max-width: 1024px) {
                        display: none;
                    }
                }
                &--touch {
                    width: rem(50);
                    height: rem(32);
                    @media (min-width: 1024px) {
                        display: none;
                    }
                }
            }
        }
        &__nav {
            display: flex;
            align-items: center;
            &-link {
                @include frame-scale($anim-color: $c-98BBD7);
            }
        }

        // right bar
        &__controls {
            display: flex;
            align-items: center;
            gap: lineScale(16,8,480,1440);
            font-weight: $fw-semi;
        }
        &__location {
            cursor: default;
            display: flex;
            align-items: center;
            gap: rem(4);
            font-size: rem(12);
            opacity: 0.5;
        }
        &__action {
            position: relative;
            cursor: pointer;
            aspect-ratio: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            @include frame-scale($border-radius: 0, $padding: rem(8), $finally-border-radius: 50%);
            @media (pointer: fine) {
                &:hover {
                    #{$p}__action-indicator {
                        color: $c-accent;
                        background-color: $c-secondary;
                        border-color: $c-accent;
                    }
                }
            }
            &-indicator {
                position: absolute;
                z-index: 2;
                top: rem(-4);
                right: rem(-6);
                display: flex;
                align-items: center;
                justify-content: center;
                aspect-ratio: 1;
                font-size: rem(10);
                padding: rem(4);
                border-radius: 50%;
                border: rem(0.25) solid transparent;
                will-change: border-color;
                transition: all $td $tf;
            }
        }
    }

    @media (max-width: 1300px){
        .header {
            &__location,
            &__number-list {
                display: none;
            }
        }
    }
    @media (max-width: 768px){
        .header {
            &__nav {
                display: none;
            }
        }
    }
</style>
