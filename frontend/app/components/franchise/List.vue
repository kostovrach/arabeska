<template>
    <section class="franchise-list" v-if="props.content.length">
        <ul class="franchise-list__container">
            <li v-for="(item, idx) in props.content" :key="idx" class="franchise-list__item">
                <picture class="franchise-list__item-image-container">
                    <img class="franchise-list__item-image" :src="item.imageUrl" :alt="`${idx}`" />
                </picture>
                <div class="franchise-list__item-body">
                    <h2 class="franchise-list__item-title" v-if="item.title">{{ item.title }}</h2>
                    <div class="franchise-list__item-content" v-html="item.body"></div>
                </div>
            </li>
        </ul>
    </section>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            content: {
                imageUrl: string;
                title: string;
                body: string;
            }[];
        }>(),
        {
            content: () => [],
        }
    );
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .franchise-list {
        padding: rem(64) 0;
        &__container {
            display: flex;
            flex-direction: column;
            gap: rem(32);
            @include content-container;
        }
        &__item {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            align-items: center;
            gap: rem(32);
            &:nth-child(odd) {
                grid-template-areas: 'image content';
            }
            &:nth-child(even) {
                grid-template-areas: 'content image';
            }
            &-image-container {
                grid-area: image;
                width: 100%;
                aspect-ratio: 1.3/1;
                border-radius: rem(32);
                overflow: hidden;
            }
            &-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            &-body {
                padding: rem(32);
            }
            &-title {
                font-size: lineScale(32, 24, 480, 1440);
                margin-bottom: rem(32);
            }
            &-content {
                grid-area: content;
                display: flex;
                flex-direction: column;
                gap: rem(16);
                font-family: 'Inter', sans-serif;
                font-size: lineScale(18, 16, 480, 1440);
                line-height: 1.3;
                h2,
                h3,
                h4,
                h5,
                h6 {
                    font-size: lineScale(20, 18, 480, 1440);
                    margin-bottom: rem(16);
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
        }
    }

    @media (max-width: 1024px) {
        .franchise-list {
            &__container {
                gap: rem(64);
            }
            &__item {
                display: flex;
                flex-direction: column;
                &-image-container {
                    aspect-ratio: auto;
                    height: rem(320);
                }
                &-body {
                    padding: 0;
                }
            }
        }
    }
</style>
