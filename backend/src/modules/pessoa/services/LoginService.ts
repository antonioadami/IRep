import { inject, injectable } from 'tsyringe';
// import { sign } from 'jsonwebtoken';

import AppError from '../../../infra/http/errors/AppError';

import ILoginDTO from '../dtos/ILoginDTO';

import IAuthProvider from '../providers/AuthProvider/models/IAuthProvider';

@injectable()
export default class LoginService {
    constructor(
        @inject('AuthProvider')
        private authProvider: IAuthProvider,
    ) {}

    public async execute({ usuario, senha }: ILoginDTO): Promise<string> {
        const ans = await this.authProvider.signIn(usuario, senha);

        if (!ans) {
            throw new AppError('Usuário ou senha inválido');
        }

        // const token = sign(
        //     { uuid: cadastro.uuid },
        //     process.env.JWT_SECRET as string,
        // );

        return ans;
    }
}
