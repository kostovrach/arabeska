import type { IUser } from './user';

export interface IResetOtp {
    id: string | number;
    date_created: string;
    user_id: IUser['id'];
    code: string;
    expires_at: string;
    attempts: number;
}
