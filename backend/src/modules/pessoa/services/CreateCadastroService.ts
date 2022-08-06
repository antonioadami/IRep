import { inject, injectable } from 'tsyringe';

import IHashProvider from '../providers/HashProvider/models/IHashProvider';
import ICreateCadastroDTO from '../dtos/ICreateCadastroDTO';
import IAuthProvider from '../providers/AuthProvider/models/IAuthProvider';
import ISignUpAnswer from '../models/ISignUpAnswer';

@injectable()
export default class CreateCadastroService {
    constructor(
        @inject('HashProvider')
        private hashProvider: IHashProvider,
        @inject('AuthProvider')
        private authProvider: IAuthProvider,
    ) {}

    public async execute(data: ICreateCadastroDTO): Promise<ISignUpAnswer> {
        const ans = await this.authProvider.signUp(data);

        return ans;
    }
}
