import type { ICategories } from './categories';

export interface ISettings {
    id: number | string;
    date_created: string;
    date_updated?: string;

    products_info: {
        title: string;
        content: string;
    }[];

    subscription_category: ICategories;
    disable_controls: {
        id: number | string;
        settings_id: any;
        categories_id: ICategories;
    }[];

    delivery_price: number;
    delivery_disable_price: number;
}
