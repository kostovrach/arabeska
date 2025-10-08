interface IUser {
    avatar?: string;
    name: string;
}

export interface IFeedback {
    id: string | number;
    rate: 1 | 2 | 3 | 4 | 5;
    text?: string;
    user: IUser;
}
