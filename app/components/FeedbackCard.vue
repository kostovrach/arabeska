<template>
    <div class="feedback-card">
        <div class="feedback-card__wrapper">
            <div class="feedback-card__body">
                <div class="feedback-card__rate">
                    <SvgSprite v-for="n in item.rate" :key="n" type="rate-star" :size="24" />
                </div>
                <div class="feedback-card__text">{{ item.text }}</div>
            </div>

            <div class="feedback-card__footer">
                <picture class="feedback-card__image-container">
                    <img
                        class="feedback-card__image"
                        :src="item.user.avatar || '/img/service/user-placeholder.png'"
                        alt="#"
                    />
                </picture>
                <p class="feedback-card__name">{{ item.user.name || 'Аноним' }}</p>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
    // types==========================================
    import type { IFeedback } from '~~/interfaces/feedback';
    // ===============================================

    // data===========================================
    const props = defineProps<{
        content: IFeedback;
    }>();

    const item = props.content;
    // ===============================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .feedback-card {
        width: rem(424);
        height: 100%;
        padding: rem(32);
        border-radius: rem(32) rem(32) 0 rem(32);
        border: rem(1) solid $c-D4E1E7;
        &__wrapper {
            width: 100%;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            gap: rem(24);
        }
        &__body {
            display: flex;
            flex-direction: column;
            gap: rem(24);
        }
        &__rate {
            color: $c-accent;
        }
        &__text {
            font-family: 'Inter', sans-serif;
            @include lineClamp(7);
        }
        &__footer {
            display: flex;
            align-items: center;
            gap: rem(16);
        }
        &__image-container {
            width: rem(64);
            aspect-ratio: 1;
            border-radius: 50%;
            overflow: hidden;
            img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
        }
        &__name {
            font-family: 'Inter', sans-serif;
        }
    }
</style>
