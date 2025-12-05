import type { ProductModifiersType } from '../product-modifiers';

export interface ICartItem {
    product_id: string | number;
    quantity?: string | number | null;
    modifier?: ProductModifiersType | null;
}
