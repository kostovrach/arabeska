import type { ISeo } from '../seo';

// images ========================================
interface IProductImages {
    id: number | string;
    directus_files_id: {
        id: string;
        created_on?: string;
        filename_disk?: string;
        filename_download?: string;
        height?: number;
        width?: number;
        type?: string;
    };
}
// ===============================================

// categories ====================================
interface IProductCategories {
    id?: number | string;
    products_id?: any;
    categories_id?: {
        id?: number | string;
        name?: string;
        available?: boolean;
        image?: string | null;
        sort?: number;
    };
}
// ===============================================

// reasons =======================================
interface IProductReasons {
    id?: number | string;
    products_id?: any;
    reason_id?: {
        id?: number | string;
        name?: string;
    };
}
// ===============================================

// structure =====================================
interface IProductStructure {
    id?: number | string;
    products_id?: any;
    structure_id?: {
        id?: number | string;
        name?: string;
        sort?: number | string;
    };
}
// ===============================================

// styles =====================================
interface IProductStyle {
    id?: number | string;
    products_id?: any;
    styles_id?: {
        id?: number | string;
        name?: string;
    };
}
// ===============================================

export interface IProduct extends ISeo {
    id: number | string;
    date_created: string;
    date_updated?: string | null;

    title: string;
    description?: string;
    size?: string;

    price: number;
    discount?: number;

    images: IProductImages[];

    category?: IProductCategories[];
    structure?: IProductStructure[];
    reason?: IProductReasons[];
    style?: IProductStyle[];

    available: boolean;
    popular: boolean;
}
