import type { IUser } from './user';
import type { PaymentStatusType } from '../statuses/payment-status';
import type { OrderStatusType } from '../statuses/order-status';
import type { ICartItem } from './cart-item';

export interface IOrder {
    id: string | number; // Идентификатор сделки
    date_created: string;
    date_updated: string | null;

    user_id: IUser['id'];

    payment_status: PaymentStatusType; // Статус оплаты
    status?: OrderStatusType;
    amount: number; // Общая сумма
    payment_method: 'sbp' | 'card' | 'on-receipt';

    // Состав заказа
    structure: ICartItem[];

    // Получатель
    recipient_name?: string | null;
    recipient_phone?: string | null;
    recipient_self: boolean; // "Я получатель"
    recipient_anonymous: boolean; // Отправить анонимно
    recipient_notification: boolean; // Позвонить получателю для уточнения
    recipient_secret: boolean; // Не говорить, что цветы

    // Информация о доставке
    delivery_courier: boolean; // Доставка курьером
    delivery_pickup: boolean; // Самовывоз
    delivery_date: string;
    delivery_time:
        | '08:00 - 10:00'
        | '10:00 - 12:00'
        | '12:00 - 14:00'
        | '14:00 - 16:00'
        | '16:00 - 18:00'
        | '18:00 - 20:00';
    delivery_pickup_address: string;
    delivery_address: string;

    // Открытка
    postcard?: string;
    // Комментарий
    comment?: string;

    // Согласия
    agreement_processing: boolean; // Согласие на обработку данных
    agreement_status_notify: boolean; // Согласие на уведомление о статусе заказа
    agreement_marketing_notify: boolean; // Согласие получать маркетинговые предложения
}
