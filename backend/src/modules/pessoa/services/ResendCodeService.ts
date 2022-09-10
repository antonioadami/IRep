import { ResendConfirmationCodeResponse } from 'aws-sdk/clients/cognitoidentityserviceprovider';
import { inject, injectable } from 'tsyringe';

import IAuthProvider from '../providers/AuthProvider/IAuthProvider';

@injectable()
export default class ResendCodeService {
    constructor(
        @inject('AuthProvider')
        private authProvider: IAuthProvider,
    ) {}

    public async execute(
        email: string,
    ): Promise<ResendConfirmationCodeResponse> {
        const ans = await this.authProvider.resendCode(email);
        return ans;
    }
}
