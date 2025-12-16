export interface IJwtPayload {
    id: string | number;
    phone: string;
    role: string;
    iat: number;
    exp: number;
}