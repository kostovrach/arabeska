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
        $color: #e2e8f0;
        $anim-color: linear-gradient(90deg, transparent, rgba(#ffffff, 0.4), transparent);

        width: rem(345);
        display: inline-flex;
        flex-direction: column;
        gap: rem(16);
        margin-right: rem(32);
        border-radius: rem(24);
        overflow: hidden;
        border: rem(1) solid $color;
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
            position: relative;
            width: 100%;
            height: 100%;
            background-color: $color;
            border-radius: rem(8);
            &::before {
                content: '';
                position: absolute;
                z-index: 1;
                inset: 0;
                background: $anim-color;
                animation: skeleton-anim 1.2s ease infinite;
                pointer-events: none;
            }
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
        @keyframes skeleton-anim {
            from {
                translate: -100%;
            }
            to {
                translate: 100%;
            }
        }
    }
</style>
