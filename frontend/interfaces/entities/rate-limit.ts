export interface IRateLimit {
    id: string | number;
    ip: string;
    attempts: number;
    last_attempt: string | null;
    type: string;
}