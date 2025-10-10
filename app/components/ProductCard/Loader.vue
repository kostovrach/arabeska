<template>
    <div class="loader">
        <div class="loader__image">
            <div class="loader__skeleton loader__skeleton--image"></div>
        </div>

        <div class="loader__content">
            <div class="loader__skeleton loader__skeleton--title"></div>
            <div class="loader__skeleton loader__skeleton--desc"></div>
            <div class="loader__skeleton loader__skeleton--desc"></div>
            <div class="loader__footer">
                <div class="loader__skeleton loader__skeleton--price"></div>
                <div class="loader__skeleton loader__skeleton--button"></div>
            </div>
        </div>
    </div>
</template>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .loader {
        width: rem(345);
        display: inline-flex;
        flex-direction: column;
        gap: rem(16);
        margin-right: lineScale(32,16,1024,1440);
        border-radius: rem(24);
        overflow: hidden;
        border: rem(1) solid $skeleton-color;
        pointer-events: none;
        &__image {
            flex: 1 1 60%;
        }
        &__content {
            flex: 1 1 40%;
            display: flex;
            flex-direction: column;
            gap: rem(8);
            padding: rem(24);
        }
        &__footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        &__skeleton {
            @include skeleton;
            &--image {
                aspect-ratio: 1;
            }
            &--title {
                height: 1.5rem;
            }
            &--desc {
                width: 60%;
                height: 0.8rem;
            }
            &--price {
                width: 10ch;
                height: 1.5rem;
            }
            &--button {
                width: rem(64);
                aspect-ratio: 1;
                border-radius: 50%;
            }
        }
    }

    @media (max-width: 1024px){
        .loader {
            width: rem(240);
        }
    }
</style>
