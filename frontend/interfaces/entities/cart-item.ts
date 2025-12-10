import type { ProductModifiersType } from '../product-modifiers';
import type { IProduct } from './product';

export interface ICartItem {
    product_id: IProduct['id'];
    quantity: string | number;
    modifier: ProductModifiersType;
}
