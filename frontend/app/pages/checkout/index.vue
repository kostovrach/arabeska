<template>
    <NuxtLayout>
        <ClientOnly>
            <template v-if="cart.length">
                <section class="checkout">
                    <div class="checkout__loader" v-if="isLoading">
                        <LoadSpinner />
                    </div>

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
                                                <p>
                                                    {{ translateProductModifier(product.modifier) }}
                                                </p>
                                                <span>{{ `${product.quantity} шт.` }}</span>
                                            </div>
                                            <div class="checkout__cheque-product-price ruble">
                                                {{
                                                    (
                                                        getProductPriceById(product.product_id) *
                                                        product.quantity
                                                    ).toLocaleString('ru-RU')
                                                }}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <ul class="checkout__cheque-info">
                                    <li class="checkout__cheque-info-item">
                                        <p>Доставка</p>
                                        <span
                                            :class="['ruble', { warn: remainsToFreeDelivery > 0 }]"
                                        >
                                            {{ totalDeliveryPrice }}
                                        </span>
                                    </li>
                                    <li
                                        class="checkout__cheque-info-item"
                                        v-if="promocode.discount > 0"
                                    >
                                        <p>Промокод</p>
                                        <span class="ruble">{{ `-${promocode.discount}` }}</span>
                                    </li>
                                </ul>
                                <form class="checkout__cheque-promo">
                                    <input
                                        v-if="!promocodeIsDisabled"
                                        id="order-promo"
                                        v-model="promocode.name"
                                        class="checkout__cheque-promo-input"
                                        type="text"
                                        name="order-promo"
                                        placeholder="Применить промокод"
                                    />
                                    <button
                                        v-if="promocode.name.length && !promocodeIsDisabled"
                                        class="checkout__cheque-promo-button"
                                        type="submit"
                                        @click.prevent="verifyPromocode"
                                    >
                                        Применить
                                    </button>
                                    <p
                                        class="checkout__cheque-promo-error"
                                        v-if="promocode.error.length"
                                    >
                                        {{ promocode.error }}
                                    </p>
                                    <p
                                        v-if="!promocodeIsDisabled"
                                        class="checkout__cheque-promo-hint"
                                    >
                                        Купон не&nbsp;суммируется с&nbsp;действующими акциями сайта.
                                    </p>
                                </form>
                                <div class="checkout__cheque-footer">
                                    <p class="checkout__cheque-footer-title">Итого</p>
                                    <span class="checkout__cheque-footer-amount ruble">
                                        {{ totalAmount.toLocaleString('ru-RU') }}
                                    </span>
                                </div>
                                <pre>
                                    {{ order }}
                                </pre>
                            </aside>
                            <form class="checkout__form">
                                <div class="checkout__section">
                                    <h2 class="checkout__section-title">Кому</h2>
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
                                            unstyled
                                            :disabled="order.recipient_self"
                                        />
                                    </div>
                                    <div class="checkout__togglerbox">
                                        <div class="checkout__toggler">
                                            <label
                                                for="order-recipient-self"
                                                class="checkout__toggler-body"
                                            >
                                                <input
                                                    id="order-recipient-self"
                                                    v-model="order.recipient_self"
                                                    type="checkbox"
                                                    name="order-recipient-self"
                                                    @input="toggleSelfRecipient"
                                                />
                                            </label>
                                            <span class="checkout__toggler-label">
                                                Я получатель
                                            </span>
                                        </div>
                                        <div class="checkout__toggler">
                                            <label
                                                for="order-recipient-anonymous"
                                                class="checkout__toggler-body"
                                            >
                                                <input
                                                    id="order-recipient-anonymous"
                                                    v-model="order.recipient_anonymous"
                                                    type="checkbox"
                                                    name="order-recipient-anonymous"
                                                />
                                            </label>
                                            <span class="checkout__toggler-label">
                                                Отправить анонимно
                                            </span>
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
                                            <label
                                                for="order-recipient-secret"
                                                class="checkout__toggler-body"
                                            >
                                                <input
                                                    id="order-recipient-secret"
                                                    v-model="order.recipient_secret"
                                                    type="checkbox"
                                                    name="order-recipient-secret"
                                                />
                                            </label>
                                            <span class="checkout__toggler-label">
                                                Не говорить, что это цветы
                                            </span>
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
                                            <label
                                                for="order-recipient-notification"
                                                class="checkout__toggler-body"
                                            >
                                                <input
                                                    id="order-recipient-notification"
                                                    v-model="order.recipient_notification"
                                                    @click="toggleRecipientNotification"
                                                    type="checkbox"
                                                    name="order-recipient-notification"
                                                />
                                            </label>
                                            <span class="checkout__toggler-label">
                                                Позвонить получателю для уточнения времени и даты
                                                доставки
                                            </span>
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
                                <template v-if="!order.recipient_notification">
                                    <div class="checkout__section">
                                        <h2 class="checkout__section-title">Способ получения</h2>
                                        <div class="checkout__togglerbox">
                                            <div class="checkout__toggler">
                                                <label
                                                    for="order-delivery-courier"
                                                    class="checkout__toggler-body"
                                                >
                                                    <input
                                                        id="order-delivery-courier"
                                                        v-model="order.delivery"
                                                        type="radio"
                                                        name="order-delivery-method"
                                                        value="courier"
                                                    />
                                                </label>
                                                <span class="checkout__toggler-label">
                                                    Доставка курьером
                                                </span>
                                            </div>
                                            <div class="checkout__toggler">
                                                <label
                                                    for="order-delivery-pickup"
                                                    class="checkout__toggler-body"
                                                >
                                                    <input
                                                        id="order-delivery-pickup"
                                                        v-model="order.delivery"
                                                        type="radio"
                                                        name="order-delivery-method"
                                                        value="pickup"
                                                    />
                                                </label>
                                                <label class="checkout__toggler-label">
                                                    Самовывоз
                                                </label>
                                            </div>
                                        </div>
                                        <template v-if="order.delivery === 'courier'">
                                            <div class="checkout__data checkout__data--courier">
                                                <span class="checkout__data-title">
                                                    Адрес доставки
                                                </span>
                                                <div
                                                    class="checkout__data-inputbox checkout__data-inputbox--large"
                                                >
                                                    <Select
                                                        label-id="order-delivery-street"
                                                        v-model="order.delivery_address"
                                                        class="checkout__dropdown"
                                                        overlay-class="checkout__dropdown-overlay"
                                                        placeholder="Выберите адрес"
                                                        :options="userAddresses"
                                                        unstyled
                                                        @focus="orderErrors.deliveryAddress = false"
                                                    >
                                                        <template #option="{ option }">
                                                            <button
                                                                class="checkout__dropdown-option"
                                                                type="button"
                                                            >
                                                                {{ option }}
                                                            </button>
                                                        </template>
                                                        <template #footer>
                                                            <button
                                                                class="checkout__dropdown-option checkout__dropdown-option--footer"
                                                                type="button"
                                                                @click="openAddAddress"
                                                            >
                                                                <span>
                                                                    <SvgSprite
                                                                        type="plus"
                                                                        :size="14"
                                                                    />
                                                                </span>
                                                                <span>Добавить адрес</span>
                                                            </button>
                                                        </template>
                                                    </Select>
                                                    <FormNotifyInfo
                                                        v-if="orderErrors.deliveryAddress"
                                                        class="checkout__data-error"
                                                        :position="{ top: '100%', left: '5%' }"
                                                    >
                                                        Необходимо заполнить поле
                                                    </FormNotifyInfo>
                                                </div>
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
                                                    Выберите салон, из которого вам удобно забрать
                                                    заказ
                                                </h3>
                                                <div class="checkout__data-inputbox">
                                                    <Select
                                                        label-id="order-delivery-pickup"
                                                        v-model="order.delivery_pickup_address"
                                                        class="checkout__dropdown"
                                                        overlay-class="checkout__dropdown-overlay"
                                                        placeholder="Выберите салон"
                                                        :options="
                                                            contacts?.addresses.map(
                                                                (el) => el.full_address
                                                            )
                                                        "
                                                        unstyled
                                                        @focus="
                                                            orderErrors.deliveryPickupAddress = false
                                                        "
                                                    >
                                                        <template #option="{ option }">
                                                            <button
                                                                class="checkout__dropdown-option"
                                                                type="button"
                                                            >
                                                                {{ option }}
                                                            </button>
                                                        </template>
                                                    </Select>
                                                    <FormNotifyInfo
                                                        v-if="orderErrors.deliveryPickupAddress"
                                                        class="checkout__data-error"
                                                        :position="{ top: '100%', left: '5%' }"
                                                    >
                                                        Необходимо заполнить поле
                                                    </FormNotifyInfo>
                                                </div>
                                            </div>
                                        </template>
                                        <div class="checkout__data checkout__data--date">
                                            <span class="checkout__data-title">
                                                Дата и время доставки
                                            </span>
                                            <div class="checkout__data-inputbox">
                                                <input
                                                    id="order-delivery-date"
                                                    v-model="order.delivery_date"
                                                    class="checkout__input--date"
                                                    type="date"
                                                    @focus="orderErrors.deliveryDate = false"
                                                />
                                                <FormNotifyInfo
                                                    v-if="orderErrors.deliveryDate"
                                                    class="checkout__data-error"
                                                    :position="{ top: '100%', left: '5%' }"
                                                >
                                                    Необходимо заполнить поле
                                                </FormNotifyInfo>
                                            </div>
                                            <div class="checkout__data-inputbox">
                                                <Select
                                                    label-id="order-delivery-time"
                                                    v-model="order.delivery_time"
                                                    class="checkout__dropdown"
                                                    overlay-class="checkout__dropdown-overlay"
                                                    placeholder="Выберите время"
                                                    :options="deliveryTimeVariants"
                                                    unstyled
                                                    @focus="orderErrors.deliveryTime = false"
                                                >
                                                    <template #option="{ option }">
                                                        <button
                                                            class="checkout__dropdown-option"
                                                            type="button"
                                                        >
                                                            {{ option }}
                                                        </button>
                                                    </template>
                                                </Select>
                                                <FormNotifyInfo
                                                    v-if="orderErrors.deliveryTime"
                                                    class="checkout__data-error"
                                                    :position="{ top: '100%', left: '5%' }"
                                                >
                                                    Необходимо заполнить поле
                                                </FormNotifyInfo>
                                            </div>
                                        </div>
                                    </div>
                                </template>
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
                                        <label
                                            for="order-payment-sbp"
                                            class="checkout__payment-item"
                                        >
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
                                                <span class="checkout__payment-item-title">
                                                    СБП
                                                </span>
                                                <p class="checkout__payment-item-desc">
                                                    Оплата онлайн по QR-коду
                                                </p>
                                            </div>
                                        </label>
                                        <label
                                            for="order-payment-card"
                                            class="checkout__payment-item"
                                        >
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
                                        <label
                                            for="order-payment-on-receipt"
                                            class="checkout__payment-item"
                                        >
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
                                <div class="checkout__controls">
                                    <div class="checkout__agreements">
                                        <div class="checkout__toggler">
                                            <label
                                                for="order-agreement-processing"
                                                class="checkout__toggler-body"
                                            >
                                                <input
                                                    id="order-agreement-processing"
                                                    v-model="order.agreement_processing"
                                                    type="checkbox"
                                                    name="order-agreement-processing"
                                                    @focus="orderErrors.agreement = false"
                                                />
                                            </label>
                                            <span class="checkout__toggler-label">
                                                Я ознакомился(сь) с политикой конфиденциальности и
                                                согласен(на) с обработкой персональных данных
                                            </span>
                                            <FormNotifyInfo
                                                v-if="orderErrors.agreement"
                                                class="checkout__data-error"
                                                :position="{ top: '100%', left: '-3%' }"
                                            >
                                                Без вашего согласия мы не сможем продолжить
                                            </FormNotifyInfo>
                                        </div>
                                        <div class="checkout__toggler">
                                            <label
                                                for="order-agreement-marketing"
                                                class="checkout__toggler-body"
                                            >
                                                <input
                                                    id="order-agreement-marketing"
                                                    v-model="order.agreement_marketing_notify"
                                                    type="checkbox"
                                                    name="order-agreement-marketing"
                                                />
                                            </label>
                                            <span class="checkout__toggler-label">
                                                Хочу получать информацию о новых предложениях и
                                                акциях
                                            </span>
                                        </div>
                                    </div>
                                    <FormNotifyError
                                        alignment="center"
                                        class="checkout__info"
                                        v-if="orderErrors.general.length"
                                    >
                                        {{ orderErrors.general }}
                                    </FormNotifyError>
                                    <button
                                        class="checkout__button"
                                        type="submit"
                                        @click.prevent="createOrder"
                                    >
                                        <span>Оплатить заказ</span>
                                        <span>
                                            <SvgSprite type="arrow" :size="18" />
                                        </span>
                                    </button>
                                    <NuxtLink class="checkout__help" :to="{ name: 'contact' }">
                                        Нужна помощь с оформлением заказа?
                                    </NuxtLink>
                                </div>
                            </form>
                        </div>
                    </div>
                </section>
            </template>
            <template v-else>
                <div class="checkout__empty">
                    <p class="checkout__empty-text">Нет товаров для оформления</p>
                    <NuxtLink class="checkout__empty-button" :to="{ name: 'catalog' }">
                        <span>За покупками</span>
                        <span><SvgSprite type="arrow" :size="18" /></span>
                    </NuxtLink>
                </div>
            </template>
        </ClientOnly>
    </NuxtLayout>
</template>

<script setup lang="ts">
    import { ModalsAddAddress } from '#components';
    import { useModal } from 'vue-final-modal';
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

    // state =====================================================
    const isLoading = ref(false);
    const promocodeIsDisabled = ref(false);

    const promocode = reactive({
        name: '',
        discount: 0,
        error: '',
    });
    // ===========================================================

    // data ======================================================
    const { content: settings } = await useCms<ISettings>('settings');
    const { content: contacts } = await useCms<IContacts>('contact');

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

    const totalAmount = computed(
        () => cartAmount.value + totalDeliveryPrice.value - promocode.discount
    );

    const userAddresses = computed(() => {
        if (!user.value?.addresses.length) return [];

        return user.value?.addresses.map((el) => {
            const street = `${el.street}, `;
            const flat = el.flat ? `квартира ${el.flat}, ` : '';
            const doorway = el.doorway ? `${el.doorway}-й подъезд, ` : '';
            const floor = el.floor ? `${el.floor}-й этаж` : '';

            return street + flat + doorway + floor;
        });
    });

    const { price: totalDeliveryPrice, remains: remainsToFreeDelivery } =
        useDeliveryPriceCalculator(cartAmount, deliveryPrice, deliveryRequiredPrice);
    // ===========================================================

    // Model =====================================================
    const order: Omit<IOrder, 'id' | 'date_created' | 'date_updated'> = reactive({
        // User data
        user_id: user.value?.id,
        user_email: user.value?.email,
        user_phone: user.value?.phone,
        user_name: user.value?.name ?? '',

        payment_status: 'not paid',
        status: 'ожидает оплаты',
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
        delivery_date: null,
        delivery_time: null,
        delivery_pickup_address: null,
        delivery_address:
            userAddresses.value.length && userAddresses.value[0] ? userAddresses.value[0] : null,

        // Additionally
        postcard: '',
        comment: '',

        // Agreements
        agreement_processing: true,
        agreement_marketing_notify: false,
    });

    const orderErrors = reactive({
        deliveryAddress: false,
        deliveryPickupAddress: false,
        deliveryDate: false,
        deliveryTime: false,
        agreement: false,
        general: '',
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

    function toggleRecipientNotification() {
        if (!order.recipient_notification) {
            order.delivery = 'specify';
            order.delivery_time = null;
            order.recipient_notification = true;
            order.delivery_address = null;
            order.delivery_pickup_address = null;
        } else {
            order.delivery = 'courier';
        }
    }

    const { open: openAddAddress, close: closeAddAddress } = useModal({
        component: ModalsAddAddress,
        attrs: {
            onClose() {
                closeAddAddress();
            },
        },
    });

    async function createOrder(): Promise<void> {
        if (!order.agreement_processing) {
            orderErrors.agreement = true;
            orderErrors.general = 'Не заполнены обязательные поля';
            return;
        }

        if (!order.recipient_notification && !order.delivery_date && !order.delivery_time) {
            if (!order.delivery_date) orderErrors.deliveryDate = true;
            if (!order.delivery_time) orderErrors.deliveryTime = true;
            orderErrors.general = 'Не заполнены обязательные поля';
            return;
        }

        if (!order.recipient_notification) {
            if (order.delivery === 'courier') {
                if (!order.delivery_address) {
                    orderErrors.deliveryAddress = true;
                    return;
                }
                order.delivery_pickup_address = null;
            }
            if (order.delivery === 'pickup') {
                if (!order.delivery_pickup_address) {
                    orderErrors.deliveryPickupAddress = true;
                    return;
                }
                order.delivery_address = null;
            }
        }
        isLoading.value = true;

        try {
            const targetPomocode =
                !promocodeIsDisabled && promocode.name.length ? promocode.name : undefined;

            const res = await $fetch('/api/orders/create', {
                method: 'POST',
                body: {
                    order: order,
                    promocode: targetPomocode,
                },
            });

            if (res.success) {
                const orderItems = JSON.stringify(cart.value);
                cartStore.clearCart();
                navigateTo({ name: 'checkout-success', query: { order: orderItems } });
                return;
            } else {
                orderErrors.general =
                    'Произошла непредвиденная ошибка, попробуйте повторить попыьку позже или связаться с нами';
                return;
            }
        } catch {
            orderErrors.general =
                'Произошла непредвиденная ошибка, попробуйте повторить попыьку позже или связаться с нами';
        } finally {
            isLoading.value = false;
        }
    }

    async function verifyPromocode(): Promise<void> {
        if (!promocode.name.length) return;
        if (promocodeIsDisabled.value) return;
        isLoading.value = true;

        try {
            const res = await $fetch('/api/user/verify-promocode', {
                method: 'POST',
                body: { promocode: promocode.name },
            });

            switch (res.status) {
                case 500:
                    promocode.error = 'Произошла ошибка, повторите попытку позже';
                    break;
                case 404:
                    promocode.error = 'Такого промокода не существует';
                    break;
                case 403:
                    promocode.error = 'Вы уже использовали этот промокод';
                    break;
                case 200:
                    if (res.requiredAmount && res.discount) {
                        if (cartAmount.value <= res.requiredAmount) {
                            promocode.error = 'Не выполнены условия промокода';
                            break;
                        }
                        let cartHasDiscount: boolean = false;
                        cart.value.forEach((product) => {
                            const discountProduct = getProductDiscountById(product.product_id);
                            if (discountProduct) cartHasDiscount = true;
                        });
                        if (cartHasDiscount) {
                            promocodeIsDisabled.value = true;
                            promocode.error =
                                'Промокод нельзя применить к корзине, содержащей акционные товары';
                            break;
                        }
                        promocode.discount = res.discount;
                        promocodeIsDisabled.value = true;
                    } else {
                        promocode.error = 'Произошла ошибка, повторите попытку позже';
                    }
                    break;
            }
        } catch {
            promocode.error = 'Произошла ошибка, повторите попытку позже';
        } finally {
            isLoading.value = false;
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
        &:disabled {
            pointer-events: none;
        }
    }
    .checkout {
        $p: &;

        margin: lineScale(64, 32, 480, 1440) 0;
        &__loader {
            position: fixed;
            inset: 0;
            z-index: 10;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: rgba($c-082535, 0.5);
        }
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
            font-size: lineScale(128, 48, 480, 1920);
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
                    text-transform: uppercase;
                    @include input;
                    &::placeholder {
                        text-transform: none;
                    }
                }
                &-button {
                    cursor: pointer;
                    align-self: flex-end;
                    color: $c-accent;
                    font-weight: $fw-semi;
                    margin-top: rem(8);
                }
                &-error {
                    color: $c-F5142B;
                    font-size: rem(14);
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
                font-size: lineScale(32, 22, 480, 1920);
                line-height: 1.4;
            }
        }
        &__data {
            font-family: 'Inter', sans-serif;
            &-title {
                display: block;
                font-size: lineScale(18, 16, 480, 1920);
                line-height: 1.4;
                grid-column: span 2;
            }
            &-inputbox {
                position: relative;
                &--large {
                    grid-column: span 3;
                }
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
        &__dropdown {
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
            min-height: rem(54);
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
            &-overlay {
                z-index: 4 !important;
                background-color: $c-FFFFFF;
                border-radius: rem(32);
                overflow: hidden;
                box-shadow: 1px 1px 5px rgba($c-98BBD7, 0.5);
            }
            &-option {
                cursor: pointer;
                display: block;
                box-sizing: border-box;
                width: 100%;
                font-size: lineScale(18, 18, 480, 1920);
                padding: rem(12) rem(24);
                border: rem(1) solid rgba($c-98BBD7, 0.15);
                @media (pointer: fine) {
                    &:hover {
                        color: $c-FFFFFF;
                        background-color: $c-accent;
                    }
                }
                &--footer {
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    gap: rem(8);
                    font-size: rem(14);
                }
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
                min-height: rem(54);
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
            position: relative;
            display: flex;
            align-items: center;
            gap: rem(8);
            &-body {
                @include toggler();
            }
            &-label {
                font-family: 'Inter', sans-serif;
                font-size: lineScale(16, 14, 480, 1920);
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
                    width: lineScale(48, 40, 480, 1920);
                    min-width: lineScale(48, 40, 480, 1920);
                }
                &-body {
                    display: flex;
                    flex-direction: column;
                    gap: rem(8);
                }
                &-title {
                    font-size: lineScale(20, 18, 480, 1920);
                }
                &-desc {
                    font-size: lineScale(16, 14, 480, 1920);
                    opacity: 0.5;
                }
            }
        }
        &__controls {
            font-family: 'Inter', sans-serif;
            margin-top: rem(32);
        }
        &__agreements {
            display: flex;
            flex-direction: column;
            gap: rem(8);
        }
        &__button {
            justify-content: center;
            margin-top: rem(16);
            @include button-primary(
                $width: 100%,
                $gap: rem(8),
                $color: $c-FFFFFF,
                $font-size: lineScale(20, 18, 480, 1920),
                $border-color: $c-98BBD7,
                $background: $c-98BBD7,
                $padding: rem(14) rem(32),
                $anim-color: $c-accent,
                $anim-border-color: $c-accent
            );
        }
        &__info {
            margin: rem(32) 0;
        }
        &__help {
            cursor: pointer;
            width: fit-content;
            display: block;
            color: $c-98BBD7;
            margin: rem(32) auto 0;
            @media (pointer: fine) {
                &:hover {
                    color: $c-accent;
                }
            }
        }
        &__empty {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: rem(32);
            background-color: transparent;
            margin: rem(128) 0;
            &-text {
                font-size: lineScale(32, 24, 480, 1920);
            }
            &-button {
                @include button-primary(
                    $border-color: $c-accent,
                    $gap: rem(16),
                    $anim-color: $c-accent
                );
            }
        }
    }

    @media (max-width: 1024px) {
        .checkout {
            &__wrapper {
                display: flex;
                flex-direction: column;
            }
        }
    }

    @media (max-width: 768px) {
        .checkout {
            &__data {
                display: flex;
                flex-direction: column;
            }
        }
    }

    @media (max-width: 640px) {
        .checkout {
            &__cheque {
                padding: 0;
                box-shadow: none;
            }
            &__section {
                border: none;
                padding: 0;
            }
        }
    }
</style>
