<template>
    <VueFinalModal overlay-transition="vfm-fade" content-transition="vfm-fade">
        <div class="modal-auth hide-scrollbar">
            <button class="modal-auth__close-btn" type="button" @click="emit('close')">
                <SvgSprite type="cross" :size="24" />
            </button>
            <div class="modal-auth__loading" v-if="isLoading">
                <LoadSpinner />
            </div>
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
                        <button
                            class="modal-auth__button modal-auth__button--auth"
                            type="submit"
                            @click.prevent="submitPhone"
                        >
                            <span>Получить код</span>
                        </button>
                        <p
                            class="modal-auth__info"
                            v-if="authErrors.general && authErrors.general.length"
                        >
                            {{ authErrors.general }}
                        </p>
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
                <div class="modal-auth__step modal-auth__step--otp">
                    <div class="modal-auth__titlebox">
                        <span class="modal-auth__title">Введите код</span>
                        <p class="modal-auth__desc">
                            Отправили код на номер {{ partialHiddenPhone(authData.phone) }}
                        </p>
                        <button type="button" class="modal-auth__button-swch">
                            <span>
                                <SvgSprite type="arrow" :size="14" style="rotate: -180deg" />
                            </span>
                            <span>Изменить</span>
                        </button>
                    </div>
                    <form id="otp" class="modal-auth__form">
                        {{ authOtp.code }}
                        <InputOtp
                            v-model="authOtp.code"
                            id="auth-otp"
                            class="modal-auth__input modal-auth__input--otp"
                            :length="6"
                            integerOnly
                        >
                            <template #default="{ attrs, events, index }">
                                <input
                                    v-bind="attrs"
                                    v-on="events"
                                    :id="`auth-otp-item-${index}`"
                                    type="text"
                                    :name="`auth-otp-item-${index}`"
                                    class="modal-auth__input--otp-item"
                                    placeholder="0"
                                />
                                <span
                                    v-if="index === 3"
                                    class="modal-auth__input--otp-divider"
                                ></span>
                            </template>
                        </InputOtp>
                        <button
                            class="modal-auth__button modal-auth__button--otp"
                            type="submit"
                            @click.prevent="submitPhone"
                        >
                            <span>Отправить код повторно</span>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </VueFinalModal>
</template>

<script setup lang="ts">
    import { VueFinalModal } from 'vue-final-modal';

    // types ===============================================================
    import type { IContacts } from '~~/interfaces/contacts';
    // =====================================================================

    // data ================================================================
    const { content: contacts } = useCms<IContacts>('contact');
    // =====================================================================

    // state ===============================================================
    const emit = defineEmits<{
        (e: 'close'): void;
    }>();

    const isLoading = ref(false);
    const step = ref<'auth' | 'otp'>('auth');

    const authData = reactive({
        phone: '',
        agreement: true,
    });

    const authErrors = reactive({
        general: '',
        phone: false,
        agreement: false,
    });

    const authOtp = reactive({
        code: '',
    });

    // =====================================================================

    // proccessing =========================================================
    const submitPhone = async () => {
        isLoading.value = true;
        if (!authData.agreement || !authData.phone || !authData.phone.length) {
            if (!authData.agreement) authErrors.agreement = true;
            if (!authData.phone || !authData.phone.length) authErrors.phone = true;
            isLoading.value = false;
            return;
        } else {
            try {
                const res = await $fetch<{ status: number; error?: string; success: boolean }>(
                    '/api/auth/send-otp',
                    {
                        method: 'POST',
                        body: authData,
                    }
                );
                switch (res.status) {
                    case 500:
                        authErrors.general = `Произошла непредвиденная ошибка, повторите попытку позже или свяжитесь с нами: ${contacts.value?.phone}`;
                        break;
                    case 400:
                        authErrors.general = `Некорректный номер телефона, повторите попытку позже или свяжитесь с нами: ${contacts.value?.phone}`;
                        break;
                    case 429:
                        authErrors.general =
                            'Слишком частые запросы запрещены, повторите попытку через 60 секунд';
                        break;
                    case 200:
                        authData.phone = '';
                    default:
                        authErrors.general = '';
                        break;
                }
            } catch {
                authErrors.general = `Произошла непредвиденная ошибка, повторите попытку позже или свяжитесь с нами: ${contacts.value?.phone}`;
            } finally {
                isLoading.value = false;
            }
        }
    };
    // =====================================================================
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
            z-index: 5;
            top: rem(16);
            right: rem(16);
            @include close-button($position: absolute);
        }
        &__loading {
            position: absolute;
            z-index: 6;
            inset: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: rgba($c-000000, 0.5);
        }
        &__info {
            color: $c-F5142B;
            font-size: rem(1);
            line-height: 1.4;
            text-align: center;
            text-wrap: balance;
            margin-top: rem(16);
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
            &--otp {
                display: flex;
                align-items: center;
                gap: rem(8);
                &-item {
                    width: lineScale(64, 48, 480, 1920);
                    aspect-ratio: 1;
                    text-align: center;
                    font-size: lineScale(18, 16, 480, 1920);
                    border-radius: rem(16);
                    background-color: rgba($c-D4E1E7, 0.25);
                    border: rem(2) solid transparent;
                    &::placeholder {
                        opacity: 0;
                    }
                    &:focus {
                        border-color: $c-accent;
                        background-color: transparent;
                    }
                    &:not(:placeholder-shown) {
                        border-color: $c-98BBD7;
                        background-color: transparent;
                    }
                }
            }
        }
        &__button {
            margin-top: rem(32);
            justify-content: center;
            &--auth {
                @include button-primary(
                    $width: 100%,
                    $gap: rem(8),
                    $font-size: lineScale(18, 16, 480, 1920),
                    $padding: rem(12) rem(40),
                    $border-color: $c-D4E1E7,
                    $anim-color: $c-accent
                );
            }
            &--otp {
                @include button-primary(
                    $width: 100%,
                    $gap: rem(8),
                    $font-size: lineScale(18, 16, 480, 1920),
                    $color: $c-FFFFFF,
                    $padding: rem(12) rem(40),
                    $background: $c-082535,
                    $border-color: transparent,
                    $anim-border-color: $c-FFFFFF,
                    $anim-color: $c-accent
                );
            }
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
