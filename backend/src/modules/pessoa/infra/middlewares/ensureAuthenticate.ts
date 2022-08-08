import { Request, Response, NextFunction } from 'express';

import AppError from '../../../../infra/http/errors/AppError';

const ensureAuthenticate = (optional = false) => {
    // eslint-disable-next-line consistent-return
    return async (request: Request, response: Response, next: NextFunction) => {
        const auth = request.headers.authorization;

        if (!optional && !auth) {
            throw new AppError('JWT token not provided', 401);
        }

        if (auth) {
            const splittedToken = auth.split(' ');
            const bearer = splittedToken[0];
            const token = splittedToken[1];

            if (splittedToken.length !== 2 || bearer !== 'Bearer') {
                throw new AppError('Invalid JWT token', 401);
            }

            request.accessToken = token;
        }

        next();
    };
};

export default ensureAuthenticate;
