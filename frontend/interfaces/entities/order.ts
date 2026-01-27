import type { IUser } from './user';
import type { PaymentStatusType } from '../statuses/payment-status';
import type { OrderStatusType } from '../statuses/order-status';
import type { ICartItem } from './cart-item';

export interface IOrder {
    id: string | number; // Идентификатор сделки
    date_created: string;
    date_updated: string | null;

    user_id: IUser['id'];
    user_email: IUser['email'];
    user_phone: IUser['phone'];
    user_name?: IUser['name'];

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
    delivery: 'courier' | 'pickup' | 'specify';
    delivery_date: string | null;
    delivery_time: string | null;
    delivery_pickup_address: string | null;
    delivery_address: string | null;

    // Открытка
    postcard?: string;
    // Комментарий
    comment?: string;

    // Согласия
    agreement_processing: boolean; // Согласие на обработку данных
    agreement_marketing_notify: boolean; // Согласие получать маркетинговые предложения
}
