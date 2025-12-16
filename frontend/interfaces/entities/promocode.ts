export interface IPromocode {
    id: string | number;
    date_created: string;
    date_updated: string | null;

    name: string;
    discount: number;
    required_amount: number;
    available: boolean;
}