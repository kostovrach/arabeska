<template>
    <div class="feedback-loader">
        <div class="feedback-loader__skeleton feedback-loader__skeleton--rate"></div>
        <div class="feedback-loader__text">
            <div class="feedback-loader__skeleton feedback-loader__skeleton--text"></div>
            <div class="feedback-loader__skeleton feedback-loader__skeleton--text"></div>
            <div class="feedback-loader__skeleton feedback-loader__skeleton--text"></div>
            <div class="feedback-loader__skeleton feedback-loader__skeleton--text"></div>
        </div>
        <div class="feedback-loader__footer">
            <div class="feedback-loader__skeleton feedback-loader__skeleton--image"></div>
            <div class="feedback-loader__name">
                <div class="feedback-loader__skeleton feedback-loader__skeleton--name"></div>
                <div class="feedback-loader__skeleton feedback-loader__skeleton--name"></div>
            </div>
        </div>
    </div>
</template>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .feedback-loader {
        width: rem(424);
        display: inline-flex;
        flex-direction: column;
        gap: rem(24);
        padding: rem(32);
        border: rem(1) solid $skeleton-color;
        border-radius: rem(32) rem(32) 0 rem(32);
        margin-right: rem(16);
        &__text {
            display: flex;
            flex-direction: column;
            gap: 0.5ch;
        }
        &__footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: rem(16);
        }
        &__name {
            width: 100%;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }
        &__skeleton {
            @include skeleton;
            &--rate {
                width: 7rem;
                height: 1rem;
            }
            &--text {
                width: 100%;
                height: 1rem;
            }
            &--image {
                width: rem(64);
                aspect-ratio: 1;
                border-radius: 50%;
            }
            &--name {
                height: 1rem;
                &:nth-child(2n + 1) {
                    width: 80%;
                }
                &:nth-child(2n + 2) {
                    width: 60%;
                }
            }
        }
    }
</style>
