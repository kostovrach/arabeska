import type { ICartItem } from './cart-item';
import type { IOrder } from './order';
import type { IUserAddress } from './user-address';

export interface IUser {
    id: string | number;

    date_created: string;
    date_updated?: string | null;

    name?: string | null;
    phone: string;
    password: string;
    email?: string | null;

    notifications: boolean;
    promo_subscribe: boolean;

    orders: IOrder[];

    addresses: IUserAddress[];

    cart: ICartItem[];

    amocrm_contact_id?: string | number | null;
}
