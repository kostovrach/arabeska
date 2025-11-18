<template>
    <div :class="['stars-overlay', `stars-overlay--variant-${variant}`, props.class]">
        <span class="stars-overlay__star"><SvgSprite type="star" size="100%" /></span>
        <span class="stars-overlay__star"><SvgSprite type="star" size="100%" /></span>
        <span class="stars-overlay__star"><SvgSprite type="star" size="100%" /></span>
        <span class="stars-overlay__star"><SvgSprite type="star" size="100%" /></span>
        <span class="stars-overlay__star"><SvgSprite type="star" size="100%" /></span>
        <slot></slot>
    </div>
</template>

<script setup lang="ts">
    const props = defineProps<{
        class?: string;
    }>();

    const variant = ref<number>(1);

    const randomVariant = (): number => {
        return Math.floor(Math.random() * 3) + 1;
    };

    onMounted(() => {
        variant.value = randomVariant();
    });
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .stars-overlay {
        $p: &;

        position: relative;
        width: fit-content;
        &__star {
            position: absolute;
            aspect-ratio: 1;
            color: $c-D4E1E7;
        }
        &--variant {
            &-1 {
                #{$p}__star {
                    &:nth-child(5n + 1) {
                        width: rem(32);
                        top: rem(-64);
                        left: rem(-110);
                    }
                    &:nth-child(5n + 2) {
                        width: rem(64);
                        top: rem(-32);
                        left: rem(-80);
                    }
                    &:nth-child(5n + 3) {
                        width: rem(32);
                        top: rem(-24);
                        right: rem(-48);
                    }
                    &:nth-child(5n + 4) {
                        display: none;
                    }
                    &:nth-child(5n + 5) {
                        display: none;
                    }
                }
            }
            &-2 {
                #{$p}__star {
                    &:nth-child(5n + 1) {
                        width: rem(32);
                        top: rem(-32);
                        left: rem(-48);
                    }
                    &:nth-child(5n + 2) {
                        width: rem(64);
                        top: rem(-32);
                        right: rem(-64);
                    }
                    &:nth-child(5n + 3) {
                        width: rem(32);
                        top: rem(-12);
                        right: rem(-96);
                    }
                    &:nth-child(5n + 4) {
                        display: none;
                    }
                    &:nth-child(5n + 5) {
                        display: none;
                    }
                }
            }
            &-3 {
                #{$p}__star {
                    &:nth-child(5n + 1) {
                        width: rem(20);
                        top: rem(-48);
                        left: rem(-120);
                    }
                    &:nth-child(5n + 2) {
                        width: rem(32);
                        top: rem(-12);
                        left: rem(-96);
                    }
                    &:nth-child(5n + 3) {
                        width: rem(64);
                        top: rem(-48);
                        left: rem(-64);
                    }
                    &:nth-child(5n + 4) {
                        width: rem(48);
                        top: rem(-60);
                        right: rem(-48);
                    }
                    &:nth-child(5n + 5) {
                        width: rem(32);
                        top: rem(-32);
                        right: rem(-72);
                    }
                }
            }
        }
    }
</style>
