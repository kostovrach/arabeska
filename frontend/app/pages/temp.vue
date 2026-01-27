<template>
    <!-- <NuxtLayout> -->
    <div class="order" v-if="order">
        <div class="order__header">
            <h1 class="order__title">Информация о заказе</h1>
            <a class="order__logo" href="https://fs-arabeska.ru">
                <svg
                    width="61"
                    height="61"
                    viewBox="0 0 61 61"
                    fill="none"
                    xmlns="http://www.w3.org/2000/svg"
                >
                    <path
                        d="M30.3516 0.188477C46.9201 0.188477 60.3516 13.6199 60.3516 30.1885C60.3516 46.757 46.9201 60.1885 30.3516 60.1885C13.783 60.1885 0.351562 46.757 0.351562 30.1885C0.351562 13.6199 13.783 0.188477 30.3516 0.188477ZM32.5547 12.5576C29.8284 13.9859 28.5308 16.6877 28.3135 18.084C27.187 17.2308 24.3769 16.1893 21.4238 17.0566C22.4427 18.1061 23.8055 19.0391 25.1338 22.3252C26.3344 25.2956 28.1644 26.108 30.1611 25.6943C30.5637 26.735 30.9798 27.7637 31.377 28.5791C30.241 29.4242 29.1358 30.3409 28.0303 31.2217C26.5435 28.0437 24.5526 25.7715 22.8857 24.2119C21.7806 23.1781 20.6622 22.4522 19.4521 22C18.4628 21.5487 17.35 21.3232 16.1162 21.3232C14.3769 21.3234 12.7981 21.7787 11.3799 22.6885C11.3589 22.7018 11.3373 22.715 11.3164 22.7285C9.91144 23.5935 8.81007 24.8363 8.04785 26.3018C7.57252 27.1892 7.23875 28.1476 7.04492 29.1758C6.89148 29.9406 6.8125 30.7332 6.8125 31.5381C6.81269 36.9534 10.5445 41.2197 15.917 41.4492C18.3634 41.5536 20.8442 40.559 22.998 39.3311C24.5132 38.4672 25.9686 37.4246 27.2744 36.4004C27.8143 37.5894 28.4262 38.9428 28.9482 41.0518L31.2744 41.0469C30.6751 38.35 30.2695 36.554 29.502 34.5781C30.6148 33.6744 31.7293 32.7727 32.877 31.9189C34.6583 35.3588 35.802 36.6224 37.2246 38.0156C38.759 39.5183 40.4131 40.6819 42.5596 41.1738C43.2369 41.3603 43.9133 41.4541 44.5889 41.4502H44.6016C48.1362 41.4456 50.8848 39.5801 52.4482 36.8857C52.5256 36.7586 52.6018 36.6289 52.6748 36.4971C53.1811 35.535 53.5279 34.5037 53.7148 33.4033C53.8346 32.7404 53.8964 32.0588 53.8965 31.3682C53.8965 30.7249 53.8399 30.0929 53.7314 29.4795C53.5489 28.3356 53.1966 27.276 52.6748 26.3018C51.8452 24.7764 50.7343 23.5716 49.3428 22.6885C47.9244 21.7786 46.3449 21.3233 44.6055 21.3232C43.2119 21.3233 41.9743 21.6116 40.8926 22.1875C40.302 22.4455 39.6877 22.7743 39.0186 23.1816C37.598 24.0465 35.836 25.3237 33.4189 27.1182C33.0309 26.3268 32.669 25.6053 32.3389 24.7988C34.0159 23.7034 34.7332 21.8575 33.5479 18.9248C32.2195 15.6384 32.5513 14.0204 32.5547 12.5576ZM13.9893 26.2607C16.1188 24.9558 18.9614 25.4198 20.8564 26.9355C22.0904 27.9226 23.8534 29.5381 25.541 33.1318C24.2253 34.1842 22.7321 35.4614 21.2686 36.2959C19.24 37.4525 16.0658 37.7027 13.9893 36.4971C13.1866 35.9886 12.5442 35.2931 12.0625 34.4102C11.6076 33.5271 11.3799 32.51 11.3799 31.3594C11.3799 30.2086 11.6075 29.1908 12.0625 28.3076C12.5441 27.4248 13.1867 26.7424 13.9893 26.2607ZM40.835 26.1641C42.5013 25.15 45.0924 25.2551 46.7334 26.2607C47.536 26.7424 48.1785 27.4248 48.6602 28.3076C49.1151 29.1908 49.3428 30.2086 49.3428 31.3594C49.3427 32.51 49.1151 33.5271 48.6602 34.4102C48.1785 35.2931 47.5361 35.9886 46.7334 36.4971C44.2531 37.9372 41.4183 37.0644 39.4736 35.1602C38.2192 33.9316 36.781 32.3969 35.2637 30.1914C37.7659 28.3326 39.508 26.9719 40.835 26.1641Z"
                        fill="#99CC65"
                    />
                </svg>
            </a>
        </div>
        <div class="order__body">
            <ul class="order__info">
                <li>
                    <strong>ID заказа:</strong>
                    {{ order.id }}
                </li>
                <li>
                    <strong>Создан:</strong>
                    {{
                        new Date(order?.date_created).toLocaleString('RU-ru', {
                            day: 'numeric',
                            month: 'long',
                            year: 'numeric',
                            hour: '2-digit',
                            minute: '2-digit',
                        })
                    }}
                </li>
                <li>
                    <strong>Статус:</strong>
                    {{ order.status }}
                </li>
                <li>
                    <strong>Сумма:</strong>
                    {{ order.amount.toLocaleString('RU-ru') + '₽' }}
                </li>
            </ul>
            <div class="order__section">
                <h2 class="order__section-title">Покупатель</h2>
                <ul class="order__data">
                    <li class="order__data-item">
                        <span class="order__data-item-title">ID покупателя:</span>
                        <span class="order__data-item-body">{{ order.user_id }}</span>
                    </li>
                    <li class="order__data-item">
                        <span class="order__data-item-title">ФИО:</span>
                        <span class="order__data-item-body">{{ order.user_name }}</span>
                    </li>
                    <li class="order__data-item">
                        <span class="order__data-item-title">Телефон:</span>
                        <a
                            class="order__data-item-body order__data-item-body--link"
                            :href="`tel:${order.user_phone}`"
                        >
                            {{ order.user_phone ? decoratePhone(order.user_phone) : 'Не указано' }}
                        </a>
                    </li>
                    <li class="order__data-item">
                        <span class="order__data-item-title">E-mail:</span>
                        <a
                            class="order__data-item-body order__data-item-body--link"
                            :href="`mailto:${order.user_email}`"
                        >
                            {{ order.user_email ?? 'Не указано' }}
                        </a>
                    </li>
                </ul>
            </div>
            <div class="order__section">
                <h2 class="order__section-title">Информация о доставке</h2>
                <ul class="order__data">
                    <li class="order__data-item">
                        <span class="order__data-item-title">Способ доставки:</span>
                        <span class="order__data-item-body">
                            {{ translateDeliveryMethod(order.delivery) }}
                        </span>
                    </li>
                    <li class="order__data-item">
                        <span class="order__data-item-title">Дата доставки:</span>
                        <span class="order__data-item-body">
                            {{
                                order?.delivery_date
                                    ? new Date(order?.delivery_date).toLocaleString('RU-ru', {
                                          day: 'numeric',
                                          month: 'long',
                                          year: 'numeric',
                                      })
                                    : 'Не указано'
                            }}
                        </span>
                    </li>
                    <li class="order__data-item">
                        <span class="order__data-item-title">Время доставки:</span>
                        <span class="order__data-item-body">
                            {{ order.delivery_time ?? 'Не указано' }}
                        </span>
                    </li>
                    <li class="order__data-item">
                        <span class="order__data-item-title">Адрес доставки:</span>
                        <span class="order__data-item-body">
                            {{ order.delivery_address ?? 'Не указано' }}
                        </span>
                    </li>
                    <li class="order__data-item">
                        <span class="order__data-item-title">Адрес самовывоза:</span>
                        <span class="order__data-item-body">
                            {{ order.delivery_pickup_address ?? 'Не указано' }}
                        </span>
                    </li>
                </ul>
            </div>
            <div class="order__section">
                <h2 class="order__section-title">Получатель:</h2>
                <ul class="order__data">
                    <li class="order__data-item">
                        <span class="order__data-item-title">Имя получателя:</span>
                        <span class="order__data-item-body">
                            {{ order.recipient_name ?? 'Не указано' }}
                        </span>
                    </li>
                    <li class="order__data-item">
                        <span class="order__data-item-title">Телефон получателя:</span>
                        <a
                            class="order__data-item-body order__data-item-body--link"
                            :href="`tel:${order.user_phone}`"
                        >
                            {{
                                order.recipient_phone
                                    ? decoratePhone(order.recipient_phone)
                                    : 'Не указано'
                            }}
                        </a>
                    </li>
                    <li class="order__data-item">
                        <span class="order__data-item-title">Отправить анонимно:</span>
                        <span class="order__data-item-icon order__data-item-icon--true"></span>
                    </li>
                    <li class="order__data-item">
                        <span class="order__data-item-title">Не говорить, что это цветы:</span>
                        <span class="order__data-item-icon order__data-item-icon--false"></span>
                    </li>
                    <li class="order__data-item order__data-item--large">
                        <span class="order__data-item-title">Комментарий:</span>
                        <span
                            class="order__data-item-body"
                            style="text-align: left; line-height: 1.4"
                        >
                            {{ order.comment ?? 'Отсутствует' }}
                        </span>
                    </li>
                    <li class="order__data-item order__data-item--large">
                        <span class="order__data-item-title">Открытка:</span>
                        <span
                            class="order__data-item-body"
                            style="text-align: left; line-height: 1.4"
                        >
                            {{ order.postcard ?? 'Отсутствует' }}
                        </span>
                    </li>
                </ul>
            </div>
            <div class="order__section">
                <h2 class="order__section-title">Список товаров:</h2>
                <ul class="order__structure">
                    <li class="order__item" v-for="(item, idx) in order.structure" :key="idx">
                        <a
                            class="order__item-image-container"
                            :href="`https://fs-arabeska.ru/product/${item.product_id}`"
                            target="_blank"
                        >
                            <img
                                class="order__item-image"
                                :src="getProductImageById(item.product_id)"
                                :alt="getProductTitleById(item.product_id) ?? '#'"
                            />
                        </a>
                        <div class="order__item-body">
                            <span class="order__item-tag">{{ 'арт. ' + item.product_id }}</span>
                            <h3 class="order__item-title">
                                {{ getProductTitleById(item.product_id) }}
                            </h3>
                            <span class="order__item-desc">
                                {{ 'Количество: ' + item.quantity }}
                            </span>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
        <div class="order__footer">
            Сумма заказа:
            <span>{{ order.amount.toLocaleString('RU-ru') + '₽' }}</span>
        </div>
    </div>
    <!-- </NuxtLayout> -->
</template>

<script setup lang="ts">
    import type { IOrder } from '~~/interfaces/entities/order';

    const { getProductImageById, getProductTitleById, translateProductModifier } = useCartStore();

    const order = ref<IOrder | null>(null);

    async function getUserOrders(): Promise<void> {
        try {
            const { orders } = await $fetch('/api/orders');
            order.value =
                orders.sort(
                    (a, b) =>
                        new Date(b.date_created).getTime() - new Date(a.date_created).getTime()
                )[0] ?? null;
        } catch {
            order.value = null;
        }
    }

    onMounted(() => getUserOrders());

    function translateDeliveryMethod(value: IOrder['delivery']) {
        switch (value) {
            case 'courier':
                return 'Курьер';
            case 'pickup':
                return 'Самовывоз';
            case 'specify':
                return 'Учточнить у получателя';
            default:
                return 'Учточнить у получателя';
        }
    }
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .order {
        font-family: 'Inter', sans-serif;
        max-width: 640px;
        margin: 0 auto;
        background-color: #f4f7f9;
        &__header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            color: #ffffff;
            padding: 16px;
            background-color: #082535;
            border-radius: 0 0 8px 8px;
        }
        &__body {
            padding: 0 16px;
        }
        &__footer {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            gap: 12px;
            color: #ffffff;
            font-size: 14px;
            padding: 24px 16px;
            background-color: #082535;
            border-radius: 8px 8px 0 0;
            margin-top: rem(32);
            > span {
                font-size: 32px;
            }
        }
        &__title {
            font-size: 24px;
            font-weight: bold;
        }
        &__info {
            display: flex;
            flex-direction: column;
            gap: 16px;
            margin-top: 32px;
            > li {
                display: flex;
                align-items: flex-start;
                justify-content: space-between;
                gap: 16px;
            }
        }
        &__section {
            margin-top: 64px;
            &-title {
                font-size: 20px;
                font-weight: bold;
            }
        }
        &__data {
            margin-top: 32px;
            &-item {
                display: flex;
                align-items: flex-start;
                justify-content: space-between;
                font-size: 18px;
                padding: 20px 0;
                border-bottom: 1px solid #000;
                &--large {
                    font-size: 16px;
                    flex-direction: column;
                    gap: 16px;
                }
                &-title {
                    font-size: 16px;
                    font-weight: bold;
                    opacity: 0.5;
                }
                &-body {
                    text-align: right;
                    &--link {
                        color: #99cc65;
                        text-decoration: underline;
                        &:hover {
                            text-decoration: none;
                        }
                    }
                }
                &-icon {
                    position: relative;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    width: 24px;
                    min-width: 24px;
                    aspect-ratio: 1;
                    &::before,
                    &::after {
                        content: '';
                        height: 2px;
                    }
                    &--true {
                        &::before,
                        &::after {
                            position: absolute;
                            bottom: 0;
                            background-color: green;
                        }
                        &::before {
                            left: 0;
                            width: 60%;
                            rotate: 45deg;
                            transform-origin: right;
                        }
                        &::after {
                            right: 45%;
                            width: 90%;
                            rotate: 135deg;
                            transform-origin: right center;
                        }
                    }
                    &--false {
                        &::before,
                        &::after {
                            position: absolute;
                            top: 50%;
                            left: 50%;
                            translate: -50% -50%;
                            width: 100%;
                            background-color: red;
                            transform-origin: center;
                        }
                        &::before {
                            rotate: 45deg;
                        }
                        &::after {
                            rotate: 135deg;
                        }
                    }
                }
            }
        }
        &__structure {
            display: flex;
            flex-direction: column;
            gap: 16px;
            margin-top: 32px;
        }
        &__item {
            display: grid;
            grid-template-columns: max-content auto;
            gap: 16px;
            &-image-container {
                display: block;
                width: 96px;
                min-width: 96px;
                aspect-ratio: 1;
                border-radius: 8px;
                overflow: hidden;
            }
            &-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            &-body {
                display: flex;
                flex-direction: column;
                gap: 16px;
            }
            &-tag {
                font-weight: bold;
                font-size: 14px;
                opacity: 0.5;
            }
            &-title {
                font-size: 20px;
                line-height: 1.2;
            }
            &-desc {
                font-size: 14px;
                font-weight: bold;
                opacity: 0.5;
            }
        }
    }
</style>
