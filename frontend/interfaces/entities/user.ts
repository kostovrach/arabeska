import type { ICartItem } from './cart-item';

export interface IUser {
    id: string | number;

    date_created: string;
    date_updated?: string | null;

    name?: string | null;
    phone: string | number;
    email?: string | null;

    notifications: boolean;
    promo_subscribe: boolean;

    addresses?: string[] | null;

    cart?: ICartItem[] | null;

    amocrm_contact_id?: string | number | null;
}
