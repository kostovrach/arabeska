interface ProductStructure {
    name: string;
    quantity?: string | number;
}

export interface Product {
    id: string | number;
    available?: boolean;
    date_created?: string;
    quantity?: number;
    price: number;
    title: string;
    description?: string;
    size?: string;
    style?: string[];
    reason?: string[];
    images: string[] | string;
    structure?: ProductStructure[];
    discount?: number;
    bestseller?: boolean;
    popular?: boolean
}
