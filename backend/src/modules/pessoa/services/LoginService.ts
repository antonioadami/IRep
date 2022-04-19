import { inject, injectable } from 'tsyringe';
import { sign } from 'jsonwebtoken';

import AppError from '../../../infra/http/errors/AppError';

import IHashProvider from '../providers/HashProvider/models/IHashProvider';
import ILoginDTO from '../dtos/ILoginDTO';

import ICadastroRepository from '../repositories/ICadastroRepository';

@injectable()
export default class LoginService {
    constructor(
        @inject('HashProvider')
        private hashProvider: IHashProvider,
        @inject('CadastroRepository')
        private cadastroRepository: ICadastroRepository,
    ) {}

    public async execute({ usuario, senha }: ILoginDTO): Promise<string> {
        const cadastro = await this.cadastroRepository.getByUsuario(usuario);

        if (!cadastro) {
            throw new AppError('Usuário ou senha inválido');
        }

        const verify = await this.hashProvider.verify(senha, cadastro.senha);

        if (!verify) {
            throw new AppError('Usuário ou senha inválido');
        }

        const token = sign({}, process.env.JWT_SECRET as string);

        return token;
    }
}
