import { inject, injectable } from 'tsyringe';

import ICreateCadastroDTO from '../dtos/ICreateCadastroDTO';
import IAuthProvider from '../providers/AuthProvider/IAuthProvider';
import ISignUpAnswer from '../models/ISignUpAnswer';

@injectable()
export default class CreateCadastroService {
    constructor(
        @inject('AuthProvider')
        private authProvider: IAuthProvider,
    ) {}

    public async execute(data: ICreateCadastroDTO): Promise<ISignUpAnswer> {
        const ans = await this.authProvider.signUp(data);

        return ans;
    }
}
