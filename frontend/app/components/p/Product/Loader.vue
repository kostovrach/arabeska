<template>
    <div class="loader">
        <div class="loader__skeleton loader__skeleton--image"></div>
        <div class="loader__content">
            <div class="loader__title">
                <div class="loader__skeleton loader__skeleton--title"></div>
                <div class="loader__skeleton loader__skeleton--title"></div>
            </div>
            <div class="loader__text">
                <div v-for="n in 6" :key="n" class="loader__skeleton loader__skeleton--text"></div>
            </div>

            <div class="loader__footer">
                <div class="loader__skeleton loader__skeleton--price"></div>
                <div class="loader__skeleton loader__skeleton--button"></div>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts"></script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .loader {
        width: 100%;
        display: grid;
        grid-template-columns: 40% auto 10%;
        gap: rem(32);
        @media (max-width: 1024px) {
            grid-template-columns: 40% auto;
        }
        @media (max-width: 768px) {
            grid-template-columns: auto;
        }
        &__content {
            display: flex;
            flex-direction: column;
            gap: rem(32);
        }
        &__title {
            max-width: 70%;
            display: flex;
            flex-direction: column;
            gap: rem(8);
        }
        &__text {
            display: flex;
            flex-direction: column;
            gap: rem(8);
        }
        &__footer {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-top: rem(64);
        }
        &__skeleton {
            @include skeleton;
            &--image {
                max-width: 100%;
                width: rem(636);
                aspect-ratio: 1;
                @media (max-width: 768px) {
                    width: 100%;
                    height: rem(320);
                    aspect-ratio: auto;
                }
            }
            &--title {
                width: 100%;
                height: 1.5rem;
                &:nth-child(2) {
                    width: 80%;
                }
            }
            &--text {
                height: 0.9rem;
            }
            &--price {
                width: 8rem;
                height: 2rem;
            }
            &--button {
                width: rem(160);
                aspect-ratio: 1;
                border-radius: 50%;
            }
        }
    }
</style>
