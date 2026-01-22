<template>
    <VueFinalModal
        overlay-transition="vfm-fade"
        content-transition="vfm-fade"
        @opened="
            () => {
                initSavedStep();
                setEmailInputFocus();
            }
        "
    >
        <div class="modal-forgot">
            <button class="modal-forgot__close-btn" type="button" @click="emit('close')">
                <SvgSprite type="cross" :size="24" />
            </button>
            <div class="modal-forgot__loading" v-if="isLoading">
                <LoadSpinner />
            </div>
            <div class="modal-forgot__container">
                <div class="modal-forgot__titlebox">
                    <span class="modal-forgot__title">Восстановление пароля</span>
                    <div class="modal-forgot__desc">
                        <p v-if="step === 'email'">
                            Мы отправим на почту код подтверждения, после чего можно будет ввести
                            новый пароль для входа в личный кабинет
                        </p>
                        <p v-else-if="step === 'otp'">
                            Отправили код подтверждения на почту {{ formData.email }}
                        </p>
                        <p v-else-if="step === 'password'">
                            Придумайте новый пароль для входа в личный кабинет
                        </p>
                    </div>
                    <button
                        v-if="step === 'otp'"
                        class="modal-forgot__switch"
                        type="button"
                        @click.prevent="
                            () => {
                                setStep('email');
                                setEmailInputFocus();
                            }
                        "
                    >
                        <span>
                            <SvgSprite type="arrow" :size="12" style="rotate: -180deg" />
                        </span>
                        <span>Изменить</span>
                    </button>
                </div>
                <div class="modal-forgot__body">
                    <form
                        :class="[
                            'modal-forgot__step',
                            'modal-forgot__step--email',
                            { active: step === 'email' },
                        ]"
                    >
                        <div class="modal-forgot__inputbox">
                            <input
                                ref="emailInput"
                                id="forgot-email"
                                v-model="formData.email"
                                class="modal-forgot__input"
                                type="email"
                                name="forgot-email"
                                placeholder="E-mail"
                                @focus="formErrors.email = false"
                            />
                            <FormNotifyInfo
                                v-if="formErrors.email"
                                :position="{ top: '100%', left: '5%' }"
                            >
                                Необходимо заполнить поле
                            </FormNotifyInfo>
                        </div>
                        <FormNotifyError v-if="formErrors.general.length">
                            {{ formErrors.general }}
                        </FormNotifyError>
                        <button
                            class="modal-forgot__button"
                            type="submit"
                            @click.prevent="submitEmail"
                        >
                            <span>Получить код</span>
                        </button>
                        <label class="modal-forgot__agreement" for="forgot-agreement">
                            <div class="modal-forgot__agreement-checkbox">
                                <input
                                    v-model="formData.agreement"
                                    id="forgot-agreement"
                                    type="checkbox"
                                    name="forgot-agreement"
                                    @input="formErrors.agreement = false"
                                />
                            </div>
                            <p class="modal-forgot__agreement-text">
                                Согласен с политикой конфиденциальности и обработки персональных
                                данных
                            </p>
                            <FormNotifyInfo
                                v-if="formErrors.agreement"
                                :position="{ top: '100%', left: '-8.5%' }"
                            >
                                Без вашего согласия мы не сможем продолжить
                            </FormNotifyInfo>
                        </label>
                    </form>
                    <form
                        :class="[
                            'modal-forgot__step',
                            'modal-forgot__step--otp',
                            { active: step === 'otp' },
                            { skip: step === 'password' },
                        ]"
                    >
                        <div class="modal-forgot__inputbox">
                            <InputOtp
                                v-model="formData.code"
                                id="forgot-otp"
                                class="modal-forgot__input--otp"
                                :length="6"
                                integerOnly
                            >
                                <template #default="{ attrs, events, index }">
                                    <input
                                        ref="otpInputs"
                                        v-bind="attrs"
                                        v-on="events"
                                        :id="`forgot-otp-item-${index}`"
                                        type="number"
                                        :name="`forgot-otp-item-${index}`"
                                        class="modal-forgot__input--otp-item"
                                        placeholder="0"
                                        @input="submitOtp"
                                        @paste="submitOtp"
                                    />
                                    <span
                                        v-if="index === 3"
                                        class="modal-forgot__input--otp-divider"
                                    ></span>
                                </template>
                            </InputOtp>
                        </div>
                        <FormNotifyError v-if="formErrors.general.length">
                            {{ formErrors.general }}
                        </FormNotifyError>
                        <button
                            class="modal-forgot__button modal-forgot__button--otp"
                            type="submit"
                            @click.prevent="submitEmail"
                            :disabled="!retryState.isAllowed"
                        >
                            <span>Отправить код повторно</span>
                            <span v-if="retryState.timer.length">{{ retryState.timer }}</span>
                        </button>
                    </form>
                    <form
                        :class="[
                            'modal-forgot__step',
                            'modal-forgot__step--pass',
                            { active: step === 'password' },
                        ]"
                    >
                        <div class="modal-forgot__inputbox">
                            <input
                                id="forgot-password"
                                v-model="formData.password"
                                class="modal-forgot__input"
                                :type="isShowPassword ? 'text' : 'password'"
                                name="forgot-password"
                                placeholder="Пароль"
                                @focus="formErrors.password = false"
                            />
                            <button
                                v-show="formData.password.length"
                                class="modal-forgot__input-icon"
                                type="button"
                                @mousedown="isShowPassword = true"
                                @mouseup="isShowPassword = false"
                                @touchstart="isShowPassword = true"
                                @touchcancel="isShowPassword = false"
                            >
                                <SvgSprite type="eye" :size="22" />
                            </button>
                            <FormNotifyInfo
                                v-if="formErrors.password"
                                :position="{ top: '100%', left: '5%' }"
                            >
                                Необходимо заполнить поле
                            </FormNotifyInfo>
                        </div>
                        <FormNotifyError v-if="formErrors.general.length">
                            {{ formErrors.general }}
                        </FormNotifyError>
                        <button
                            class="modal-forgot__button"
                            type="submit"
                            @click.prevent="submitPassword"
                        >
                            <span>Отправить</span>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </VueFinalModal>
</template>

<script setup lang="ts">
    import { VueFinalModal } from 'vue-final-modal';
    import type { IContacts } from '~~/interfaces/contacts';

    // data ================================================================
    const cartStore = useCartStore();
    const userStore = useUserStore();
    const { content: contacts } = await useCms<IContacts>('contact');
    // =====================================================================

    // State ============================================================
    const emit = defineEmits<{
        (e: 'close'): void;
        (e: 'loggedIn'): void;
    }>();

    const STORAGE_KEY = 'forgot-step';

    const isLoading = ref(false);
    const isShowPassword = ref(false);
    const step = ref<'email' | 'otp' | 'password'>('email');

    const retryTimerId = ref<NodeJS.Timeout | null>(null);

    const retryState = reactive({
        timer: '',
        isAllowed: true,
    });
    // ==================================================================

    // Refs =============================================================
    const emailInput = ref<HTMLInputElement | null>(null);
    const otpInputs = ref<{ $el: HTMLInputElement }[] | null>(null);
    // ==================================================================

    // Model ============================================================
    const formData = reactive({
        email: '',
        code: '',
        password: '',
        agreement: true,
    });

    const formErrors = reactive({
        email: false,
        code: false,
        password: false,
        agreement: false,
        general: '',
    });
    // ==================================================================

    // Methods ==========================================================
    function setEmailInputFocus(): void {
        if (!emailInput.value) return;
        emailInput.value.focus();
    }

    function setOtpInputFocus(): void {
        if (!otpInputs.value) return;
        otpInputs.value[0]?.$el.focus();
    }

    function setStep(targetStep: typeof step.value) {
        step.value = targetStep;
        localStorage.setItem(
            STORAGE_KEY,
            JSON.stringify({ step: targetStep, email: formData.email })
        );
    }

    function initSavedStep(): void {
        const savedStep = localStorage.getItem(STORAGE_KEY);
        if (savedStep) {
            const parsedStep = JSON.parse(savedStep) as { step: typeof step.value; email: string };
            if (parsedStep.email.length) {
                step.value = parsedStep.step;
                formData.email = parsedStep.email;
            }
        }
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
    // ==================================================================

    // Proccessing ======================================================
    const errorFallbackText = `Произошла непредвиденная ошибка, повторите попытку позже или свяжитесь с нами: ${contacts.value?.phone}`;

    async function submitEmail(): Promise<void> {
        if (!formData.email.length || !formData.agreement) {
            if (!formData.email.length) formErrors.email = true;
            if (!formData.agreement) formErrors.agreement = true;
            return;
        }

        isLoading.value = true;

        try {
            const res = await $fetch('/api/forgot-password', {
                method: 'POST',
                body: formData,
            });

            if (res.success) {
                setStep('otp');
                setRetryTimer();
                setOtpInputFocus();
            } else {
                formErrors.general = res.message ?? errorFallbackText;
            }
        } catch {
            formErrors.general = errorFallbackText;
        } finally {
            isLoading.value = false;
        }
    }

    async function submitOtp(): Promise<void> {
        if (formData.code.length !== 6) return;
        isLoading.value = true;

        try {
            const res = await $fetch('/api/forgot-password/verify-otp', {
                method: 'POST',
                body: formData,
            });

            if (res.success) {
                formData.code = '';
                setStep('password');
            } else {
                formErrors.general = res.message ?? errorFallbackText;
            }
        } catch {
            formErrors.general = errorFallbackText;
        } finally {
            isLoading.value = false;
        }
    }

    async function submitPassword(): Promise<void> {
        if (formData.password.length < 10) {
            formErrors.general =
                'Слишком короткий пароль. Пароль должен содержать не менее 10 символов';
            return;
        }
        isLoading.value = true;

        try {
            const res = await $fetch('/api/forgot-password/set-password', {
                method: 'POST',
                body: formData,
            });

            if (res.success) {
                userStore.setUser(res.user!);
                cartStore.mergeCart();
                localStorage.removeItem(STORAGE_KEY);
                navigateTo('/');
                emit('close');
                emit('loggedIn');
            } else {
                formErrors.general = res.message ?? errorFallbackText;
            }
        } catch {
            formErrors.general = errorFallbackText;
        } finally {
            isLoading.value = false;
        }
    }
    // ==================================================================

    watch(step, () => {
        formErrors.general = '';
    });

    onBeforeUnmount(() => {
        if (retryTimerId.value !== null) {
            clearInterval(retryTimerId.value);
        }
    });
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .modal-forgot {
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
        @include hide-scrollbar;
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
        &__container {
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
            margin-top: rem(16);
        }
        &__switch {
            cursor: pointer;
            width: fit-content;
            display: flex;
            align-items: center;
            gap: rem(6);
            font-size: lineScale(16, 14, 480, 1920);
            font-weight: $fw-semi;
        }
        &__body {
            position: relative;
        }
        &__step {
            background-color: $c-FFFFFF;
            transition: translate $td $tf;
            font-family: 'Inter', sans-serif;
            display: flex;
            flex-direction: column;
            gap: rem(16);
            &--email {
                position: relative;
                z-index: 2;
                &:not(.active) {
                    translate: 0 -150%;
                    pointer-events: none;
                }
            }
            &--otp {
                position: absolute;
                z-index: 3;
                inset: 0;
                &:not(.active) {
                    translate: 0 150%;
                    pointer-events: none;
                }
                &.skip {
                    translate: 0 -150%;
                    pointer-events: none;
                }
            }
            &--pass {
                position: absolute;
                z-index: 4;
                inset: 0;
                &:not(.active) {
                    translate: 0 150%;
                    pointer-events: none;
                }
            }
        }
        &__inputbox {
            position: relative;
        }
        &__input {
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
                }
            }
            &:focus,
            &:not(:placeholder-shown) {
                background-color: transparent;
                border-color: $c-accent !important;
            }
            &-icon {
                cursor: pointer;
                position: absolute;
                top: 50%;
                right: rem(20);
                translate: 0 -50%;
                color: $c-98BBD7;
                opacity: 0.75;
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
            justify-content: center;
            @include button-primary(
                $width: 100%,
                $gap: rem(8),
                $font-size: lineScale(18, 16, 480, 1920),
                $padding: rem(12) rem(40),
                $border-color: $c-D4E1E7,
                $anim-color: $c-accent
            );
            &:disabled {
                pointer-events: none;
                opacity: 0.75;
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

    @media (max-width: 768px) {
        .modal-forgot {
            &__container {
                display: flex;
                flex-direction: column;
            }
            &__step {
                &--email {
                    &:not(.active) {
                        translate: -150% 0;
                        pointer-events: none;
                    }
                }
                &--otp {
                    &:not(.active) {
                        translate: 150% 0;
                        pointer-events: none;
                    }
                    &.skip {
                        translate: -150% 0;
                        pointer-events: none;
                    }
                }
                &--pass {
                    &:not(.active) {
                        translate: 0 150%;
                        pointer-events: none;
                    }
                }
            }
        }
    }
</style>
