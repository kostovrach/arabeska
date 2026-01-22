<template>
    <section :class="['banner', props.class]">
        <div class="banner__container">
            <div class="banner__wrapper">
                <h2 class="banner__title" v-html="props.title"></h2>
                <slot></slot>
            </div>
            <span class="banner__icon"><SvgSprite type="star" size="100%" /></span>
            <span class="banner__icon"><SvgSprite type="star" size="100%" /></span>
            <span class="banner__icon"><SvgSprite type="star" size="100%" /></span>
            <span class="banner__icon"><SvgSprite type="star" size="100%" /></span>

            <picture class="banner__image-container">
                <img class="banner__image" :src="props.imageUrl" :alt="props.title" />
            </picture>
        </div>
    </section>
</template>

<script setup lang="ts">
    const props = defineProps<{
        title: string;
        imageUrl: string;
        class?: string;
    }>();
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .banner {
        @include content-container($padding: rem(64) $px);
        &__container {
            position: relative;
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            border-radius: rem(64);
            overflow: hidden;
        }
        &__wrapper {
            position: relative;
            z-index: 2;
            display: flex;
            flex-direction: column;
            gap: rem(64);
            color: $c-FFFFFF;
            padding: lineScale(64, 32, 480, 1440) lineScale(64, 16, 480, 1440);
            backdrop-filter: blur(10px) brightness(90%);
        }
        &__title {
            font-family: 'Inter', sans-serif;
            font-size: lineScale(64, 32, 480, 1440);
            text-wrap: balance;
        }
        &__image-container {
            position: absolute;
            z-index: 1;
            inset: 0;
            filter: brightness(80%);
            pointer-events: none;
        }
        &__image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        &__icon {
            display: block;
            position: absolute;
            z-index: 2;
            color: $c-FFFFFF;
            aspect-ratio: 1;
            pointer-events: none;
            &:nth-of-type(1) {
                width: rem(32);
                top: 5%;
                left: 55%;
            }
            &:nth-of-type(2) {
                width: rem(36);
                top: 5%;
                right: 5%;
            }
            &:nth-of-type(3) {
                width: rem(64);
                top: 10%;
                right: 10%;
            }
            &:nth-of-type(4) {
                width: rem(20);
                bottom: 15%;
                right: 10%;
            }
        }
    }

    @media (max-width: 768px) {
        .banner {
            &__container {
                grid-template-columns: 100%;
            }
            &__icon {
                opacity: 0.1;
            }
        }
    }

    @media (max-width: 540px) {
        .banner {
            padding: 0;
            &__container {
                border-radius: 0;
            }
        }
    }
</style>
