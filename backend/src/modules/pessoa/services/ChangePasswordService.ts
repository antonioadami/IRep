import { inject, injectable } from 'tsyringe';

import IAuthProvider from '../providers/AuthProvider/IAuthProvider';

@injectable()
export default class ChangePasswordService {
    constructor(
        @inject('AuthProvider')
        private authProvider: IAuthProvider,
    ) {}

    public async execute(
        accessToken: string,
        oldPassword: string,
        newPassword: string,
    ): Promise<void> {
        await this.authProvider.changePassword(
            accessToken,
            newPassword,
            oldPassword,
        );
    }
}
