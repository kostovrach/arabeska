<template>
    <div class="feedback-loader">
        <div class="feedback-loader__skeleton feedback-loader__skeleton--image"></div>
        <div class="feedback-loader__content">
            <div class="feedback-loader__skeleton feedback-loader__skeleton--title"></div>
            <div class="feedback-loader__text">
                <div
                    v-for="n in 4"
                    :key="n"
                    class="feedback-loader__skeleton feedback-loader__skeleton--text"
                ></div>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts"></script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .feedback-loader {
        border: rem(1) solid rgba($c-D4E1E7, 0.5);
        border-radius: rem(32);
        overflow: hidden;
        &__content {
            padding: rem(24);
        }
        &__text {
            display: flex;
            flex-direction: column;
            gap: rem(8);
            margin-top: rem(24);
        }
        &__skeleton {
            @include skeleton;
            &--image {
                width: 100%;
                height: auto;
                aspect-ratio: 1;
            }
            &--title {
                width: 60%;
                height: 1.2rem;
            }
            &--text {
                width: 100%;
                height: 0.9rem;
            }
        }
    }
</style>
