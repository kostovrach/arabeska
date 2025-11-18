import type { IProduct } from './product';
import type { IUser } from './user';
import type { PaymentStatusType } from '../statuses/payment-status';
import type { OrderStatusType } from '../statuses/order-status';
import type { ProductModifiersType } from '../product-modifiers';

export interface IOrder {
    id: string | number; // Идентификатор сделки
    user: IUser;
    payment_status: PaymentStatusType; // Статус оплаты
    amocrm_status?: OrderStatusType;
    total_amount: string | number; // Общая сумма

    // Состав заказа
    structure: {
        product: IProduct; // Товар
        quantity: string | number; // Количество
        modifier: ProductModifiersType; // Модификатор
    }[];

    // Отправитель
    sender: {
        name?: string;
        telephone: string | number;
        email?: string;
        self_recipient: boolean;
    };

    // Получатель
    recipient?: {
        name?: string;
        telephone?: string | number;
        anonymous: boolean; // Отправить анонимно
        notification: boolean; // Позвонить получателю для уточнения
        secret: boolean; // Не говорить, что цветы
    };

    // Информация о доставке
    delivery: {
        courier: boolean; // Доставка курьером
        pickup: boolean; // Самовывоз

        date: string;
        time: string;

        address: {
            target: string; // Полный адрес
            flat?: string | number; // Квартира
            entrance?: string | number; // Подъезд
            floor?: string | number; // Этаж
        };
    };

    // Открытка
    postcard?: string;
    // Комментарий
    comment?: string;

    // Согласия
    agreement: {
        processing: boolean; // Согласие на обработку данных
        status_notify: boolean; // Согласие на уведомление о статусе заказа
        marketing_notify: boolean; // Согласие получать маркетинговые предложения
    };
}
