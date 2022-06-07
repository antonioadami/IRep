import { Request, Response, NextFunction } from 'express';
import { JwtPayload, Secret, verify } from 'jsonwebtoken';

import AppError from '../../../../infra/http/errors/AppError';

export default function ensureAuthenticate(
    request: Request,
    response: Response,
    next: NextFunction,
) {
    const auth = request.headers.authorization;

    if (!auth) {
        throw new AppError('JWT token not provided', 401);
    }

    const [, token] = auth.split(' ');

    const secret = process.env.JWT_SECRET as Secret;

    try {
        const decoded = verify(token, secret) as JwtPayload;

        request.user = { uuid: decoded.uuid as string };

        return next();
    } catch {
        throw new AppError('Invalid JWT token', 401);
    }
}
