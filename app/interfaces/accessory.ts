interface IAccessoryStructure {
    name?: string;
    quantity?: string | number;
}

export interface IAccessory {
    id: string | number;
    available?: boolean;
    date_created: string;
    quantity?: number;
    price: number;
    discount?: number;
    title: string;
    description?: string;
    size?: string;
    reason?: string[];
    images: string[];
    structure?: IAccessoryStructure[];
}
