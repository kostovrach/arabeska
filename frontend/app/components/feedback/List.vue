<template>
    <section class="feedback-list">
        <div class="feedback-list__container">
            <div class="feedback-list__titlebox">
                <h2 class="feedback-list__title">Отзывы</h2>
                <ClientOnly>
                    <span class="feedback-list__counter">({{ feedbackList?.length }})</span>
                </ClientOnly>
            </div>
            <div v-show="status === 'error' || status === 'idle'" class="feedback-list__error">
                <FetchError />
            </div>
            <div
                v-show="status === 'pending'"
                class="feedback-list__body feedback-list__body--loader"
            >
                <FeedbackCardLoader
                    v-for="n in 8"
                    :key="n"
                    class="feedback-list__item feedback-list__item--loader"
                />
            </div>
            <ClientOnly>
                <div v-show="status === 'success'" class="feedback-list__body">
                    <button
                        v-for="(card, idx) in items"
                        :key="idx"
                        class="feedback-list__item"
                        type="button"
                        @click="openFeedback(card.id)"
                    >
                        <div class="feedback-list__item-rate">
                            <span
                                v-for="icon in card.rate"
                                :key="icon"
                                class="feedback-list__item-rate-icon"
                            >
                                <SvgSprite type="star" :size="32" />
                            </span>
                        </div>
                        <picture class="feedback-list__item-image-container">
                            <img
                                class="feedback-list__item-image"
                                :src="card.avatar_url || '/img/service/flowers-placeholder.png'"
                                :alt="card.name || '#'"
                            />
                        </picture>
                        <div class="feedback-list__item-content">
                            <h3 class="feedback-list__item-title">{{ card.name }}</h3>
                            <p v-if="card.text" class="feedback-list__item-text">{{ card.text }}</p>
                        </div>
                    </button>
                </div>
            </ClientOnly>
        </div>
    </section>
</template>

<script setup lang="ts">
    import { ModalsFeedbackItem } from '#components';
    import { useModal } from 'vue-final-modal';

    // data===================================================
    const feedbackStore = useFeedbackStore();
    feedbackStore.getFeedback();

    const { feedbackList, feedbackStatus } = storeToRefs(feedbackStore);

    const status = computed(() => feedbackStatus.value);
    const items = computed(() => feedbackList.value ?? []);
    // =======================================================

    function openFeedback(id: string | number): void {
        const { open: _open, close: closeFeedback } = useModal({
            component: ModalsFeedbackItem,
            attrs: {
                feedbackId: id,
                onClose() {
                    closeFeedback();
                },
            },
        });
        _open();
    }
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .feedback-list {
        @include content-block($margin: rem(64));
        &__container {
            @include content-container;
        }
        &__titlebox {
            display: flex;
            align-items: flex-start;
        }
        &__title {
            font-size: lineScale(48, 40, 480, 1440);
            font-weight: $fw-semi;
        }
        &__counter {
            font-family: 'Inter', sans-serif;
            font-weight: $fw-semi;
        }
        &__body {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: rem(16);
            margin-top: rem(64);
        }
        &__item {
            cursor: pointer;
            position: relative;
            display: grid;
            @media (min-width: 1240px) {
                grid-template-columns: 100%;
            }
            font-family: 'Inter', sans-serif;
            border: rem(1) solid $c-D4E1E7;
            border-radius: rem(32);
            overflow: hidden;
            opacity: 0.9;
            transition: all $td $tf;
            &:nth-child(even) {
                translate: 0 rem(96);
            }
            @media (pointer: fine) {
                &:hover {
                    opacity: 1;
                    transform: translateY(rem(-15));
                }
            }
            &-rate {
                position: absolute;
                top: rem(16);
                left: rem(16);
                display: flex;
                align-items: center;
                gap: rem(4);
                color: $c-FFFFFF;
                &-icon {
                    filter: drop-shadow(5px 5px 5px rgba(#000, 0.5));
                }
            }
            &-image-container {
                width: 100%;
                aspect-ratio: 1;
            }
            &-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            &-content {
                display: flex;
                flex-direction: column;
                gap: rem(24);
                padding: rem(16);
            }
            &-title {
                font-size: lineScale(22, 18, 480, 1440);
                font-weight: $fw-semi;
            }
            &-text {
                font-size: lineScale(18, 16, 480, 1440);
                line-height: 1.25;
                @include lineClamp(4);
            }
        }
    }

    @media (max-width: 1240px) {
        .feedback-list {
            &__body {
                grid-template-columns: repeat(3, 1fr);
            }
            &__item {
                &:nth-child(even) {
                    translate: initial;
                }
                &:nth-child(3n + 2) {
                    translate: 0 rem(96);
                }
            }
        }
    }

    @media (max-width: 768px) {
        .feedback-list {
            &__body {
                grid-template-columns: repeat(2, 1fr);
            }
            &__item {
                &:nth-child(3n + 2) {
                    translate: initial;
                }
                &:nth-child(even) {
                    translate: 0 rem(96);
                }
            }
        }
    }

    @media (max-width: 540px) {
        .feedback-list {
            &__body {
                grid-template-columns: 100%;
            }
            &__item {
                display: grid;
                grid-template-areas:
                    'rate rate'
                    'image content';
                gap: rem(40) rem(16);
                padding: rem(24);
                &:nth-child(even) {
                    translate: initial;
                }
                &-rate {
                    grid-area: rate;
                    position: initial;
                    color: $c-accent;
                    &-icon {
                        filter: initial;
                    }
                }
                &-image-container {
                    grid-area: image;
                    width: rem(64);
                    border-radius: 50%;
                    overflow: hidden;
                }
                &-content {
                    grid-area: content;
                    gap: rem(16);
                    padding: 0;
                }
            }
        }
    }
</style>
