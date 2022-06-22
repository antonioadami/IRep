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

    const splittedToken = auth.split(' ');
    const bearer = splittedToken[0];
    const token = splittedToken[1];

    if (splittedToken.length !== 2 || bearer !== 'Bearer') {
        throw new AppError('Invalid JWT token', 401);
    }

    const secret = process.env.JWT_SECRET as Secret;

    try {
        const decoded = verify(token, secret) as JwtPayload;

        request.user = { uuid: decoded.uuid as string };

        return next();
    } catch {
        throw new AppError('Invalid JWT token', 401);
    }
}
