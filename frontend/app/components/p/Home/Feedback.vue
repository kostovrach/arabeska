<template>
    <section class="home-feedback">
        <div class="home-feedback__container">
            <div class="home-feedback__titlebox">
                <h2 class="home-feedback__title">{{ props.title }}</h2>
                <p class="home-feedback__subtitle" v-if="props.title">{{ props.subtitle }}</p>
                <NuxtLink class="home-feedback__link" :to="{ name: 'feedback' }">
                    <span>Смотреть все</span>
                    <SvgSprite type="arrow" :size="12" />
                </NuxtLink>
            </div>
            <CRateWidgets class="home-feedback__widgets" />
            <CFeedbackCarousel />
        </div>
    </section>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            title?: string;
            subtitle?: string;
        }>(),
        {
            title: 'Отзывы покупателей',
            subtitle: '',
        }
    );
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .home-feedback {
        @include content-block;
        &__container {
            display: flex;
            flex-direction: column;
            gap: rem(64);
            @include content-container;
        }
        &__titlebox {
            display: grid;
            grid-template-columns: repeat(2, auto);
            grid-template-rows: repeat(3, auto);
            grid-template-areas:
                'title .'
                'subtitle .'
                'link link';
            gap: rem(32);
        }
        &__title {
            grid-area: title;
            font-size: lineScale(64, 32, 480, 1440);
            font-weight: $fw-semi;
        }
        &__subtitle {
            grid-area: subtitle;
            max-width: 45ch;
            font-size: lineScale(24, 18, 480, 1440);
            opacity: 0.8;
        }
        &__link {
            grid-area: link;
            justify-self: flex-end;
            align-self: flex-end;
            height: fit-content;
            display: flex;
            align-items: center;
            gap: rem(8);
            @include hover-blick-line;
        }
    }
</style>
