<template>
    <section class="feedback-hero">
        <div class="feedback-hero__container">
            <div class="feedback-hero__titlebox">
                <StarsOverlay class="feedback-hero__title">
                    <h1>{{ props.title }}</h1>
                </StarsOverlay>
                <p v-if="props.subtitle" class="feedback-hero__desc">{{ props.subtitle }}</p>
                <RateWidgets class="feedback-hero__widgets" />
            </div>
            <picture class="feedback-hero__image-container">
                <img class="feedback-hero__image" :src="props.imageUrl" :alt="props.title ?? '#'" />
            </picture>
        </div>
    </section>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            title: string;
            subtitle?: string;
            imageUrl: string;
        }>(),
        {
            title: '',
            subtitle: '',
            imageUrl: '',
        }
    );
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .feedback-hero {
        &__container {
            display: grid;
            grid-template-columns: auto minmax(30%, rem(520));
            gap: rem(64);
            @include content-container;
        }
        &__titlebox {
            padding: lineScale(128, 96, 480, 1920) 0;
        }
        &__title {
            width: fit-content;
            text-wrap: balance;
            font-size: lineScale(96, 32, 480, 1920);
            line-height: 0.8;
        }
        &__desc {
            max-width: 55ch;
            font-family: 'Inter', sans-serif;
            font-size: lineScale(18, 16, 480, 1440);
            line-height: 1.2;
            margin-top: rem(32);
        }
        &__widgets {
            margin-top: lineScale(128, 96, 480, 1440);
        }
        &__image-container {
            width: 100%;
            aspect-ratio: 1/1.3;
            border-radius: rem(256);
            overflow: hidden;
        }
        &__image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
    }

    @media (max-width: 1024px) {
        .feedback-hero {
            margin-bottom: rem(64);
            &__container {
                grid-template-columns: 100%;
                grid-template-areas:
                    'image'
                    'titlebox';
                padding: 0;
            }
            &__titlebox {
                grid-area: titlebox;
                padding: 0;
                @include content-container;
            }
            &__image-container {
                grid-area: image;
                aspect-ratio: initial;
                height: rem(240);
                border-radius: 0;
            }
        }
    }
</style>
