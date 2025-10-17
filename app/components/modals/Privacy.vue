<template>
    <VueFinalModal
        overlay-transition="vfm-fade"
        content-transition="vfm-slide-right"
        swipe-to-close="right"
    >
        <div class="modal-privacy">
            <div class="modal-privacy__container">
                <button class="modal-privacy__button" type="button" @click="emit('close')">
                    <SvgSprite type="cross" :size="32" />
                </button>
                <div class="modal-privacy__titlebox">
                    <h1 class="modal-privacy__title">Политика конфиденциальности</h1>
                    <span class="modal-privacy__tag">Последнее обновление:</span>
                </div>
                <div class="modal-privacy__body">
                    <div class="modal-privacy__loader" v-show="1 !== 1">
                        <TextModalLoader />
                    </div>
                    <div class="modal-privacy__error" v-show="1 !== 1">
                        <FetchError />
                    </div>
                    <!-- <div class="modal-privacy__content" v-html=""></div> -->
                </div>
            </div>
        </div>
    </VueFinalModal>
</template>

<script setup lang="ts">
    import { VueFinalModal } from 'vue-final-modal';

    const emit = defineEmits<{
        (e: 'close'): void;
    }>();
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .modal-privacy {
        $p: &;

        position: absolute;
        top: 0;
        right: 0;
        width: 100%;
        max-width: rem(754);
        height: 100lvh;
        color: $c-FFFFFF;
        background-color: $c-secondary;
        &__container {
            display: flex;
            flex-direction: column;
            padding: rem(32);
        }
        &__button {
            align-self: flex-end;
            @include close-button;
        }
        &__titlebox {
            display: flex;
            flex-direction: column;
            gap: rem(32);
            margin-top: rem(16);
        }
        &__title {
            font-size: lineScale(48, 24, 480, 1440);
            font-weight: $fw-semi;
        }
        &__tag {
            font-family: 'Inter', sans-serif;
            font-size: lineScale(16, 14, 480, 1440);
            color: $c-accent;
        }
        &__body {
            margin-top: rem(64);
        }
        &__content {
            font-family: 'Inter', sans-serif;
            h2 {
                text-transform: uppercase;
                font-size: lineScale(32, 18, 480, 1440);
                font-weight: $fw-semi;
                margin: rem(32) 0 rem(8);
            }
            h3,
            h4,
            h5,
            h6 {
                font-size: rem(16);
                font-weight: $fw-bold;
                margin: rem(24) 0 rem(8);
            }

            p {
                font-size: rem(14);
                line-height: 1.3;
                color: $c-98BBD7;
                margin: rem(16) 0 rem(8);
                > a {
                    color: $c-accent;
                    text-decoration: underline;
                    @media (pointer: fine) {
                        &:hover {
                            text-decoration: none;
                        }
                    }
                }
            }
        }
    }
</style>
