<template>
    <VueFinalModal
        overlay-transition="vfm-fade"
        content-transition="vfm-fade"
        @opened="setPhoneInputFocus"
    >
        <div class="modal-auth hide-scrollbar">
            <button class="modal-auth__close-btn" type="button" @click="emit('close')">
                <SvgSprite type="cross" :size="24" />
            </button>
            <div class="modal-auth__loading" v-if="isLoading">
                <LoadSpinner />
            </div>
            <div class="modal-auth__container">
                <div
                    :class="[
                        'modal-auth__step',
                        'modal-auth__step--auth',
                        { active: authStep === 'auth' },
                    ]"
                    :aria-hidden="authStep !== 'auth'"
                >
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
                                ref="phoneInput"
                                v-model="authData.phone"
                                id="auth-phone"
                                class="modal-auth__input modal-auth__input--auth"
                                mask="+7 (999) 999-99-99"
                                placeholder="+7 (___) ___-__-__"
                                name="auth-phone"
                                @focus="authErrors.phone = false"
                            />
                            <div v-if="authErrors.phone" class="modal-auth__error" style="left: 5%">
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
                            <div
                                v-if="authErrors.agreement"
                                class="modal-auth__error"
                                style="left: -8.5%"
                            >
                                <span>i</span>
                                <p>Без вашего согласия мы не сможем продолжить</p>
                            </div>
                        </label>
                    </form>
                </div>
                <div
                    :class="[
                        'modal-auth__step',
                        'modal-auth__step--otp',
                        { active: authStep === 'otp' },
                    ]"
                    :aria-hidden="authStep !== 'otp'"
                >
                    <div class="modal-auth__titlebox">
                        <span class="modal-auth__title">Введите код</span>
                        <p class="modal-auth__desc">
                            Отправили код на номер {{ partialHiddenPhone(authData.phone) }}
                        </p>
                        <button
                            type="button"
                            class="modal-auth__button--swch"
                            @click.prevent="authStep = 'auth'"
                        >
                            <span>
                                <SvgSprite type="arrow" :size="12" style="rotate: -180deg" />
                            </span>
                            <span>Изменить</span>
                        </button>
                    </div>
                    <form id="otp" class="modal-auth__form">
                        <InputOtp
                            v-model="authOtp.code"
                            id="auth-otp"
                            class="modal-auth__input modal-auth__input--otp"
                            :length="6"
                            integerOnly
                        >
                            <template #default="{ attrs, events, index }">
                                <input
                                    ref="otpInputs"
                                    v-bind="attrs"
                                    v-on="events"
                                    :id="`auth-otp-item-${index}`"
                                    type="text"
                                    :name="`auth-otp-item-${index}`"
                                    class="modal-auth__input--otp-item"
                                    placeholder="0"
                                    @input="submitOtp"
                                    @paste="submitOtp"
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
                            :disabled="!retryState.isAllowed"
                        >
                            <span>Отправить код повторно</span>
                            <span v-if="retryState.timer.length">{{ retryState.timer }}</span>
                        </button>
                        <p class="modal-auth__info" v-if="otpError && otpError.length">
                            {{ otpError }}
                        </p>
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
    type AuthStep = 'auth' | 'otp' | 'authorized';
    // =====================================================================

    // data ================================================================
    const cartStore = useCartStore();
    const { content: contacts } = useCms<IContacts>('contact');
    // =====================================================================

    // state ===============================================================
    const props = withDefaults(
        defineProps<{
            redirect?: string;
        }>(),
        {
            redirect: undefined,
        }
    );
    const emit = defineEmits<{
        (e: 'loggedIn'): void;
        (e: 'close'): void;
    }>();

    const userStore = useUserStore();

    const phoneInput = ref<{ $el: HTMLInputElement } | null>(null);
    const otpInputs = ref<HTMLInputElement[] | null>(null);

    const isLoading = ref(false);
    const authStep = ref<AuthStep>('auth');
    const retryTimerId = ref<NodeJS.Timeout | null>(null);

    const retryState = reactive({
        timer: '',
        isAllowed: true,
    });

    const authData = reactive({
        phone: '',
        agreement: true,
    });

    const authErrors = reactive({
        general: '',
        phone: false,
        agreement: false,
    });

    const otpError = ref('');

    const authOtp = reactive({
        code: '',
    });

    // =====================================================================

    // methods =============================================================
    function setPhoneInputFocus(): void {
        phoneInput?.value?.$el.focus();
    }

    function setRetryTimer(): void {
        if (retryTimerId.value !== null) {
            clearInterval(retryTimerId.value);
            retryTimerId.value = null;
        }

        let remainingSeconds = 120;

        const formatTime = (seconds: number): string => {
            const mins = Math.floor(seconds / 60);
            const secs = seconds % 60;
            return `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;
        };

        retryState.isAllowed = false;
        retryState.timer = formatTime(remainingSeconds);

        if (import.meta.client) {
            retryTimerId.value = setInterval(() => {
                remainingSeconds -= 1;

                if (remainingSeconds <= 0) {
                    clearInterval(retryTimerId.value!);
                    retryTimerId.value = null;

                    retryState.isAllowed = true;
                    retryState.timer = '';
                    return;
                }

                retryState.timer = formatTime(remainingSeconds);
            }, 1000);
        }
    }
    // =====================================================================

    // proccessing =========================================================
    const submitPhone = async (): Promise<void> => {
        isLoading.value = true;
        authOtp.code = '';
        if (!retryState.isAllowed && authStep.value === 'otp') {
            isLoading.value = false;
            return;
        }

        if (!authData.agreement || !authData.phone || !authData.phone.length) {
            if (!authData.agreement) authErrors.agreement = true;
            if (!authData.phone || !authData.phone.length) authErrors.phone = true;
            isLoading.value = false;
            return;
        } else {
            try {
                const res = await $fetch('/api/auth/sign-in', {
                    method: 'POST',
                    body: authData,
                });

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
                        authStep.value = 'otp';
                        if (otpInputs.value) otpInputs.value[0]?.focus();
                        setRetryTimer();
                        break;
                    case 208:
                        authStep.value = 'otp';
                        if (otpInputs.value) otpInputs.value[0]?.focus();
                        setRetryTimer();
                        break;
                    default:
                        authErrors.general = `Произошла непредвиденная ошибка, повторите попытку позже или свяжитесь с нами: ${contacts.value?.phone}`;
                        break;
                }
            } catch {
                authErrors.general = `Произошла непредвиденная ошибка, повторите попытку позже или свяжитесь с нами: ${contacts.value?.phone}`;
            } finally {
                isLoading.value = false;
            }
        }
    };

    const submitOtp = async (): Promise<void> => {
        if (authOtp.code.length !== 6) return;
        isLoading.value = true;
        try {
            const res = await $fetch('/api/auth/sign-up', {
                method: 'POST',
                body: {
                    phone: authData.phone,
                    code: authOtp.code,
                },
            });

            switch (res.status) {
                case 500:
                    otpError.value = `Произошла непредвиденная ошибка, повторите попытку позже или свяжитесь с нами: ${contacts.value?.phone}`;
                    break;
                case 400:
                    otpError.value = `Некорректный номер телефона, повторите попытку позже или свяжитесь с нами: ${contacts.value?.phone}`;
                    break;
                case 429:
                    otpError.value = `Достигнуто максимальное количество попыток, повторите попытку позже или свяжитесь с нами: ${contacts.value?.phone}`;
                    break;
                case 403:
                    otpError.value = 'Неверный код';
                    break;
                case 200:
                    authOtp.code = '';
                    userStore.setUser(res.user!);
                    if (props.redirect && props.redirect !== '/') {
                        navigateTo(props.redirect);
                    }
                    cartStore.mergeCart();
                    emit('loggedIn');
                    break;
                default:
                    otpError.value = `Произошла непредвиденная ошибка, повторите попытку позже или свяжитесь с нами: ${contacts.value?.phone}`;
                    break;
            }
        } catch {
            otpError.value = `Произошла непредвиденная ошибка, повторите попытку позже или свяжитесь с нами: ${contacts.value?.phone}`;
        } finally {
            isLoading.value = false;
        }
    };
    // =====================================================================

    watch(authStep, () => (authOtp.code = ''));

    onBeforeUnmount(() => {
        if (retryTimerId.value !== null) {
            clearInterval(retryTimerId.value);
        }
    });
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
            font-size: rem(12);
            line-height: 1.4;
            text-align: center;
            text-wrap: balance;
            margin-top: rem(16);
        }
        &__error {
            position: absolute;
            z-index: 5;
            top: 115%;
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
            background-color: $c-FFFFFF;
            transition: translate $td $tf;
            &--auth {
                position: relative;
                z-index: 2;
                &:not(.active) {
                    translate: -110% 0;
                    pointer-events: none;
                }
            }
            &--otp {
                position: absolute;
                z-index: 3;
                inset: 0;
                &:not(.active) {
                    translate: 110% 0;
                    pointer-events: none;
                }
            }
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
                    &:hover,
                    &:focus {
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
                width: 100%;
                display: flex;
                align-items: center;
                justify-content: space-between;
                gap: rem(8);
                &-item {
                    width: lineScale(56, 48, 480, 1920);
                    aspect-ratio: 1;
                    text-align: center;
                    font-size: lineScale(18, 16, 480, 1920);
                    border-radius: rem(12);
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
                &-divider {
                    width: rem(16);
                    height: rem(2);
                    background-color: $c-082535;
                    opacity: 0.5;
                }
            }
        }
        &__button {
            margin-top: rem(32);
            justify-content: center;
            &:disabled {
                pointer-events: none;
                opacity: 0.75;
            }
            &--swch {
                cursor: pointer;
                width: fit-content;
                display: flex;
                align-items: center;
                gap: rem(6);
                font-size: lineScale(16, 14, 480, 1920);
                font-weight: $fw-semi;
            }
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
