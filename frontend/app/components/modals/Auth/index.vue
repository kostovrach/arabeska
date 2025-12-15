<template>
    <VueFinalModal overlay-transition="vfm-fade" content-transition="vfm-fade">
        <div class="modal-auth">
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
                        'modal-auth__step--sign-in',
                        { active: step === 'sign-in' },
                    ]"
                    :aria-hidden="step !== 'sign-in'"
                    :aria-disabled="step !== 'sign-in'"
                    :inert="step !== 'sign-in'"
                >
                    <div class="modal-auth__titlebox">
                        <span class="modal-auth__title">Вход в личный кабинет</span>
                        <p class="modal-auth__desc">
                            Авторизуйтесь, чтобы смотреть свою историю заказов, копить баллы,
                            получать подарки и&nbsp;многое&nbsp;другое
                        </p>
                        <div class="modal-auth__switch">
                            <p>Еще нет аккаунта?</p>
                            <button
                                ref="signInStepButton"
                                type="button"
                                @click.prevent="setSignUpStep"
                            >
                                <span>Зарегистрироваться</span>
                                <span><SvgSprite type="arrow" :size="10" /></span>
                            </button>
                        </div>
                    </div>
                    <form id="sign-in" class="modal-auth__form">
                        <div class="modal-auth__inputbox">
                            <InputMask
                                id="sign-in-phone"
                                v-model="signInModel.phone"
                                class="modal-auth__input"
                                mask="+7 (999) 999-99-99"
                                placeholder="+7 (___) ___-__-__"
                                name="sign-in-phone"
                                @focus="signInErrors.phone = false"
                            />
                            <div
                                v-if="signInErrors.phone"
                                class="modal-auth__error"
                                style="left: 5%"
                            >
                                <span>i</span>
                                <p>Необходимо заполнить поле</p>
                            </div>
                        </div>
                        <div class="modal-auth__inputbox">
                            <input
                                id="sign-in-password"
                                v-model="signInModel.password"
                                class="modal-auth__input"
                                :type="isShowSignInPassword ? 'text' : 'password'"
                                name="sign-in-password"
                                placeholder="Пароль"
                                @focus="signInErrors.password = false"
                            />

                            <button
                                v-show="signInModel.password.length"
                                class="modal-auth__input-icon"
                                type="button"
                                @mousedown="isShowSignInPassword = true"
                                @mouseup="isShowSignInPassword = false"
                                @touchstart="isShowSignInPassword = true"
                                @touchcancel="isShowSignInPassword = false"
                            >
                                <SvgSprite type="eye" :size="22" />
                            </button>
                            <div
                                v-if="signInErrors.password"
                                class="modal-auth__error"
                                style="left: 5%"
                            >
                                <span>i</span>
                                <p>Необходимо заполнить поле</p>
                            </div>
                        </div>
                        <div class="modal-auth__pass-hint">
                            Забыли пароль?
                            <button type="button" @click="emit('openForgot')">Восстановить</button>
                        </div>
                        <button class="modal-auth__button" type="submit" @click.prevent="signIn">
                            <span>Отправить</span>
                        </button>
                        <p class="modal-auth__info" v-if="signInErrors.general.length">
                            {{ signInErrors.general }}
                        </p>
                        <label class="modal-auth__agreement" for="sign-in-agreement">
                            <div class="modal-auth__agreement-checkbox">
                                <input
                                    v-model="signInModel.agreement"
                                    id="sign-in-agreement"
                                    type="checkbox"
                                    name="sign-in-agreement"
                                    @input="signInErrors.agreement = false"
                                />
                            </div>
                            <p class="modal-auth__agreement-text">
                                Согласен с политикой конфиденциальности и обработки персональных
                                данных
                            </p>
                            <div
                                v-if="signInErrors.agreement"
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
                        'modal-auth__step--sign-up',
                        { active: step === 'sign-up' },
                    ]"
                    :aria-hidden="step !== 'sign-up'"
                    :aria-disabled="step !== 'sign-up'"
                    :inert="step !== 'sign-up'"
                >
                    <div class="modal-auth__titlebox">
                        <span class="modal-auth__title">Регистрация</span>
                        <p class="modal-auth__desc">
                            Создайте аккаунт, чтобы смотреть свою историю заказов, копить баллы,
                            получать подарки и&nbsp;многое&nbsp;другое
                        </p>
                        <div class="modal-auth__switch">
                            <p>Уже есть аккаунт?</p>
                            <button
                                ref="signUpStepButton"
                                type="button"
                                @click.prevent="setSignInStep"
                            >
                                <span>Вход</span>
                                <span><SvgSprite type="arrow" :size="10" /></span>
                            </button>
                        </div>
                    </div>
                    <form id="sign-up" class="modal-auth__form">
                        <div class="modal-auth__inputbox">
                            <InputMask
                                id="sign-up-phone"
                                v-model="signUpModel.phone"
                                class="modal-auth__input"
                                mask="+7 (999) 999-99-99"
                                placeholder="+7 (___) ___-__-__"
                                name="sign-up-phone"
                                @focus="signUpErrors.phone = false"
                            />
                            <div
                                v-if="signUpErrors.phone"
                                class="modal-auth__error"
                                style="left: 5%"
                            >
                                <span>i</span>
                                <p>Необходимо заполнить поле</p>
                            </div>
                        </div>
                        <div class="modal-auth__inputbox">
                            <input
                                id="sign-up-email"
                                v-model="signUpModel.email"
                                class="modal-auth__input"
                                type="email"
                                name="sign-up-email"
                                placeholder="E-mail"
                                @focus="signUpErrors.email = false"
                            />
                            <div
                                v-if="signUpErrors.email"
                                class="modal-auth__error"
                                style="left: 5%"
                            >
                                <span>i</span>
                                <p>Необходимо заполнить поле</p>
                            </div>
                        </div>
                        <div class="modal-auth__inputbox">
                            <input
                                id="sign-up-password"
                                v-model="signUpModel.password"
                                class="modal-auth__input"
                                :type="isShowSignUpPassword ? 'text' : 'password'"
                                name="sign-up-password"
                                placeholder="Пароль"
                                @focus="signUpErrors.password = false"
                            />
                            <button
                                v-show="signUpModel.password.length"
                                class="modal-auth__input-icon"
                                type="button"
                                @mousedown="isShowSignUpPassword = true"
                                @mouseup="isShowSignUpPassword = false"
                                @touchstart="isShowSignUpPassword = true"
                                @touchcancel="isShowSignUpPassword = false"
                            >
                                <SvgSprite type="eye" :size="22" />
                            </button>
                            <div
                                v-if="signUpErrors.password"
                                class="modal-auth__error"
                                style="left: 5%"
                            >
                                <span>i</span>
                                <p>Необходимо заполнить поле</p>
                            </div>
                        </div>
                        <button class="modal-auth__button" type="submit" @click.prevent="signUp">
                            <span>Отправить</span>
                        </button>
                        <p class="modal-auth__info" v-if="signUpErrors.general.length">
                            {{ signInErrors.general }}
                        </p>
                        <label class="modal-auth__agreement" for="sign-up-agreement">
                            <div class="modal-auth__agreement-checkbox">
                                <input
                                    v-model="signUpModel.agreement"
                                    id="sign-up-agreement"
                                    type="checkbox"
                                    name="sign-up-agreement"
                                    @input="signUpErrors.agreement = false"
                                />
                            </div>
                            <p class="modal-auth__agreement-text">
                                Согласен с политикой конфиденциальности и обработки персональных
                                данных
                            </p>
                            <div
                                v-if="signUpErrors.agreement"
                                class="modal-auth__error"
                                style="left: -8.5%"
                            >
                                <span>i</span>
                                <p>Без вашего согласия мы не сможем продолжить</p>
                            </div>
                        </label>
                    </form>
                </div>
            </div>
        </div>
    </VueFinalModal>
</template>

<script setup lang="ts">
    import { VueFinalModal } from 'vue-final-modal';
    import type { IContacts } from '~~/interfaces/contacts';

    const emit = defineEmits<{
        (e: 'close'): void;
        (e: 'loggedIn'): void;
        (e: 'openForgot'): void;
    }>();

    // State ===============================================================
    const props = withDefaults(
        defineProps<{
            redirect?: string;
        }>(),
        {
            redirect: undefined,
        }
    );

    const isLoading = ref(false);
    const isShowSignInPassword = ref(false);
    const isShowSignUpPassword = ref(false);
    const step = ref<'sign-in' | 'sign-up'>('sign-in');

    // Refs
    const signInStepButton = ref<HTMLButtonElement | null>(null);
    const signUpStepButton = ref<HTMLButtonElement | null>(null);

    // Sign-in model
    const signInModel = reactive({
        phone: '',
        password: '',
        agreement: true,
    });
    const signInErrors = reactive({
        phone: false,
        password: false,
        agreement: false,
        general: '',
    });

    // Sign-up model
    const signUpModel = reactive({
        phone: '',
        email: '',
        password: '',
        agreement: true,
    });
    const signUpErrors = reactive({
        phone: false,
        email: false,
        password: false,
        agreement: false,
        general: '',
    });
    // =====================================================================

    // data ================================================================
    const cartStore = useCartStore();
    const userStore = useUserStore();
    const { content: contacts } = await useCms<IContacts>('contact');
    // =====================================================================

    // methods =============================================================
    function setSignUpStep(): void {
        signInStepButton.value?.blur();
        step.value = 'sign-up';
    }

    function setSignInStep(): void {
        signUpStepButton.value?.blur();
        step.value = 'sign-in';
    }
    // =====================================================================

    // processing ==========================================================
    async function signIn(): Promise<void> {
        isLoading.value = true;

        if (!signInModel.phone.length || !signInModel.password.length || !signInModel.agreement) {
            if (!signInModel.phone.length) signInErrors.phone = true;
            if (!signInModel.password.length) signInErrors.password = true;
            if (!signInModel.agreement) signInErrors.agreement = true;
            isLoading.value = false;
            return;
        }

        try {
            const res = await $fetch('/api/auth/sign-in', {
                method: 'POST',
                body: signInModel,
            });

            switch (res.status) {
                case 400:
                    signInErrors.general = 'Некорректный номер телефона';
                    break;
                case 500:
                    signInErrors.general = `Произошла непредвиденная ошибка, повторите попытку позже или свяжитесь с нами: ${contacts.value?.phone}`;
                    break;
                case 401:
                    signInErrors.general = 'Некорректные данные';
                    break;
                case 429:
                    signInErrors.general =
                        'Вы ввели пароль неправильно слишком много раз, пожалуйста, повторите попытку позже';
                    break;
                case 200:
                    userStore.setUser(res.user!);
                    cartStore.mergeCart();
                    if (props.redirect && props.redirect !== '/') {
                        navigateTo(props.redirect);
                    }
                    emit('loggedIn');
                    break;
            }
        } catch {
            signInErrors.general = `Произошла непредвиденная ошибка, повторите попытку позже или свяжитесь с нами: ${contacts.value?.phone}`;
        } finally {
            isLoading.value = false;
        }
    }

    async function signUp(): Promise<void> {
        isLoading.value = true;

        if (
            !signUpModel.phone.length ||
            !signUpModel.password.length ||
            !signUpModel.email.length ||
            !signUpModel.agreement
        ) {
            if (!signUpModel.phone.length) signUpErrors.phone = true;
            if (!signUpModel.email.length) signUpErrors.email = true;
            if (!signUpModel.password.length) signUpErrors.password = true;
            if (!signUpModel.agreement) signUpErrors.agreement = true;
            isLoading.value = false;
            return;
        }

        if (signUpModel.password.length < 10) {
            signUpErrors.general = 'Пароль должен содержать не менее 10 символов';
            isLoading.value = false;
            return;
        }

        try {
            const res = await $fetch('/api/auth/sign-up', {
                method: 'POST',
                body: signUpModel,
            });

            switch (res.status) {
                case 400:
                    if (res.message === 'Invalid email')
                        signUpErrors.general = `Некорректный E-mail`;
                    if (res.message === 'Invalid phone number')
                        signUpErrors.general = `Некорректный номер телефона`;
                    break;
                case 500:
                    signUpErrors.general = `Произошла непредвиденная ошибка, повторите попытку позже или свяжитесь с нами: ${contacts.value?.phone}`;
                    break;
                case 409:
                    signUpErrors.general = `Пользователь с таким номером уже существует, попробуйте войти в аккаунт`;
                    break;
                case 200:
                    userStore.setUser(res.user!);
                    cartStore.mergeCart();
                    if (props.redirect && props.redirect !== '/') {
                        navigateTo(props.redirect);
                    }
                    emit('loggedIn');
                    break;
            }
        } catch {
            signUpErrors.general = `Произошла непредвиденная ошибка, повторите попытку позже или свяжитесь с нами: ${contacts.value?.phone}`;
        } finally {
            isLoading.value = false;
        }
    }
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
            pointer-events: none;
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
            &--sign-in {
                position: absolute;
                z-index: 2;
                &:not(.active) {
                    translate: -110% 0;
                    pointer-events: none;
                }
            }
            &--sign-up {
                position: relative;
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
            display: flex;
            gap: rem(8);
            font-size: rem(14);
            margin-top: rem(32);
            > button {
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: rem(4);
                color: $c-accent;
                text-decoration: underline;
                @media (pointer: fine) {
                    &:hover {
                        text-decoration: none;
                    }
                }
            }
        }
        &__form {
            font-family: 'Inter', sans-serif;
            display: flex;
            flex-direction: column;
        }
        &__inputbox {
            position: relative;
            &:not(:first-of-type) {
                margin-top: rem(16);
            }
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
                translate: 0 -45%;
                color: $c-98BBD7;
                opacity: 0.75;
            }
        }
        &__pass-hint {
            align-self: flex-end;
            font-family: 'Inter', sans-serif;
            font-size: rem(14);
            opacity: 0.75;
            margin-top: rem(8);
            > button,
            a {
                cursor: pointer;
                text-decoration: underline;
                color: $c-accent;
                @media (pointer: fine) {
                    &:hover {
                        text-decoration: none;
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
            &:disabled {
                pointer-events: none;
                opacity: 0.75;
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
        .modal-auth {
            &__step {
                display: flex;
                flex-direction: column;
            }
        }
    }
</style>
