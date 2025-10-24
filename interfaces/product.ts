import type { ICertificate } from './certificate';
import type { IAccessory } from './accessory';

interface IProductStructure {
    name: string;
    quantity?: string | number;
}

export interface IProduct extends ICertificate, IAccessory {
    id: string | number;
    available?: boolean;
    date_created: string;
    price: number;
    title: string;
    description?: string;
    size?: string;
    style?: string[];
    reason?: string[];
    images: string[];
    structure?: IProductStructure[];
    discount?: number;
    bestseller?: boolean;
    popular?: boolean;
}
