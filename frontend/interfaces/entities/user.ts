export interface IUser {
    id: string | number;

    date_created: string;
    date_updated?: string | null;

    name?: string | null;
    telephone: string | number;
    email?: string | null;

    amocrm_contact_id?: string | number | null;
}
