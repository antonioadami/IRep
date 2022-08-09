import { CognitoIdentityServiceProvider } from 'aws-sdk';
import { GetUserRequest } from 'aws-sdk/clients/cognitoidentityserviceprovider';
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

            const identityServiceProvider = new CognitoIdentityServiceProvider({
                region: process.env.AWS_SERVICE_REGION,
            });

            const userPromise = new Promise((resolve, reject) => {
                const param: GetUserRequest = {
                    AccessToken: token,
                };
                identityServiceProvider.getUser(param, (err, result) => {
                    if (err) {
                        return reject(
                            new AppError(err.message || JSON.stringify(err)),
                        );
                    }

                    let email = null;

                    result.UserAttributes.forEach(att => {
                        if (att.Name === 'email') {
                            email = att.Value;
                        }
                    });

                    return resolve(email);
                });
            });

            const userEmail = (await Promise.resolve(userPromise)) as string;

            request.userEmail = userEmail;
            request.accessToken = token;
        }

        next();
    };
};

export default ensureAuthenticate;
