interface IProductStructure {
    name: string;
    quantity?: string | number;
}

export interface IProduct {
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
    structure?: IProductStructure[];
    discount?: number;
    bestseller?: boolean;
    popular?: boolean
}
