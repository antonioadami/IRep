import { inject, injectable } from 'tsyringe';
// import { sign } from 'jsonwebtoken';

import AppError from '../../../shared/errors/AppError';

import ILoginDTO from '../dtos/ILoginDTO';
import ICadastroModel from '../models/ICadastroModel';

import IAuthProvider from '../providers/AuthProvider/IAuthProvider';

@injectable()
export default class LoginService {
    constructor(
        @inject('AuthProvider')
        private authProvider: IAuthProvider,
    ) {}

    public async execute({
        usuario,
        senha,
    }: ILoginDTO): Promise<ICadastroModel> {
        const ans = await this.authProvider.signIn(usuario, senha);

        if (!ans) {
            throw new AppError('Usuário ou senha inválido');
        }

        return ans;
    }
}
