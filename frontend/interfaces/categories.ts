export interface ICategories {
    id: string;
    name: string;
    title?: string | null;
    description?: string | null;
    image?: string;
    image_url?: string;
    available: boolean;
    filters: 'none' | 'standard' | 'roses' | 'additional';
}
