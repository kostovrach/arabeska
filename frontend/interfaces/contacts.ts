import type { LngLat } from '@yandex/ymaps3-types';

export interface IContacts {
    id: number | string;
    date_created: string;
    date_updated?: string;

    title?: string;

    mail: string;
    phone: string;

    vk?: string;
    ok?: string;
    telegram?: string;
    instagram?: string;
    copyright: string;

    addresses: {
        full_address: string;
        short_address: string;
        working_hours?: string;
        phone?: string;
        description?: string;
        point: {
            coordinates: LngLat;
            type: string;
        };
    }[];

    info_title?: string;
    info_image?: string;
    info_image_url?: string;
    info_blocks?: {
        title: string;
        content: string;
    }[];

    banner_image?: string;
    banner_image_url?: string;
    banner_title?: string;
    banner_content?: string;
    banner_form_enabled: boolean;
}
