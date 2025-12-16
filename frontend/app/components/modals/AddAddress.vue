<template>
    <VueFinalModal
        overlay-transition="vfm-fade"
        content-transition="vfm-slide-down"
        swipe-to-close="down"
        content-class="modal-address"
    >
        <div class="modal-address__container">
            <div class="modal-address__loader" v-if="isLoading">
                <LoadSpinner />
            </div>
            <div class="modal-address__wrapper">
                <button class="modal-address__close-btn" type="button" @click="close"></button>

                <h2 class="modal-address__title">Добавить адрес доставки</h2>
                <form class="modal-address__form">
                    <div class="modal-address__inputbox">
                        <AutoComplete
                            input-id="address-street"
                            v-model="address.street"
                            class="modal-address__autocomplete"
                            input-class="modal-address__autocomplete-input"
                            overlay-class="modal-address__autocomplete-suggest"
                            empty-search-message="К сожалению, совпадений не найдено"
                            unstyled
                            placeholder="Введите адрес"
                            :suggestions="
                                suggestResponse?.map((el) => el.address?.formattedAddress) ?? []
                            "
                            @complete="suggestOnSearch"
                            @focus="errors.address = false"
                        >
                            <template #option="{ option }">
                                <button class="modal-address__autocomplete-option" type="button">
                                    {{ option }}
                                </button>
                            </template>
                        </AutoComplete>
                        <div v-if="errors.address" class="modal-address__error" style="left: 5%">
                            <span>i</span>
                            <p>Необходимо заполнить поле</p>
                        </div>
                    </div>
                    <div class="modal-address__inputbox">
                        <input
                            id="address-flat"
                            v-model="address.flat"
                            class="modal-address__input"
                            type="number"
                            placeholder="Квартира"
                        />
                    </div>
                    <div class="modal-address__inputbox">
                        <input
                            id="address-doorway"
                            v-model="address.doorway"
                            class="modal-address__input"
                            type="number"
                            placeholder="Подъезд"
                        />
                    </div>
                    <div class="modal-address__inputbox">
                        <input
                            id="address-floor"
                            v-model="address.floor"
                            class="modal-address__input"
                            type="number"
                            placeholder="Этаж"
                        />
                    </div>
                    <button class="modal-address__button" type="submit" @click.prevent="submit">
                        <span>Добавить</span>
                    </button>
                    <p class="modal-address__info" v-if="errors.general.length">
                        {{ errors.general }}
                    </p>
                </form>
            </div>
            <YandexMap
                v-show="false"
                :settings="{
                    location: { center: [11, 11], zoom: 10 },
                }"
            />
        </div>
    </VueFinalModal>
</template>

<script setup lang="ts">
    import { YandexMap } from 'vue-yandex-maps';
    import { VueFinalModal } from 'vue-final-modal';

    import type { IUserAddress } from '~~/interfaces/entities/user-address';
    import type { LngLat, SuggestResponse } from '@yandex/ymaps3-types';

    const emit = defineEmits<{
        (e: 'close'): void;
    }>();

    const userStore = useUserStore();

    const user = computed(() => userStore.user);

    const isLoading = ref(false);

    const errors = reactive({
        address: false,
        general: '',
    });

    const address: IUserAddress = reactive({
        id: '',
        street: '',
        flat: '',
        doorway: '',
        floor: '',
    });

    // geosuggest state =================================================
    const suggestResponse = shallowRef<null | SuggestResponse>(null);
    const selectedSuggest = ref<LngLat | null>(null);

    const suggestOnSearch = useDebounceFn(async () => {
        if (!address.street.length) return;

        const existing = suggestResponse.value?.find((el) => el.subtitle?.text === address.street);

        if (existing) {
            const afterSuggestSearch = await ymaps3.search({
                text: address.street,
                type: ['toponyms'],
            });
            if (afterSuggestSearch[0]?.geometry?.coordinates) {
                selectedSuggest.value = afterSuggestSearch[0].geometry.coordinates;
                return;
            }
        }

        suggestResponse.value = await ymaps3.suggest({
            text: address.street,
            types: ['street', 'house'],
        });
    }, 300);
    // ==================================================================

    // Methods ==========================================================
    function close(): void {
        errors.address = false;
        errors.general = '';

        address.id = '';
        address.street = '';
        address.doorway = '';
        address.flat = '';
        address.floor = '';
        emit('close');
    }

    async function submit(): Promise<void> {
        if (!address.street.length) {
            errors.address = true;
            return;
        }
        if (!user.value) {
            errors.general = 'Ошибка, сначала войдите в аккаунт';
            return;
        }

        isLoading.value = true;

        try {
            const id = Date.now().toString();
            address.id = id;

            const res = await userStore.updateUser({
                id: user.value.id,
                addresses: [...user.value.addresses, address],
            });

            if (res.ok) {
                close();
            } else {
                errors.general =
                    'Произошла непредвиденная ошибка, попробуйте повторить попытку позже';
            }
        } catch {
            errors.general = 'Произошла непредвиденная ошибка, попробуйте повторить попытку позже';
        } finally {
            isLoading.value = false;
        }
    }
    // ==================================================================
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    @mixin input() {
        width: 100%;
        font-family: 'Inter', sans-serif;
        font-size: lineScale(20, 18, 480, 1920);
        padding: rem(12) rem(24);
        background-color: rgba($c-D4E1E7, 0.25);
        border: rem(2) solid rgba($c-D4E1E7, 0.25) !important;
        border-radius: rem(32);
        color: rgba($c-082535, 0.7);
        transition:
            background-color $td $tf,
            color $td $tf,
            border-color $td $tf;
        &::placeholder {
            font-family: inherit;
            font-size: inherit;
            color: $c-082535;
            opacity: 0.3;
            transition: opacity $td $tf;
        }
        @media (pointer: fine) {
            &:hover {
                background-color: transparent;
                border-color: $c-D4E1E7 !important;
                &::placeholder {
                    opacity: 0.5;
                }
            }
        }
        &:focus,
        &:not(:placeholder-shown) {
            background-color: transparent;
            border-color: $c-accent !important;
            color: $c-082535;
            &::placeholder {
                opacity: 0.5;
            }
        }
    }
    .modal-address {
        $p: &;

        position: relative;
        width: 100vw;
        height: 100lvh;
        pointer-events: none;
        &__container {
            position: absolute;
            width: 100%;
            max-height: 100lvh;
            bottom: 0;
            left: 0;
            background-color: $c-FFFFFF;
            padding: 0 rem(32) rem(64);
            border-radius: rem(32) rem(32) 0 0;
            overflow-y: auto;
            overflow-x: hidden;
            pointer-events: auto;
            @include hide-scrollbar;
        }
        &__wrapper {
            position: relative;
            max-width: rem(640);
            margin: 0 auto;
        }
        &__close-btn {
            cursor: pointer;
            position: relative;
            width: rem(64);
            aspect-ratio: 2/1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: rem(8) 0 rem(16);
            margin: 0 auto;
            transition: all $td $tf 0s;
            @media (pointer: fine) {
                &:hover {
                    &::before {
                        rotate: 30deg;
                        translate: rem(4) 0;
                    }
                    &::after {
                        rotate: -30deg;
                        translate: rem(-4) 0;
                    }
                }
            }
            &:active {
                scale: 0.95;
                opacity: 0.5;
                &::before {
                    rotate: 20deg;
                    translate: rem(1) 0;
                }
                &::after {
                    rotate: -20deg;
                    translate: rem(-1) 0;
                }
            }
            &::before,
            &::after {
                content: '';
                display: block;
                width: rem(32);
                height: rem(4);
                background-color: $c-D4E1E7;
                border-radius: rem(32);
                transition: all $td $tf;
            }
            &::before {
                rotate: 15deg;
                transform-origin: left;
                transform: translateX(rem(2));
            }
            &::after {
                rotate: -15deg;
                transform-origin: right;
                transform: translateX(rem(-2));
            }
        }
        &__loader {
            position: absolute;
            z-index: 5;
            inset: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: rgba($c-082535, 0.4);
        }
        &__title {
            font-size: lineScale(32, 20, 480, 1920);
        }
        &__info {
            grid-column: span 3;
            color: $c-F5142B;
            font-size: rem(12);
            line-height: 1.4;
            text-align: center;
            text-wrap: balance;
            margin-top: rem(16);
        }
        &__form {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: rem(8) rem(16);
            font-family: 'Inter', sans-serif;
            margin-top: rem(40);
        }
        &__inputbox {
            position: relative;
            &:first-child {
                grid-column: span 3;
            }
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
        &__input {
            @include input();
        }
        &__autocomplete {
            &-input {
                @include input();
            }
            &-suggest {
                font-family: 'Inter', sans-serif;
                font-size: lineScale(16, 14, 480, 1920);
                background-color: $c-FFFFFF;
                border: rem(2) solid rgba($c-D4E1E7, 0.7);
                border-radius: rem(32);
                max-height: rem(240);
                overflow-y: auto;
                overflow-x: hidden;
                @include hide-scrollbar;
            }
            &-option {
                cursor: pointer;
                box-sizing: border-box;
                display: block;
                width: 100%;
                padding: rem(12) rem(24);
                background-color: transparent;
                border-top: rem(1) solid rgba($c-D4E1E7, 0.25);
                &:focus {
                    background-color: $c-accent;
                }
                @media (pointer: fine) {
                    &:hover {
                        background-color: $c-accent;
                    }
                }
            }
        }
        &__button {
            grid-column: span 3;
            justify-content: center;
            margin-top: rem(24);
            @include button-primary(
                $width: 100%,
                $color: $c-accent,
                $border-color: $c-accent,
                $anim-color: $c-accent,
                $font-size: lineScale(20, 18, 480, 1920),
                $padding: rem(14) rem(32)
            );
        }
    }

    @media (max-width: 560px) {
        .modal-address {
            &__form {
                display: flex;
                flex-direction: column;
            }
        }
    }
</style>
