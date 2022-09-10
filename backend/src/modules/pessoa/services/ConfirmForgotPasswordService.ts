import { ForgotPasswordResponse } from 'aws-sdk/clients/cognitoidentityserviceprovider';
import { inject, injectable } from 'tsyringe';

import IAuthProvider from '../providers/AuthProvider/IAuthProvider';

@injectable()
export default class ConfirmForgotPasswordService {
    constructor(
        @inject('AuthProvider')
        private authProvider: IAuthProvider,
    ) {}

    public async execute(
        email: string,
        password: string,
        code: string,
    ): Promise<ForgotPasswordResponse> {
        return this.authProvider.confirmForgotPassword(email, password, code);
    }
}
