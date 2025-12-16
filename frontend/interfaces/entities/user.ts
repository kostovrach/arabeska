import type { ICartItem } from './cart-item';
import type { IOrder } from './order';
import type { IUserAddress } from './user-address';

export interface IUser {
    id: string | number;

    date_created: string;
    date_updated?: string | null;

    login_attempts: number;
    last_login_attempt?: string | null;

    name?: string | null;
    phone: string;
    password: string;
    email: string;

    notifications: boolean;
    promo_subscribe: boolean;

    addresses: IUserAddress[];

    cart: ICartItem[];

    used_promocodes: string[] | null;

    amocrm_contact_id?: string | number | null;
}
