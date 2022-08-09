import { CodeDeliveryDetails } from 'amazon-cognito-identity-js';
import { inject, injectable } from 'tsyringe';

import IAuthProvider from '../providers/AuthProvider/models/IAuthProvider';

@injectable()
export default class ResendCodeService {
    constructor(
        @inject('AuthProvider')
        private authProvider: IAuthProvider,
    ) {}

    public async execute(email: string): Promise<CodeDeliveryDetails> {
        const ans = await this.authProvider.resendCode(email);
        return ans;
    }
}
