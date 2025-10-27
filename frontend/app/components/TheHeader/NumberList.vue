<template>
    <div class="list">
        <div class="list__active">
            <div class="list__active-text">
                <span class="symbol">+</span>
                7 987 654-32-10
            </div>
            <SvgSprite class="list__active-icon" type="chevron" :size="16" />
        </div>
        <ul class="list__dropdown">
            <li class="list__item">
                <span class="symbol">+</span>
                7 987 654-32-10
            </li>
            <li class="list__item">
                <span class="symbol">+</span>
                7 987 654-32-10
            </li>
            <li class="list__item">
                <span class="symbol">+</span>
                7 987 654-32-10
            </li>
        </ul>
    </div>
</template>

<script setup lang="ts"></script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .list {
        $p: &;
        $gap: rem(24);

        cursor: default;
        position: relative;
        opacity: 0.8;
        padding: 0 rem(16);
        white-space: nowrap;
        transition: opacity $td $tf;
        &__active {
            display: flex;
            align-items: center;
            gap: rem(8);
            line-height: 1.2;
            &-icon {
                transition: transform $td $tf;
            }
        }
        &__dropdown {
            position: absolute;
            left: 0;
            top: 1em;
            width: 100%;
            display: flex;
            flex-direction: column;
            gap: $gap;
            background-color: $c-secondary;
            padding: rem(16);
            border-radius: rem(16);

            transition: all $td $tf 0.1s;

            // initial state
            gap: rem(32);
            padding-top: rem(32);
            opacity: 0;
            pointer-events: none;
        }
        @media (pointer: fine) {
            &:hover {
                opacity: 1;
                #{$p}__active-icon {
                    transform: scaleY(-1);
                }
                #{$p}__dropdown {
                    gap: $gap;
                    padding-top: $gap;
                    opacity: 1;
                    pointer-events: all;
                }
            }
        }
    }
</style>
