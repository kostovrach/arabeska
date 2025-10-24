import type { IProduct } from './product';
import type { IAccessory } from './accessory';
import type { ICertificate } from './certificate';
import type { IFeedback } from './feedback';

export interface IDatabase {
    products: IProduct[];
    accessories: IAccessory[];
    certificates: ICertificate[];
    feedback: IFeedback[];
}
