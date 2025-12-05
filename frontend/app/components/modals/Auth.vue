<template>
    <VueFinalModal overlay-transition="vfm-fade" content-transition="vfm-fade">
        <div class="modal-auth hide-scrollbar">
            <button class="modal-auth__close-btn" type="button" @click="emit('close')">
                <SvgSprite type="cross" :size="24" />
            </button>
            <div class="modal-auth__container">
                <div class="modal-auth__step modal-auth__step--auth">
                    <div class="modal-auth__titlebox">
                        <span class="modal-auth__title">Вход в личный кабинет</span>
                        <p class="modal-auth__desc">
                            Авторизуйтесь, чтобы смотреть свою историю заказов, копить баллы,
                            получать подарки и&nbsp;многое&nbsp;другое
                        </p>
                    </div>
                    <form id="auth" class="modal-auth__form">
                        <div class="modal-auth__inputbox">
                            <InputMask
                                v-model="authData.phone"
                                id="auth-phone"
                                class="modal-auth__input modal-auth__input--auth"
                                mask="+7 (999) 999-99-99"
                                placeholder="+7 (___) ___-__-__"
                                name="auth-phone"
                                @focus="authErrors.phone = false"
                            />
                            <div v-if="authErrors.phone" class="modal-auth__error">
                                <span>i</span>
                                <p>Необходимо заполнить поле</p>
                            </div>
                        </div>
                        <button class="modal-auth__button" type="submit">
                            <span>Получить код</span>
                        </button>
                        <label class="modal-auth__agreement" for="auth-agreement">
                            <div class="modal-auth__agreement-checkbox">
                                <input
                                    v-model="authData.agreement"
                                    id="auth-agreement"
                                    type="checkbox"
                                    name="auth-agreement"
                                    @input="authErrors.agreement = false"
                                />
                            </div>
                            <p class="modal-auth__agreement-text">
                                Согласен с политикой конфиденциальности и обработки персональных
                                данных
                            </p>
                            <div v-if="authErrors.agreement" class="modal-auth__error">
                                <span>i</span>
                                <p>Без вашего согласия мы не сможем продолжить</p>
                            </div>
                        </label>
                    </form>
                </div>
                <div class="modal-auth__step modal-auth__step--otp"></div>
            </div>
        </div>
    </VueFinalModal>
</template>

<script setup lang="ts">
    import { VueFinalModal } from 'vue-final-modal';

    const emit = defineEmits<{
        (e: 'close'): void;
    }>();

    const authData = reactive({
        phone: '',
        agreement: true,
    });

    const authErrors = reactive({
        phone: true,
        agreement: true,
    });

    const submitPhone = () => {};
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .modal-auth {
        position: fixed;
        width: 100%;
        max-width: rem(910);
        max-height: 100lvh;
        overflow-y: auto;
        top: 50%;
        left: 50%;
        translate: -50% -50%;
        background-color: $c-FFFFFF;
        padding: rem(64) rem(32);
        border-radius: rem(32);
        overflow-x: hidden;
        &__close-btn {
            top: rem(16);
            right: rem(16);
            @include close-button($position: absolute);
        }
        &__container {
            position: relative;
        }
        &__step {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: rem(32);
        }
        &__titlebox {
            display: flex;
            flex-direction: column;
            gap: rem(16);
        }
        &__title {
            font-size: lineScale(32, 24, 480, 1920);
        }
        &__desc {
            font-family: 'Inter', sans-serif;
            font-size: lineScale(16, 14, 480, 1920);
            line-height: 1.3;
            opacity: 0.5;
        }
        &__error {
            position: absolute;
            z-index: 5;
            top: 115%;
            left: -7%;
            display: flex;
            align-items: flex-start;
            gap: rem(8);
            font-size: rem(14);
            color: $c-FFFFFF;
            background-color: $c-082535;
            border-radius: rem(8);
            padding: rem(8) rem(16);
            &::before {
                content: '';
                position: absolute;
                z-index: -1;
                top: 0;
                left: 10%;
                width: rem(16);
                min-width: rem(16);
                aspect-ratio: 1;
                background-color: inherit;
                rotate: 45deg;
                translate: 0 -50%;
            }
            > span {
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: rem(12);
                color: $c-FFFFFF;
                width: rem(16);
                min-width: rem(16);
                aspect-ratio: 1;
                background-color: $c-accent;
                border-radius: 50%;
            }
        }
        &__form {
            font-family: 'Inter', sans-serif;
            display: flex;
            flex-direction: column;
        }
        &__inputbox {
            position: relative;
        }
        &__input {
            &--auth {
                width: 100%;
                font-size: lineScale(18, 16, 480, 1920);
                padding: rem(12) rem(24);
                background-color: rgba($c-D4E1E7, 0.25);
                border: rem(2) solid rgba($c-D4E1E7, 0.25) !important;
                border-radius: rem(32);
                transition:
                    background-color $td $tf,
                    color $td $tf,
                    border-color $td $tf;
                &::placeholder {
                    font-family: inherit;
                    font-size: inherit;
                    color: inherit;
                    opacity: 0.5;
                    transition: opacity $td $tf;
                }
                @media (pointer: fine) {
                    &:hover {
                        background-color: transparent;
                        border-color: $c-D4E1E7 !important;
                        &::placeholder {
                            opacity: 0.7;
                        }
                    }
                }
                &:focus,
                &:not(:placeholder-shown) {
                    background-color: transparent;
                    border-color: $c-accent !important;
                    &::placeholder {
                        opacity: 0.7;
                    }
                }
            }
        }
        &__button {
            margin-top: rem(32);
            justify-content: center;
            @include button-primary(
                $width: 100%,
                $gap: rem(8),
                $font-size: lineScale(18, 16, 480, 1920),
                $padding: rem(12) rem(40),
                $border-color: $c-D4E1E7,
                $anim-color: $c-accent
            );
        }
        &__agreement {
            position: relative;
            display: flex;
            gap: rem(8);
            margin-top: rem(16);
            &-checkbox {
                @include checkbox;
            }
            &-text {
                font-size: lineScale(14, 12, 480, 1920);
                font-weight: $fw-semi;
                line-height: 1.2;
                opacity: 0.5;
            }
        }
    }
</style>
