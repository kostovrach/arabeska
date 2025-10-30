<template>
    <section class="info-hero">
        <picture class="info-hero__image-container">
            <img class="info-hero__image" :src="props.imageUrl" :alt="props.title" />
        </picture>
        <div class="info-hero__container">
            <span class="info-hero__tag" v-if="props.tag">{{ props.tag }}</span>
            <h1 class="info-hero__title" v-html="props.title"></h1>
            <p v-if="props.desc" class="info-hero__desc" v-html="props.desc"></p>
            <slot name="button"></slot>
        </div>
    </section>
</template>

<script setup lang="ts">
    const props = defineProps<{
        imageUrl: string;
        tag: string;
        title: string;
        desc?: string;
        button?: string;
    }>();
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .info-hero {
        position: relative;
        width: 100%;
        color: $c-FFFFFF;
        overflow: hidden;
        &__image-container {
            position: fixed;
            top: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            filter: brightness(60%);
        }
        &__image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        &__container {
            position: relative;
            z-index: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            @include content-container($padding: rem(96) $px);
        }
        &__tag {
            width: fit-content;
            font-family: 'Inter', sans-serif;
            background-color: $c-accent;
            padding: rem(5) rem(16);
            border-radius: rem(32);
        }
        &__title {
            max-width: 18ch;
            font-size: lineScale(96, 48, 480, 1440);
            line-height: 0.8;
            font-weight: $fw-semi;
            margin-top: rem(16);
        }
        &__desc {
            max-width: 60ch;
            font-size: lineScale(18, 16, 480, 1440);
            line-height: 1.2;
            margin-top: rem(64);
        }
    }
</style>
