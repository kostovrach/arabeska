<template>
    <VueFinalModal overlay-transition="vfm-fade" content-transition="vfm-fade">
        <div class="modal-feedback">
            <div class="modal-feedback__container">
                <button class="modal-feedback__button" type="button" @click="emit('close')">
                    <span><SvgSprite type="cross" :size="32" /></span>
                </button>
                <div class="modal-feedback__titlebox">
                    <picture class="modal-feedback__image-container">
                        <img
                            class="modal-feedback__image"
                            :src="feedback?.avatar_url || '/img/service/user-placeholder.png'"
                            :alt="feedback?.name || '#'"
                        />
                    </picture>
                    <div class="modal-feedback__rate">
                        <span
                            v-for="icon in feedback?.rate"
                            :key="icon"
                            class="modal-feedback__rate-icon"
                        >
                            <SvgSprite type="rate-star" :size="24" />
                        </span>
                    </div>
                    <span class="modal-feedback__title">{{ feedback?.name }}</span>
                </div>
                <p v-if="feedback?.text" class="modal-feedback__body">{{ feedback.text }}</p>
            </div>
        </div>
    </VueFinalModal>
</template>

<script setup lang="ts">
    import { VueFinalModal } from 'vue-final-modal';

    const props = defineProps<{
        feedbackId: string | number;
    }>();

    const emit = defineEmits<{
        (e: 'close'): void;
    }>();

    //data ====================================================
    const feedbackStore = useFeedbackStore();

    feedbackStore.getFeedbackById(props.feedbackId);

    const { feedbackItem, feedbackItemStatus } = storeToRefs(feedbackStore);

    const feedback = computed(() => feedbackItem.value);
    const status = computed(() => feedbackItemStatus.value);
    //=========================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .modal-feedback {
        $p: &;

        position: absolute;
        top: 50%;
        left: 50%;
        translate: -50% -50%;
        width: 100%;
        height: fit-content;
        max-width: rem(540);
        max-height: 80lvh;
        overflow-x: hidden;
        overflow-y: auto;
        font-family: 'Inter', sans-serif;
        box-shadow: 1px 1px 5px $c-082535;
        border-radius: rem(32);
        background-color: $c-main;
        @include hide-scrollbar;
        &__container {
            position: relative;
            display: flex;
            flex-direction: column;
            padding: rem(24);
        }
        &__button {
            position: absolute;
            top: rem(16);
            right: rem(16);
            > span {
                @include close-button;
            }
        }
        &__titlebox {
            display: grid;
            grid-template-columns: max-content auto;
            grid-template-areas:
                'image rate'
                'image title';
            align-items: center;
            gap: rem(8) rem(24);
        }
        &__image-container {
            grid-area: image;
            width: rem(96);
            aspect-ratio: 1;
            border-radius: 50%;
            overflow: hidden;
        }
        &__image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        &__rate {
            grid-area: rate;
            display: flex;
            align-items: center;
            align-self: flex-end;
            &-icon {
                color: $c-accent;
            }
        }
        &__title {
            grid-area: title;
            align-self: flex-start;
            font-size: lineScale(28, 20, 480, 1440);
            font-weight: $fw-semi;
        }
        &__body {
            font-size: lineScale(20, 18, 480, 1440);
            line-height: 1.4;
            margin-top: rem(32);
        }
    }
</style>
