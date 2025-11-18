export interface IFeedback {
    id: string | number;
    rate: 1 | 2 | 3 | 4 | 5;
    text?: string;
    avatar?: string;
    avatar_url?: string;
    name: string;
    available: boolean;
}
