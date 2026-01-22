<template>
    <NuxtLayout>
        <ClientOnly>
            <div class="profile" v-if="user">
                <div class="profile__loading" v-if="isUpdateLoading">
                    <LoadSpinner />
                </div>

                <div class="profile__container">
                    <div class="profile__titlebox">
                        <h1 class="profile__title">Личный кабинет</h1>
                        <div class="profile__controls">
                            <p class="profile__controls-phone">
                                {{ partialHiddenPhone(decoratePhone(user.phone)) }}
                            </p>
                            <button class="profile__controls-logout" type="button" @click="logout">
                                <span>Выйти</span>
                                <span>
                                    <SvgSprite type="arrow" :size="12" style="rotate: -45deg" />
                                </span>
                            </button>
                        </div>
                    </div>

                    <div class="profile__body">
                        <aside class="profile__nav">
                            <div class="profile__nav-container">
                                <a class="profile__nav-link" href="#info">
                                    <span>Информация</span>
                                </a>
                                <a class="profile__nav-link" href="#orders"><span>Заказы</span></a>
                                <a class="profile__nav-link" href="#addresses">
                                    <span>Адреса</span>
                                </a>
                            </div>
                        </aside>
                        <div class="profile__body-wrapper">
                            <section id="info" class="profile__section profile__section--info">
                                <h2 class="profile__section-title">Информация о покупателе</h2>
                                <form class="profile__data">
                                    <div class="profile__data-field">
                                        <div class="profile__data-field-titlebox">
                                            <span class="profile__data-field-title">Имя</span>
                                        </div>
                                        <input
                                            v-model="userData.name"
                                            id="user-name"
                                            class="profile__data-field-input"
                                            type="text"
                                            placeholder="Поделитесь как вас зовут"
                                        />
                                    </div>
                                    <div class="profile__data-field">
                                        <div class="profile__data-field-titlebox">
                                            <span class="profile__data-field-title">Телефон</span>
                                            <span class="profile__data-field-hint">
                                                На этот номер вы получаете сервисные сообщения о
                                                статусах заказов
                                            </span>
                                        </div>
                                        <div
                                            class="profile__data-field-input profile__data-field-input--lock"
                                        >
                                            <span class="profile__data-field-input--lock-icon">
                                                <SvgSprite type="lock" :size="24" />
                                            </span>
                                            {{ partialHiddenPhone(decoratePhone(user.phone)) }}
                                        </div>
                                    </div>
                                    <div class="profile__data-field">
                                        <div class="profile__data-field-titlebox">
                                            <span class="profile__data-field-title">E-mail</span>
                                            <span class="profile__data-field-hint">
                                                На этот адрес будет отправлен чек об оплате
                                            </span>
                                        </div>
                                        <input
                                            v-model="userData.email"
                                            id="user-email"
                                            class="profile__data-field-input"
                                            type="email"
                                            placeholder="Введите ваш адрес электронной почты"
                                        />
                                    </div>
                                    <div class="profile__data-togglerbox">
                                        <div class="profile__data-toggler">
                                            <label
                                                for="user-promo"
                                                class="profile__data-toggler-body"
                                            >
                                                <input
                                                    v-model="userData.promo_subscribe"
                                                    id="user-promo"
                                                    type="checkbox"
                                                />
                                            </label>
                                            <span class="profile__data-toggler-desc">
                                                Подписка на промо-акции
                                            </span>
                                            <button
                                                class="profile__data-toggler-tooltip"
                                                type="button"
                                                tabindex="0"
                                            >
                                                <span>?</span>
                                                <p>Какая то содержательная подсказка</p>
                                            </button>
                                        </div>
                                        <div class="profile__data-toggler">
                                            <label
                                                for="user-notify"
                                                class="profile__data-toggler-body"
                                            >
                                                <input
                                                    v-model="userData.notifications"
                                                    id="user-notify"
                                                    type="checkbox"
                                                />
                                            </label>
                                            <span class="profile__data-toggler-desc">
                                                Получать сервисные уведомления
                                            </span>
                                            <button
                                                class="profile__data-toggler-tooltip"
                                                type="button"
                                                tabindex="0"
                                            >
                                                <span>?</span>
                                                <p>Какая то содержательная подсказка</p>
                                            </button>
                                        </div>
                                    </div>
                                    <button
                                        class="profile__data-button"
                                        type="submit"
                                        :disabled="!isUpdatedInfo"
                                        @click.prevent="updateUserData"
                                    >
                                        <span>Сохранить изменения</span>
                                    </button>
                                </form>
                            </section>
                            <section
                                id="addresses"
                                class="profile__section profile__section--addresses"
                            >
                                <h2 class="profile__section-title">Адреса доставки</h2>
                                <div class="profile__data">
                                    <form class="profile__data-list">
                                        <template v-if="userData.addresses?.length">
                                            <div
                                                v-for="address in userData.addresses"
                                                :key="address.id"
                                                class="profile__data-address"
                                            >
                                                <div class="profile__data-address-wrapper">
                                                    <p class="profile__data-address-title">
                                                        {{ `${address.street}, ` }}
                                                        <span v-if="address.flat">
                                                            {{ `квартира ${address.flat}, ` }}
                                                        </span>
                                                        <span v-if="address.doorway">
                                                            {{ `${address.doorway}-й подъезд, ` }}
                                                        </span>
                                                        <span v-if="address.floor">
                                                            {{ `${address.floor}-й этаж` }}
                                                        </span>
                                                    </p>
                                                </div>
                                                <button
                                                    class="profile__data-address-delete"
                                                    type="button"
                                                    @click.prevent="deleteAddress(address.id)"
                                                >
                                                    Удалить
                                                </button>
                                            </div>
                                        </template>
                                        <template v-else>
                                            <span class="profile__data-address-empty">
                                                Нет сохраненных адресов
                                            </span>
                                        </template>
                                        <div class="profile__data-create">
                                            <p class="profile__data-create-title">Добавить адрес</p>
                                            <YandexMap
                                                v-show="false"
                                                :settings="{
                                                    location: { center: [11, 11], zoom: 10 },
                                                }"
                                            />
                                            <div class="profile__data-create-form">
                                                <AutoComplete
                                                    v-model="newAddress.street"
                                                    input-id="user-address-street"
                                                    class="profile__data-create-input profile__data-create-input--main"
                                                    input-class="profile__data-create-input--main-input"
                                                    overlay-class="profile__data-create-input--main-suggest"
                                                    empty-search-message="К сожалению, совпадений не найдено"
                                                    unstyled
                                                    name="user-address-street"
                                                    type="text"
                                                    placeholder="Введите адрес для доставки"
                                                    :suggestions="
                                                        suggestResponse?.map(
                                                            (el) => el.address?.formattedAddress
                                                        ) ?? []
                                                    "
                                                    @complete="suggestOnSearch"
                                                >
                                                    <template #option="{ option }">
                                                        <div
                                                            class="profile__data-create-input--main-option"
                                                        >
                                                            {{ option }}
                                                        </div>
                                                    </template>
                                                </AutoComplete>
                                                <input
                                                    v-model="newAddress.flat"
                                                    id="user-address-flat"
                                                    class="profile__data-create-input"
                                                    name="user-address-flat"
                                                    type="number"
                                                    placeholder="Квартира"
                                                />
                                                <input
                                                    v-model="newAddress.doorway"
                                                    id="user-address-doorway"
                                                    class="profile__data-create-input"
                                                    name="user-address-doorway"
                                                    type="number"
                                                    placeholder="Подъезд"
                                                />
                                                <input
                                                    v-model="newAddress.floor"
                                                    id="user-address-floor"
                                                    class="profile__data-create-input"
                                                    name="user-address-floor"
                                                    type="number"
                                                    placeholder="Этаж"
                                                />
                                            </div>
                                            <button
                                                class="profile__data-button"
                                                type="submit"
                                                :disabled="!isUpdatedAddresses"
                                                @click.prevent="updateUserData"
                                            >
                                                <span>Сохранить</span>
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </section>
                            <section id="orders" class="profile__section--orders">
                                <div class="profile__section--orders-titlebox">
                                    <h2 class="profile__section-title">Заказы</h2>

                                    <div class="profile__section--orders-chips">
                                        <label
                                            v-for="(chip, idx) in ordersChips"
                                            :key="idx"
                                            :class="[
                                                'profile__section--orders-chips-item',
                                                { active: chip.value == userOrdersTab },
                                            ]"
                                            :for="`user-orders-${slugify(chip.value)}`"
                                        >
                                            <p>
                                                {{ chip.label }}
                                                <span
                                                    v-if="
                                                        userOrders?.filter(
                                                            (order) => order.status === chip.value
                                                        ).length
                                                    "
                                                >
                                                    ({{
                                                        userOrders?.filter(
                                                            (order) => order.status === chip.value
                                                        ).length
                                                    }})
                                                </span>
                                            </p>
                                            <input
                                                v-model="userOrdersTab"
                                                :id="`user-orders-${slugify(chip.value)}`"
                                                type="radio"
                                                name="user-orders"
                                                :value="chip.value"
                                            />
                                        </label>
                                    </div>
                                </div>
                                <div class="profile__section--orders-body">
                                    <ul
                                        v-if="userOrdersShow.length"
                                        class="profile__section--orders-list"
                                    >
                                        <li
                                            v-for="order in userOrdersShow"
                                            :key="order.id"
                                            class="profile__section--orders-item"
                                        >
                                            <div class="profile__section--orders-item-head">
                                                <div class="profile__section--orders-item-titlebox">
                                                    <span class="profile__section--orders-item-id">
                                                        {{ order.id.toString().slice(0, 8) }}
                                                    </span>
                                                    <div
                                                        class="profile__section--orders-item-status"
                                                    >
                                                        {{ order.status }}
                                                    </div>
                                                </div>
                                                <span
                                                    class="profile__section--orders-item-count ruble"
                                                >
                                                    {{ order.amount.toLocaleString('ru-RU') }}
                                                </span>
                                            </div>
                                            <div class="profile__section--orders-item-body">
                                                <ul class="profile__section--orders-item-info">
                                                    <li>{{ normalizeDate(order.date_created) }}</li>
                                                    <li>
                                                        {{
                                                            order.delivery_address ??
                                                            order.delivery_pickup_address
                                                        }}
                                                    </li>
                                                    <li
                                                        v-if="
                                                            order.recipient_name &&
                                                            order.recipient_phone
                                                        "
                                                    >
                                                        {{
                                                            `${order.recipient_name}, ${order.recipient_phone}`
                                                        }}
                                                    </li>
                                                </ul>
                                                <p class="profile__section--orders-item-subtitle">
                                                    {{
                                                        `Дата доставки: ${normalizeDate(order.delivery_date)}`
                                                    }}
                                                </p>
                                                <div class="profile__section--orders-item-gallery">
                                                    <img
                                                        v-for="product in order.structure"
                                                        :key="product.product_id"
                                                        class="profile__section--orders-item-gallery-image"
                                                        :src="
                                                            getProductImageById(product.product_id)
                                                        "
                                                        :alt="
                                                            getProductTitleById(
                                                                product.product_id
                                                            ) ?? '#'
                                                        "
                                                    />
                                                </div>
                                                <ul class="profile__section--orders-item-structure">
                                                    <li
                                                        v-for="item in order.structure"
                                                        :key="item.product_id"
                                                        class="profile__section--orders-item-structure-item"
                                                    >
                                                        <span
                                                            class="profile__section--orders-item-structure-title"
                                                        >
                                                            {{
                                                                getProductTitleById(item.product_id)
                                                            }}
                                                        </span>
                                                        <span
                                                            v-if="
                                                                translateProductModifier(
                                                                    item.modifier
                                                                )
                                                            "
                                                            class="profile__section--orders-item-structure-modifier"
                                                        >
                                                            {{
                                                                translateProductModifier(
                                                                    item.modifier
                                                                )
                                                            }}
                                                        </span>
                                                        <span
                                                            v-if="item.quantity"
                                                            class="profile__section--orders-item-structure-qty"
                                                        >
                                                            {{ `${item.quantity} шт.` }}
                                                        </span>
                                                        <span
                                                            class="profile__section--orders-item-structure-price ruble"
                                                        >
                                                            {{
                                                                getProductPriceById(item.product_id)
                                                            }}
                                                        </span>
                                                    </li>
                                                </ul>
                                            </div>
                                        </li>
                                    </ul>
                                    <div v-else class="profile__section--orders-empty">
                                        <p class="profile__section--orders-empty-text">
                                            Заказов пока нет
                                        </p>
                                        <NuxtLink
                                            class="profile__section--orders-empty-button"
                                            :to="{ name: 'catalog' }"
                                        >
                                            <span>В каталог</span>
                                            <span><SvgSprite type="arrow" :size="16" /></span>
                                        </NuxtLink>
                                    </div>
                                </div>
                            </section>
                        </div>
                    </div>
                </div>
            </div>
            <ViewedCarousel />
        </ClientOnly>
    </NuxtLayout>
</template>

<script setup lang="ts">
    import { YandexMap } from 'vue-yandex-maps';

    // types ============================================================
    import type { LngLat, SuggestResponse } from '@yandex/ymaps3-types';
    import type { IUser } from '~~/interfaces/entities/user';
    import type { IUserAddress } from '~~/interfaces/entities/user-address';
    import type { OrderStatusType } from '~~/interfaces/statuses/order-status';
    import type { IOrder } from '~~/interfaces/entities/order';
    // ==================================================================

    // meta =============================================================
    definePageMeta({
        middleware: 'auth',
    });
    // ==================================================================

    // data =============================================================
    const userStore = useUserStore();
    const cartStore = useCartStore();

    const {
        getProductImageById,
        getProductTitleById,
        getProductPriceById,
        translateProductModifier,
    } = cartStore;

    const user = computed(() => userStore.user);

    const userOrders = ref<IOrder[]>([]);

    const userOrdersShow = computed(() => {
        return userOrders.value?.filter((order) => order.status === userOrdersTab.value) ?? [];
    });

    const ordersChips: {
        label: string;
        value: OrderStatusType | 'all';
    }[] = [
        {
            label: 'Все',
            value: 'all',
        },
        {
            label: 'Ожидают оплаты',
            value: 'ожидает оплаты',
        },
        {
            label: 'Доставляются',
            value: 'передан в доставку',
        },
        {
            label: 'Завершённые',
            value: 'доставлен',
        },
    ];
    // ==================================================================

    // state ============================================================
    const isUpdateLoading = ref<boolean>(false);
    const isUpdatedInfo = ref<boolean>(false);
    const isUpdatedAddresses = ref<boolean>(false);

    const userOrdersTab = ref<OrderStatusType | 'all'>('ожидает оплаты');

    const userData: Partial<IUser> = reactive({
        id: user.value?.id,
        name: user.value?.name,
        email: user.value?.email,
        notifications: user.value?.notifications,
        promo_subscribe: user.value?.promo_subscribe,
        addresses: user.value?.addresses?.length ? [...user.value?.addresses] : [],
    });

    const newAddress: IUserAddress = reactive({
        id: '',
        street: '',
        flat: '',
        floor: '',
        doorway: '',
    });
    // ==================================================================

    // geosuggest state =================================================
    const suggestResponse = shallowRef<null | SuggestResponse>(null);
    const selectedSuggest = ref<LngLat | null>(null);

    const suggestOnSearch = useDebounceFn(async () => {
        if (!newAddress.street.length) return;

        const existing = suggestResponse.value?.find(
            (el) => el.subtitle?.text === newAddress.street
        );

        if (existing) {
            const afterSuggestSearch = await ymaps3.search({
                text: newAddress.street,
                type: ['toponyms'],
            });
            if (afterSuggestSearch[0]?.geometry?.coordinates) {
                selectedSuggest.value = afterSuggestSearch[0].geometry.coordinates;
                return;
            }
        }

        suggestResponse.value = await ymaps3.suggest({
            text: newAddress.street,
            types: ['street', 'house'],
        });
    }, 300);
    // ==================================================================

    // methods ==========================================================
    function logout(): void {
        userStore.logout();
        navigateTo('/');
    }

    function checkUpdateInfo(): void {
        if (
            userData.name === user.value?.name &&
            userData.email === user.value?.email &&
            userData.notifications === user.value?.notifications &&
            userData.promo_subscribe === user.value?.promo_subscribe
        ) {
            isUpdatedInfo.value = false;
        } else isUpdatedInfo.value = true;
    }

    function checkUpdateAddresses(): void {
        if (
            userData.addresses?.length == user.value?.addresses?.length &&
            !newAddress.street.length
        ) {
            isUpdatedAddresses.value = false;
        } else isUpdatedAddresses.value = true;
    }

    function deleteAddress(id: IUserAddress['id']): void {
        const idx = userData.addresses?.findIndex((el) => el.id === id);

        if (idx !== undefined && idx !== -1) {
            userData.addresses!.splice(idx, 1);
        }
    }

    function pushAddress(): void {
        if (!newAddress.street.length) return;

        const id = Date.now().toString();
        newAddress.id = id;

        try {
            userData.addresses?.push({ ...newAddress });
        } catch (err) {
            console.log(err);
        } finally {
            newAddress.id = '';
            newAddress.flat = '';
            newAddress.doorway = '';
            newAddress.floor = '';
            newAddress.street = '';
        }
    }

    async function updateUserData(): Promise<void> {
        if (!isUpdatedInfo.value && !isUpdatedAddresses.value && !newAddress.street.length) return;

        isUpdateLoading.value = true;
        if (newAddress.street.length) pushAddress();

        try {
            const res = await userStore.updateUser(userData);

            if (res.ok) {
                checkUpdateInfo();
                checkUpdateAddresses();
            } else {
                alert('Ошибка обновления данных, попробуйте повторить попытку позже');
            }
        } catch (err) {
            alert('Ошибка обновления данных, попробуйте повторить попытку позже');
        } finally {
            isUpdateLoading.value = false;
        }
    }

    async function getUserOrders(): Promise<void> {
        try {
            const { orders } = await $fetch('/api/orders');
            userOrders.value = orders;
        } catch {
            userOrders.value = [];
        }
    }

    // ==================================================================

    watch(userData, () => {
        checkUpdateInfo();
        checkUpdateAddresses();
    });

    watch(newAddress, () => {
        checkUpdateAddresses();
    });

    onMounted(async () => {
        await getUserOrders();
    });

    // SEO & Meta ================================================
    useHead({
        title: 'Личный кабинет | Arabeska - Магазин цветов в Самаре',
        meta: [{ name: 'robots', content: 'noindex, nofollow' }],
    });
    // ===========================================================
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
        &:focus {
            background-color: transparent;
            border-color: $c-accent !important;
            color: $c-082535;
            &::placeholder {
                opacity: 0.5;
            }
        }
    }
    .profile {
        $p: &;

        margin: lineScale(64, 32, 480, 1440) 0;
        &__loading {
            position: fixed;
            z-index: 4;
            inset: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            &::before {
                content: '';
                position: absolute;
                inset: 0;
                background-color: $c-082535;
                opacity: 0.5;
                pointer-events: none;
            }
        }
        &__container {
            @include content-container;
        }
        &__titlebox {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
        }
        &__title {
            font-size: lineScale(64, 32, 480, 1920);
            font-weight: $fw-semi;
        }
        &__controls {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: rem(8);
            font-family: 'Inter', sans-serif;
            text-align: right;
            &-phone {
                font-size: lineScale(24, 18, 480, 1920);
                font-weight: $fw-bold;
            }
            &-logout {
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: rem(4);
                font-size: lineScale(16, 14, 480, 1920);
                color: $c-F5142B;
                font-weight: $fw-semi;
                > span:has(svg) {
                    transition: translate $td $tf;
                }
                @media (pointer: fine) {
                    &:hover {
                        > span:has(svg) {
                            translate: rem(2) rem(-2);
                        }
                    }
                }
            }
        }
        &__body {
            display: grid;
            grid-template-columns: auto 70%;
            gap: rem(24);
            margin-top: rem(96);
            &-wrapper {
                display: flex;
                flex-direction: column;
                gap: rem(64);
            }
        }
        &__nav {
            position: relative;
            width: 100%;
            height: 100%;
            &-container {
                position: sticky;
                top: rem(132);
                display: flex;
                flex-direction: column;
                border-radius: rem(32);
                box-shadow: 1px 1px 5px rgba($c-D4E1E7, 0.7);
            }
            &-link {
                font-size: lineScale(22, 18, 480, 1440);
                @include frame-scale($padding: rem(18) rem(32), $border-radius: rem(32));
            }
        }

        &__section {
            padding: lineScale(32, 16, 480, 1920);
            border: rem(2) solid rgba($c-D4E1E7, 0.7);
            border-radius: rem(32);
            scroll-margin: rem(132);
            &--orders {
                scroll-margin: rem(132);
                &-titlebox {
                    padding: lineScale(32, 16, 480, 1920);
                }
                &-chips {
                    display: flex;
                    flex-wrap: wrap;
                    gap: rem(16);
                    &-item {
                        cursor: pointer;
                        position: relative;
                        font-family: 'Inter', sans-serif;
                        font-size: lineScale(16, 14, 480, 1920);
                        font-weight: $fw-semi;
                        &:not(.active) {
                            opacity: 0.5;
                        }
                        > input {
                            cursor: pointer;
                            position: absolute;
                            inset: 0;
                            display: none;
                        }
                    }
                }
                &-body {
                    margin-top: rem(32);
                }
                &-list {
                    display: flex;
                    flex-direction: column;
                    gap: rem(16);
                }
                &-item {
                    border: rem(2) solid $c-accent;
                    border-radius: rem(32);
                    padding: rem(32) lineScale(32, 16, 480, 1920);
                    &-head {
                        width: 100%;
                        display: flex;
                        align-items: center;
                        justify-content: space-between;
                        gap: rem(32);
                    }
                    &-titlebox {
                        display: flex;
                        align-items: center;
                        gap: rem(16);
                    }
                    &-id {
                        font-size: lineScale(22, 18, 480, 1920);
                        font-weight: $fw-semi;
                    }
                    &-status {
                        padding: rem(4) rem(16);
                        border-radius: rem(32);
                        font-size: rem(14);
                        color: $c-FFFFFF;
                        background-color: $c-98BBD7;
                    }
                    &-count {
                        font-size: lineScale(20, 16, 480, 1920);
                        font-weight: $fw-semi;
                    }
                    &-body {
                        display: flex;
                        flex-direction: column;
                        gap: rem(32);
                        font-family: 'Inter', sans-serif;
                        margin-top: rem(32);
                    }
                    &-info {
                        display: flex;
                        flex-direction: column;
                        gap: rem(8);
                        font-size: rem(16);
                        font-weight: $fw-semi;
                        line-height: 1.2;
                        opacity: 0.5;
                    }
                    &-subtitle {
                        font-size: rem(18);
                    }
                    &-gallery {
                        display: flex;
                        align-items: center;
                        flex-wrap: wrap;
                        gap: rem(8);
                        &-image {
                            width: lineScale(80, 64, 480, 1920);
                            min-width: lineScale(80, 64, 480, 1920);
                            aspect-ratio: 1;
                            border-radius: rem(16);
                            object-fit: cover;
                            overflow: hidden;
                        }
                    }
                    &-structure {
                        display: flex;
                        flex-direction: column;
                        gap: rem(16);
                        &-item {
                            display: grid;
                            grid-template-columns: repeat(4, 1fr);
                            gap: rem(8);
                            font-size: rem(14);
                            font-weight: $fw-semi;
                            > * {
                                width: fit-content;
                            }
                        }
                        &-qty,
                        &-price {
                            justify-self: flex-end;
                            text-align: right;
                        }
                        &-modifier {
                            opacity: 0.5;
                        }
                    }
                }
                &-empty {
                    width: 100%;
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    justify-content: center;
                    gap: rem(16);
                    padding: rem(64) 0;
                    &-text {
                        font-family: 'Inter', sans-serif;
                        font-size: lineScale(18, 16, 480, 1920);
                        opacity: 0.75;
                    }
                    &-button {
                        @include button-primary(
                            $color: $c-082535,
                            $border-color: $c-98BBD7,
                            $anim-color: $c-accent,
                            $font-size: lineScale(16, 16, 480, 1920),
                            $gap: rem(8),
                            $padding: rem(10) rem(32)
                        );
                    }
                }
            }
            &-title {
                font-size: lineScale(32, 24, 480, 1920);
                line-height: 1.2;
                margin-bottom: rem(32);
            }
        }
        &__data {
            display: flex;
            flex-direction: column;
            gap: rem(32);
            &-field {
                display: flex;
                flex-direction: column;
                gap: rem(8);
                &-titlebox {
                    display: flex;
                    align-items: flex-start;
                    justify-content: space-between;
                    flex-wrap: wrap-reverse;
                    gap: rem(8) rem(16);
                }
                &-title {
                    font-size: lineScale(18, 16, 480, 1920);
                }
                &-hint {
                    font-size: rem(12);
                    font-weight: $fw-semi;
                    opacity: 0.5;
                }
                &-input {
                    @include input();
                    &--lock {
                        display: flex;
                        align-items: center;
                        gap: rem(8);
                        pointer-events: none;
                        &-icon {
                            opacity: 0.5;
                        }
                    }
                }
            }
            &-togglerbox {
                display: flex;
                flex-direction: column;
                gap: rem(16);
            }
            &-toggler {
                display: flex;
                align-items: center;
                gap: rem(8);
                &-body {
                    @include toggler();
                }
                &-desc {
                    font-family: 'Inter', sans-serif;

                    line-height: 1.4;
                }
                &-tooltip {
                    position: relative;
                    &:hover,
                    &:focus {
                        > p {
                            display: initial;
                        }
                    }
                    > span {
                        cursor: pointer;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        width: rem(16);
                        min-width: rem(16);
                        aspect-ratio: 1;
                        border-radius: 50%;
                        color: $c-FFFFFF;
                        font-size: rem(12);
                        background-color: $c-98BBD7;
                    }
                    > p {
                        position: absolute;
                        left: 50%;
                        bottom: rem(32);
                        translate: -50% 0;
                        width: 25ch;
                        font-size: rem(12);
                        text-align: center;
                        line-height: 1.2;
                        background-color: $c-082535;
                        color: $c-FFFFFF;
                        border-radius: rem(8);
                        padding: rem(8) rem(16);
                        pointer-events: none;
                        display: none;
                        &::before {
                            content: '';
                            position: absolute;
                            top: 100%;
                            left: 50%;
                            translate: -50% -50%;
                            background-color: inherit;
                            width: rem(16);
                            min-width: rem(16);
                            aspect-ratio: 1;
                            rotate: 45deg;
                        }
                    }
                }
            }
            &-button {
                justify-content: center;
                &:disabled {
                    pointer-events: none;
                    opacity: 0.5;
                    filter: grayscale(100%);
                }
                @include button-primary(
                    $width: 100%,
                    $color: $c-accent,
                    $border-color: $c-accent,
                    $anim-color: $c-accent,
                    $font-size: lineScale(20, 18, 480, 1920),
                    $padding: rem(14) rem(32)
                );
            }
            &-list {
                display: flex;
                flex-direction: column;
                gap: rem(16);
            }
            &-address {
                display: grid;
                grid-template-columns: auto max-content;
                gap: rem(16);
                &-wrapper {
                    position: relative;
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    gap: rem(32);
                    padding: rem(16);
                    background-color: rgba($c-D4E1E7, 0.25);
                    border-radius: rem(32);
                }
                &-title {
                    display: flex;
                    align-items: center;
                    flex-wrap: wrap;
                    gap: 0.5ch;
                    font-size: lineScale(18, 16, 480, 1920);
                    > span {
                        opacity: 0.5;
                    }
                }
                &-delete {
                    cursor: pointer;
                    color: $c-F5142B;
                    text-decoration: underline;
                    font-size: rem(14);
                    font-weight: $fw-semi;
                    @media (pointer: fine) {
                        &:hover {
                            text-decoration: none;
                        }
                    }
                }
                &-empty {
                    font-size: lineScale(18, 16, 480, 1920);
                    color: $c-98BBD7;
                    opacity: 0.5;
                }
            }
            &-create {
                margin-top: rem(32);
                &-title {
                    font-size: rem(18);
                }
                &-form {
                    display: grid;
                    grid-template-columns: repeat(3, 1fr);
                    gap: rem(16) lineScale(16, 8, 480, 1920);
                    margin: rem(16) 0 rem(32);
                }
                &-input {
                    &:not(#{$p}__data-create-input--main) {
                        @include input();
                    }
                    &--main {
                        grid-column: span 3;
                        &-input {
                            @include input();
                        }
                        &-suggest {
                            z-index: 5 !important;
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
                            padding: rem(12) rem(24);
                            background-color: transparent;
                            border-top: rem(1) solid rgba($c-D4E1E7, 0.25);
                            @media (pointer: fine) {
                                &:hover {
                                    background-color: $c-accent;
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    @media (max-width: 1024px) {
        .profile {
            &__body {
                grid-template-columns: 100%;
            }
            &__nav {
                display: none;
            }
        }
    }

    @media (max-width: 768px) {
        .profile {
            &__titlebox {
                flex-direction: column-reverse;
                gap: rem(32);
            }
            &__section {
                &--orders {
                    &-item {
                        &-head {
                            display: flex;
                            flex-direction: column;
                            align-items: flex-start;
                        }
                        &-titlebox {
                            width: 100%;
                            justify-content: space-between;
                        }
                        &-structure {
                            &-item {
                                grid-template-columns: repeat(3, 1fr);
                            }
                            &-modifier {
                                display: none;
                            }
                        }
                    }
                }
            }
            &__controls {
                align-self: flex-end;
            }
        }
    }

    @media (max-width: 580px) {
        .profile {
            &__section {
                padding: 0;
                border: none;
                &--orders {
                    &-titlebox {
                        padding: 0;
                    }
                    &-item {
                        border: {
                            left: 0;
                            right: 0;
                        }
                        padding: {
                            left: 0;
                            right: 0;
                        }
                        border-radius: 0;
                    }
                }
            }
            &__data {
                &-create {
                    &-form {
                        display: flex;
                        flex-direction: column;
                    }
                }
            }
        }
    }
</style>
