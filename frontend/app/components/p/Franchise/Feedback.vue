<template>
    <section class="franchise-feedback">
        <div class="franchise-feedback__container">
            <div class="franchise-feedback__titlebox">
                <h2 class="franchise-feedback__title">{{ props.title }}</h2>
                <p class="franchise-feedback__desc" v-if="props.description.length">
                    {{ props.description }}
                </p>
            </div>
            <div class="franchise-feedback__body">
                <CFeedbackCarousel />
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            title: string;
            description?: string;
        }>(),
        {
            title: '',
            description: '',
        }
    );
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .franchise-feedback {
        @include content-block($margin: rem(64));
        &__container {
            @include content-container;
        }
        &__titlebox {
            display: flex;
            flex-direction: column;
            gap: rem(32);
        }
        &__title {
            max-width: 20ch;
            text-wrap: balance;
            font-family: 'Inter', sans-serif;
            font-size: lineScale(64, 32, 480, 1440);
            font-weight: $fw-semi;
        }
        &__desc {
            max-width: 60ch;
            font-size: lineScale(18, 16, 480, 1440);
            line-height: 1.25;
            opacity: 0.8;
        }
        &__body {
            margin-top: rem(64);
        }
    }
</style>
