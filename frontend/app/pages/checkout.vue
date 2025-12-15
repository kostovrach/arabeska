<template>
    <NuxtLayout>
        <ClientOnly>
            <section class="checkout">
                <div class="checkout__container">
                    <div class="checkout__wrapper">
                        <div class="checkout__titlebox">
                            <h1 class="checkout__title">Оформление заказа</h1>
                        </div>
                        <aside class="checkout__cheque">
                            <div class="checkout__cheque-titlebox">
                                <h3 class="checkout__cheque-title">Состав</h3>
                                <span class="checkout__cheque-count">
                                    {{ `Товаров: ${cartCounter}` }}
                                </span>
                            </div>
                            <div class="checkout__cheque-list">
                                <div
                                    v-for="(product, idx) in cart"
                                    :key="idx"
                                    class="checkout__cheque-product"
                                >
                                    <NuxtLink
                                        class="checkout__cheque-product-image-container"
                                        :to="{
                                            name: 'product-id',
                                            params: { id: product.product_id },
                                        }"
                                    >
                                        <img
                                            class="checkout__cheque-product-image"
                                            :src="getProductImageById(product.product_id)"
                                            :alt="getProductTitleById(product.product_id)"
                                        />
                                    </NuxtLink>
                                    <div class="checkout__cheque-product-body">
                                        <h4 class="checkout__cheque-product-title">
                                            {{ getProductTitleById(product.product_id) }}
                                        </h4>
                                        <div class="checkout__cheque-product-desc">
                                            <p>{{ translateProductModifier(product.modifier) }}</p>
                                            <span>{{ `${product.quantity} шт.` }}</span>
                                        </div>
                                        <div class="checkout__cheque-product-price ruble">
                                            {{ getProductPriceById(product.product_id) }}
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <ul class="checkout__cheque-info">
                                <li class="checkout__cheque-info-item">
                                    <p>Доставка</p>
                                    <span :class="['ruble', { warn: remainsToFreeDelivery > 0 }]">
                                        {{ totalDeliveryPrice }}
                                    </span>
                                </li>
                                <li class="checkout__cheque-info-item">
                                    <p>Промокод</p>
                                    <span class="ruble">{{ `-` }}</span>
                                </li>
                            </ul>
                            <form class="checkout__cheque-promo">
                                <input
                                    id="order-promo"
                                    v-model="promocode"
                                    class="checkout__cheque-promo-input"
                                    type="text"
                                    name="order-promo"
                                    placeholder="Применить промокод"
                                />
                                <button
                                    v-if="promocode.length"
                                    class="checkout__cheque-promo-button"
                                    type="submit"
                                    @click.prevent=""
                                >
                                    Применить
                                </button>
                                <p class="checkout__cheque-promo-hint">
                                    Купон не&nbsp;суммируется с&nbsp;действующими акциями сайта.
                                </p>
                            </form>
                            <div class="checkout__cheque-footer">
                                <p class="checkout__cheque-footer-title">Итого</p>
                                <span class="checkout__cheque-footer-amount ruble">
                                    {{ totalAmount.toLocaleString('ru-RU') }}
                                </span>
                            </div>
                        </aside>
                        <form class="checkout__form">
                            <div class="checkout__section">
                                <h2 class="checkout__section-title">От кого</h2>
                                <div class="checkout__data checkout__data--to">
                                    <input
                                        id="order-recipient-name"
                                        v-model="order.recipient_name"
                                        class="checkout__input"
                                        type="text"
                                        name="order-recipient-name"
                                        placeholder="Имя получателя"
                                        :disabled="order.recipient_self"
                                    />
                                    <InputMask
                                        id="order-recipient-phone"
                                        v-model="order.recipient_phone"
                                        class="checkout__input"
                                        mask="+7 (999) 999-99-99"
                                        placeholder="+7 (___) ___-__-__"
                                        name="order-recipient-phone"
                                        :disabled="order.recipient_self"
                                    />
                                </div>
                                <div class="checkout__togglerbox">
                                    <div class="checkout__toggler">
                                        <div class="checkout__toggler-body">
                                            <input
                                                id="order-recipient-self"
                                                v-model="order.recipient_self"
                                                type="checkbox"
                                                name="order-recipient-self"
                                                @input="toggleSelfRecipient"
                                            />
                                        </div>
                                        <label
                                            class="checkout__toggler-label"
                                            for="order-recipient-self"
                                        >
                                            Я получатель
                                        </label>
                                    </div>
                                    <div class="checkout__toggler">
                                        <div class="checkout__toggler-body">
                                            <input
                                                id="order-recipient-anonymous"
                                                v-model="order.recipient_anonymous"
                                                type="checkbox"
                                                name="order-recipient-anonymous"
                                            />
                                        </div>
                                        <label
                                            class="checkout__toggler-label"
                                            for="order-recipient-anonymous"
                                        >
                                            Отправить анонимно
                                        </label>
                                        <button
                                            class="checkout__toggler-tooltip"
                                            type="button"
                                            tabindex="0"
                                        >
                                            <span>?</span>
                                            <p>Какая то содержательная подсказка</p>
                                        </button>
                                    </div>
                                    <div class="checkout__toggler">
                                        <div class="checkout__toggler-body">
                                            <input
                                                id="order-recipient-secret"
                                                v-model="order.recipient_secret"
                                                type="checkbox"
                                                name="order-recipient-secret"
                                            />
                                        </div>
                                        <label
                                            class="checkout__toggler-label"
                                            for="order-recipient-secret"
                                        >
                                            Не говорить, что это цветы
                                        </label>
                                        <button
                                            class="checkout__toggler-tooltip"
                                            type="button"
                                            tabindex="0"
                                        >
                                            <span>?</span>
                                            <p>Какая то содержательная подсказка</p>
                                        </button>
                                    </div>
                                    <div class="checkout__toggler">
                                        <div class="checkout__toggler-body">
                                            <input
                                                id="order-recipient-notification"
                                                v-model="order.recipient_notification"
                                                type="checkbox"
                                                name="order-recipient-notification"
                                            />
                                        </div>
                                        <label
                                            class="checkout__toggler-label"
                                            for="order-recipient-notification"
                                        >
                                            Позвонить получателю для уточнения времени и даты
                                            доставки
                                        </label>
                                        <button
                                            class="checkout__toggler-tooltip"
                                            type="button"
                                            tabindex="0"
                                        >
                                            <span>?</span>
                                            <p>Какая то содержательная подсказка</p>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="checkout__section">
                                <h2 class="checkout__section-title">Способ получения</h2>
                                <div class="checkout__togglerbox">
                                    <div class="checkout__toggler">
                                        <div class="checkout__toggler-body">
                                            <input
                                                id="order-delivery-courier"
                                                v-model="order.delivery"
                                                type="radio"
                                                name="order-delivery-method"
                                                value="courier"
                                            />
                                        </div>
                                        <label
                                            class="checkout__toggler-label"
                                            for="order-delivery-courier"
                                        >
                                            Доставка курьером
                                        </label>
                                    </div>
                                    <div class="checkout__toggler">
                                        <div class="checkout__toggler-body">
                                            <input
                                                id="order-delivery-pickup"
                                                v-model="order.delivery"
                                                type="radio"
                                                name="order-delivery-method"
                                                value="pickup"
                                            />
                                        </div>
                                        <label
                                            class="checkout__toggler-label"
                                            for="order-delivery-pickup"
                                        >
                                            Самовывоз
                                        </label>
                                    </div>
                                </div>
                                {{ order.delivery_pickup_address }}
                                <template v-if="order.delivery === 'courier'">
                                    <div class="checkout__data checkout__data--courier">
                                        <span class="checkout__data-title">Адрес доставки</span>
                                        <input
                                            id="order-delivery-street"
                                            v-model="intermediateAddress.street"
                                            class="checkout__input"
                                            type="text"
                                            placeholder="Введите адрес"
                                        />
                                        <input
                                            id="order-delivery-flat"
                                            v-model="intermediateAddress.flat"
                                            class="checkout__input"
                                            type="number"
                                            placeholder="Квартира"
                                        />
                                        <input
                                            id="order-delivery-doorway"
                                            v-model="intermediateAddress.doorway"
                                            class="checkout__input"
                                            type="number"
                                            placeholder="Подъезд"
                                        />
                                        <input
                                            id="order-delivery-floor"
                                            v-model="intermediateAddress.floor"
                                            class="checkout__input"
                                            type="number"
                                            placeholder="Квартира"
                                        />
                                    </div>
                                    <div class="checkout__data--courier-hint">
                                        <span class="checkout__data--courier-hint-icon">
                                            <SvgSprite type="warn" :size="48" />
                                        </span>
                                        <p class="checkout__data--courier-hint-text">
                                            Для удаленных районов стоимость доставки
                                            <span class="ruble">
                                                {{ settings?.delivery_price }}
                                            </span>
                                            , вне&nbsp;зависимости от&nbsp;стоимости заказа.
                                            <NuxtLink :to="{ name: 'faq' }" target="_blank">
                                                <span>Подробнее</span>
                                                <SvgSprite type="arrow" :size="14" />
                                            </NuxtLink>
                                        </p>
                                    </div>
                                </template>

                                <template v-else>
                                    <div class="checkout__data--pickup">
                                        <h3 class="checkout__data-title">
                                            Выберите салон, из которого вам удобно забрать заказ
                                        </h3>
                                        <Select
                                            label-id="order-delivery-pickup"
                                            v-model="order.delivery_pickup_address"
                                            class="checkout__input--pickup"
                                            placeholder="Выберите салон"
                                            :options="
                                                contacts?.addresses.map((el) => el.full_address)
                                            "
                                            unstyled
                                        >
                                            <template #option="{ option }">
                                                <button
                                                    class="checkout__input--pickup-option"
                                                    type="button"
                                                >
                                                    {{ option }}
                                                </button>
                                            </template>
                                        </Select>
                                    </div>
                                </template>
                                <div class="checkout__data checkout__data--date">
                                    <span class="checkout__data-title">Дата и время доставки</span>
                                    <input
                                        id="order-delivery-date"
                                        v-model="order.delivery_date"
                                        class="checkout__input--date"
                                        type="date"
                                    />
                                    <Select
                                        label-id="order-delivery-time"
                                        v-model="order.delivery_time"
                                        class="checkout__input--time"
                                        placeholder="Выберите время"
                                        :options="deliveryTimeVariants"
                                        unstyled
                                    >
                                        <template #option="{ option }">
                                            <button
                                                class="checkout__input--time-option"
                                                type="button"
                                            >
                                                {{ option }}
                                            </button>
                                        </template>
                                    </Select>
                                </div>
                            </div>
                            <div class="checkout__section">
                                <h3 class="checkout__section-title">Текст для открытки</h3>
                                <div class="checkout__textarea">
                                    <button
                                        class="checkout__textarea-tooltip"
                                        type="button"
                                        tabindex="0"
                                    >
                                        <span>?</span>
                                        <p>Какая то содержательная подсказка</p>
                                    </button>
                                    <textarea
                                        id="order-postcard"
                                        v-model="order.postcard"
                                        class="checkout__textarea-input"
                                        placeholder="Что пожелать?"
                                    ></textarea>
                                </div>
                            </div>
                            <div class="checkout__section">
                                <h3 class="checkout__section-title">Комментарий к заказу</h3>
                                <div class="checkout__textarea">
                                    <textarea
                                        id="order-comment"
                                        v-model="order.comment"
                                        class="checkout__textarea-input"
                                        placeholder="Введите комментарий"
                                    ></textarea>
                                </div>
                            </div>
                            <div class="checkout__section">
                                <h3 class="checkout__section-title">Способ оплаты</h3>
                                <div class="checkout__payment">
                                    <label class="checkout__payment-item">
                                        <input
                                            id="order-payment-sbp"
                                            v-model="order.payment_method"
                                            class="checkout__payment-item-input"
                                            type="radio"
                                            name="order-payment"
                                            value="sbp"
                                        />
                                        <img
                                            class="checkout__payment-item-icon"
                                            src="/img/service/payment/sbp.svg"
                                        />
                                        <div class="checkout__payment-item-body">
                                            <span class="checkout__payment-item-title">СБП</span>
                                            <p class="checkout__payment-item-desc">
                                                Оплата онлайн по QR-коду
                                            </p>
                                        </div>
                                    </label>
                                    <label class="checkout__payment-item">
                                        <input
                                            id="order-payment-card"
                                            v-model="order.payment_method"
                                            class="checkout__payment-item-input"
                                            type="radio"
                                            name="order-payment"
                                            value="card"
                                        />
                                        <img
                                            class="checkout__payment-item-icon"
                                            src="/img/service/payment/card.svg"
                                        />
                                        <div class="checkout__payment-item-body">
                                            <span class="checkout__payment-item-title">
                                                Оплата банковской картой
                                            </span>
                                            <p class="checkout__payment-item-desc">
                                                МИР, Visa, Mastercard
                                            </p>
                                        </div>
                                    </label>
                                    <label class="checkout__payment-item">
                                        <input
                                            id="order-payment-on-receipt"
                                            v-model="order.payment_method"
                                            class="checkout__payment-item-input"
                                            type="radio"
                                            name="order-on-receipt"
                                            value="on-receipt"
                                        />
                                        <img
                                            class="checkout__payment-item-icon"
                                            src="/img/service/payment/sberpay.svg"
                                        />
                                        <div class="checkout__payment-item-body">
                                            <span class="checkout__payment-item-title">
                                                Оплата при получении
                                            </span>
                                            <p class="checkout__payment-item-desc">
                                                Наличными или картой
                                            </p>
                                        </div>
                                    </label>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </section>
        </ClientOnly>
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { IContacts } from '~~/interfaces/contacts';
    import type { IOrder } from '~~/interfaces/entities/order';
    import type { ISettings } from '~~/interfaces/settings';

    definePageMeta({
        middleware: 'auth',
    });

    const cartStore = useCartStore();
    const userStore = useUserStore();

    const user = computed(() => userStore.user!);

    const {
        getProductDiscountById,
        getProductImageById,
        getProductPriceById,
        getProductTitleById,
        translateProductModifier,
    } = cartStore;

    // data ======================================================
    const { content: settings } = useCms<ISettings>('settings');
    const { content: contacts } = useCms<IContacts>('contact');

    const deliveryTimeVariants = [
        '10:00 - 12:00',
        '08:00 - 10:00',
        '12:00 - 14:00',
        '14:00 - 16:00',
        '16:00 - 18:00',
        '18:00 - 20:00',
    ];

    const deliveryPrice = computed(() => settings.value?.delivery_price ?? 0);
    const deliveryRequiredPrice = computed(() => settings.value?.delivery_disable_price ?? 0);

    const cartCounter = computed(() => cartStore.cartCount);
    const cartAmount = computed(() => cartStore.cartAmount);

    const cart = computed(() => cartStore.cartList);

    const totalAmount = computed(() => cartAmount.value + totalDeliveryPrice.value);

    const { price: totalDeliveryPrice, remains: remainsToFreeDelivery } =
        useDeliveryPriceCalculator(cartAmount, deliveryPrice, deliveryRequiredPrice);
    // ===========================================================

    const intermediateAddress = reactive({
        street: '',
        flat: '',
        doorway: '',
        floor: '',
    });

    const formattedAddress = computed(() => {
        const street = `${intermediateAddress.street}, `;
        const flat = intermediateAddress.flat.length
            ? `квартира ${intermediateAddress.flat}, `
            : '';
        const doorway = intermediateAddress.doorway.length
            ? `${intermediateAddress.doorway}-й подъезд, `
            : '';
        const floor = intermediateAddress.floor.length ? `${intermediateAddress.floor}-й этаж` : '';
        return street + flat + doorway + floor;
    });

    // Model =====================================================
    const promocode = ref<string>('');

    const order: Omit<IOrder, 'id' | 'date_created' | 'date_updated' | 'status'> = reactive({
        // User data
        user_id: user.value?.id,
        user_email: user.value?.email,
        user_phone: user.value?.phone,
        user_name: user.value?.name ?? '',

        payment_status: 'not paid',
        amount: cartAmount.value,
        payment_method: 'card',

        // Order structure
        structure: cart.value,

        // Recipient
        recipient_name: '',
        recipient_phone: '',
        recipient_self: false,
        recipient_anonymous: false,
        recipient_notification: false,
        recipient_secret: false,

        // Delivery info
        delivery: 'courier',
        delivery_date: '',
        delivery_time: '10:00 - 12:00',
        delivery_pickup_address: '',
        delivery_address: formattedAddress,

        // Additionally
        postcard: '',
        comment: '',

        // Agreements
        agreement_processing: true,
        agreement_marketing_notify: false,
    });
    // ===========================================================

    // Methods ===================================================
    function toggleSelfRecipient(): void {
        if (!order.recipient_self) {
            order.recipient_self = true;
            order.recipient_name = user.value?.name ?? '';
            order.recipient_phone = user.value?.phone;
        } else {
            order.recipient_self = false;
            order.recipient_name = '';
            order.recipient_phone = '';
        }
    }
    // ===========================================================

    // SEO & Meta ================================================
    useHead({
        title: 'Оформление заказа | Arabeska - Магазин цветов в Самаре',
        meta: [{ name: 'robots', content: 'noindex, nofollow' }],
    });
    // ===========================================================
</script>

<style scoped lang="scss">
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
        &:disabled {
            pointer-events: none;
        }
    }
    .checkout {
        $p: &;

        margin: lineScale(64, 32, 480, 1440) 0;
        &__container {
            @include content-container;
        }
        &__wrapper {
            max-width: rem(1440);
            display: grid;
            grid-template-columns: 30% auto;
            grid-template-areas:
                'titlebox titlebox'
                'cheque form';
            gap: rem(64) rem(32);
            margin: 0 auto;
        }
        &__titlebox {
            grid-area: titlebox;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        &__title {
            font-size: lineScale(128, 64, 480, 1920);
            font-weight: $fw-semi;
        }
        &__cheque {
            grid-area: cheque;
            height: fit-content;
            display: flex;
            flex-direction: column;
            gap: rem(32);
            border-radius: rem(32);
            padding: lineScale(32, 16, 480, 1920);
            box-shadow: 1px 1px 5px rgba($c-D4E1E7, 0.7);
            &-titlebox {
                display: flex;
                align-items: center;
                justify-content: space-between;
                flex-wrap: wrap;
                gap: rem(16);
                font-weight: $fw-semi;
                padding-bottom: rem(16);
                border-bottom: rem(2) solid rgba($c-98BBD7, 0.25);
            }
            &-title {
                font-size: lineScale(22, 18, 480, 1920);
            }
            &-count {
                font-size: lineScale(16, 14, 480, 1920);
                opacity: 0.5;
            }
            &-list {
                display: flex;
                flex-direction: column;
                gap: rem(8);
            }
            &-product {
                display: flex;
                gap: rem(8);
                &-image-container {
                    display: block;
                    width: rem(64);
                    min-width: rem(64);
                    aspect-ratio: 1;
                    border-radius: rem(8);
                    overflow: hidden;
                }
                &-image {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }
                &-body {
                    width: 100%;
                    display: grid;
                    justify-content: space-between;
                    grid-template-areas:
                        'title price'
                        'desc desc';
                    padding: rem(4) 0;
                }
                &-title {
                    grid-area: title;
                    font-size: rem(16);
                    font-weight: $fw-semi;
                    @include lineClamp(2);
                }
                &-desc {
                    grid-area: desc;
                    display: flex;
                    align-items: center;
                    gap: rem(8);
                    font-size: rem(16);
                    font-weight: $fw-semi;
                    opacity: 0.5;
                }
                &-price {
                    grid-area: price;
                    text-align: right;
                    font-size: rem(18);
                    font-weight: $fw-semi;
                }
            }
            &-info {
                display: flex;
                flex-direction: column;
                gap: rem(16);
                &-item {
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    gap: rem(16);
                    font-weight: $fw-semi;
                    > p {
                        font-size: rem(14);
                        opacity: 0.5;
                    }
                    > span {
                        color: $c-accent;
                        &.warn {
                            color: $c-F5142B;
                        }
                    }
                }
            }
            &-promo {
                display: flex;
                flex-direction: column;
                &-input {
                    @include input;
                }
                &-button {
                    cursor: pointer;
                    align-self: flex-end;
                    color: $c-accent;
                    font-weight: $fw-semi;
                    margin-top: rem(8);
                }
                &-hint {
                    max-width: 35ch;
                    font-size: rem(14);
                    line-height: 1.2;
                    font-weight: $fw-semi;
                    text-wrap: balance;
                    opacity: 0.25;
                    margin-top: rem(8);
                }
            }
            &-footer {
                display: flex;
                align-items: center;
                justify-content: space-between;
                gap: rem(16);
                font-weight: $fw-semi;
                border-top: rem(2) solid rgba($c-98BBD7, 0.25);
                padding-top: rem(16);
                &-title {
                    font-size: lineScale(22, 18, 480, 1920);
                }
                &-amount {
                    font-size: lineScale(32, 20, 480, 1920);
                }
            }
        }
        &__form {
            grid-area: form;
            display: flex;
            flex-direction: column;
            gap: rem(32);
        }
        &__section {
            display: flex;
            flex-direction: column;
            gap: rem(32);
            padding: lineScale(32, 16, 480, 1920);
            border: rem(2) solid rgba($c-D4E1E7, 0.7);
            border-radius: rem(32);
            &-title {
                font-size: lineScale(32, 20, 480, 1920);
            }
        }
        &__data {
            font-family: 'Inter', sans-serif;
            &-title {
                display: block;
                font-size: lineScale(18, 14, 480, 1920);
                margin-bottom: rem(16);
                grid-column: span 2;
            }
            &--to {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: rem(8);
            }
            &--courier {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: rem(16) rem(8);
                :first-of-type {
                    grid-column: span 3;
                }
                &-hint {
                    display: flex;
                    align-items: center;
                    gap: rem(16);
                    padding: lineScale(24, 16, 480, 1920);
                    border-radius: rem(32);
                    border: rem(2) solid $c-F5142B;
                    &-text {
                        font-size: lineScale(18, 16, 480, 1920);
                        line-height: 1.4;
                        text-wrap: balance;
                        > span {
                            font-weight: $fw-bold;
                        }
                        > a {
                            cursor: pointer;
                            width: fit-content;
                            display: inline-flex;
                            align-items: center;
                            gap: rem(8);
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
            &--date {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: rem(16);
            }
            &--pickup {
                display: flex;
                flex-direction: column;
                gap: rem(16);
            }
        }
        &__input {
            @include input();
            &--date {
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
                &:disabled {
                    pointer-events: none;
                }
            }
            &--time {
                cursor: pointer;
                width: 100%;
                font-family: 'Inter', sans-serif;
                font-size: lineScale(20, 18, 480, 1920);
                padding: rem(12) rem(24);
                background-color: rgba($c-D4E1E7, 0.25);
                border: rem(2) solid rgba($c-D4E1E7, 0.25) !important;
                border-radius: rem(32);
                color: rgba($c-082535, 0.7);
                display: flex;
                align-items: center;
                justify-content: space-between;
                transition:
                    background-color $td $tf,
                    color $td $tf,
                    border-color $td $tf;
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
                &:disabled {
                    pointer-events: none;
                }
                [role='listbox'] {
                    display: none;
                }
                &-option {
                    cursor: pointer;
                    box-sizing: border-box;
                    width: 100%;
                    font-size: lineScale(20, 18, 480, 1920);
                    padding: rem(8) rem(24);
                    background-color: $c-F4F7F9;
                    border: rem(1) solid rgba($c-98BBD7, 0.15);
                    @media (pointer: fine) {
                        &:hover {
                            color: $c-FFFFFF;
                            background-color: $c-accent;
                        }
                    }
                }
            }
            &--pickup {
                cursor: pointer;
                width: 100%;
                font-family: 'Inter', sans-serif;
                font-size: lineScale(20, 18, 480, 1920);
                padding: rem(12) rem(24);
                background-color: rgba($c-D4E1E7, 0.25);
                border: rem(2) solid rgba($c-D4E1E7, 0.25) !important;
                border-radius: rem(32);
                color: rgba($c-082535, 0.7);
                display: flex;
                align-items: center;
                justify-content: space-between;
                transition:
                    background-color $td $tf,
                    color $td $tf,
                    border-color $td $tf;
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
                &:disabled {
                    pointer-events: none;
                }
                [role='listbox'] {
                    display: none;
                }
                &-option {
                    cursor: pointer;
                    box-sizing: border-box;
                    width: 100%;
                    font-size: lineScale(20, 18, 480, 1920);
                    padding: rem(8) rem(24);
                    background-color: $c-F4F7F9;
                    border: rem(1) solid rgba($c-98BBD7, 0.15);
                    @media (pointer: fine) {
                        &:hover {
                            color: $c-FFFFFF;
                            background-color: $c-accent;
                        }
                    }
                }
            }
        }
        &__textarea {
            position: relative;
            &-tooltip {
                position: absolute;
                top: rem(12);
                right: rem(12);
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
            &-input {
                width: 100%;
                min-height: rem(128);
                max-height: rem(256);
                font-family: 'Inter', sans-serif;
                font-size: lineScale(20, 18, 480, 1920);
                padding: rem(16) rem(24);
                background-color: rgba($c-D4E1E7, 0.25);
                border: rem(2) solid rgba($c-D4E1E7, 0.25) !important;
                border-radius: rem(24);
                color: rgba($c-082535, 0.7);
                resize: vertical;
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
                &:disabled {
                    pointer-events: none;
                }
            }
        }
        &__togglerbox {
            display: flex;
            flex-direction: column;
            gap: rem(8);
        }
        &__toggler {
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
        &__payment {
            display: flex;
            flex-direction: column;
            gap: rem(16);
            &-item {
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: rem(16);
                padding: rem(16) rem(32);
                border-radius: rem(32);
                background-color: rgba($c-D4E1E7, 0.25);
                border: rem(2) solid transparent;
                &:has(input:checked) {
                    border-color: $c-accent;
                    background-color: $c-FFFFFF;
                }
                &-input {
                    position: absolute;
                    opacity: 0;
                }
                &-icon {
                    width: lineScale(64, 48, 480, 1920);
                    min-width: lineScale(64, 48, 480, 1920);
                }
                &-body {
                    display: flex;
                    flex-direction: column;
                    gap: rem(8);
                }
                &-title {
                    font-size: lineScale(24, 20, 480, 1920);
                }
                &-desc {
                    font-size: lineScale(16, 14, 480, 1920);
                    opacity: 0.5;
                }
            }
        }
    }
</style>
