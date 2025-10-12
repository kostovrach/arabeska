<template>
    <div class="error">
        <img class="error__image" src="/img/service/fetch-error.svg" alt="#" />
        <p class="error__title">Не удалось загрузить</p>
        <button class="error__button" @click="refreshPage">
            <span>Попробовать снова ↺</span>
        </button>
    </div>
</template>

<script setup lang="ts">
    import { refreshNuxtData } from '#app';

    function refreshPage() {
        refreshNuxtData();
    }
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .error {
        display: flex;
        flex-direction: column;
        align-items: center;
        &__image {
            max-width: rem(260);
            aspect-ratio: 16/9;
        }
        &__title {
            font-size: lineScale(32, 24, 480, 1440);
            font-weight: $fw-semi;
            opacity: 0.25;
            margin-top: rem(24);
        }
        &__button {
            margin-top: rem(32);
            @include button-primary(
                $border-color: $c-D4E1E7,
                $font-size: lineScale(16, 14, 480, 1440),
                $padding: rem(12) rem(40),
                $anim-color: $c-accent
            );
        }
    }
</style>
