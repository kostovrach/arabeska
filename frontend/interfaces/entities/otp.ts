export interface IOtp {
    id: string | number;
    date_created: string;
    date_updated?: string | null;
    phone: string;
    code: string;
    expires_at: string;
    attempts: number;
}
