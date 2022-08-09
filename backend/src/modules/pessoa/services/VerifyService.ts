import { inject, injectable } from 'tsyringe';
import IVerificaCadastroDTO from '../dtos/IVerificaCadastroDTO';

import IAuthProvider from '../providers/AuthProvider/models/IAuthProvider';

@injectable()
export default class VerifyService {
    constructor(
        @inject('AuthProvider')
        private authProvider: IAuthProvider,
    ) {}

    public async execute(data: IVerificaCadastroDTO): Promise<void> {
        await this.authProvider.verify(data);
    }
}
