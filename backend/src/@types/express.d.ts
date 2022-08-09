declare namespace Express {
    export interface Request {
        accessToken: string;
        userEmail: string;
    }
}
