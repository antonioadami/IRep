import { inject, injectable } from 'tsyringe';

import AppError from '../../../infra/http/errors/AppError';

import IHashProvider from '../providers/HashProvider/models/IHashProvider';
import ICreateCadastroDTO from '../dtos/ICreateCadastroDTO';
import ICadastroModel from '../models/ICadastroModel';
import ICadastroRepository from '../repositories/ICadastroRepository';

@injectable()
export default class CreateCadastroService {
    constructor(
        @inject('HashProvider')
        private hashProvider: IHashProvider,
        @inject('CadastroRepository')
        private cadastroRepository: ICadastroRepository,
    ) {}

    public async execute({
        senha,
        usuario,
    }: ICreateCadastroDTO): Promise<ICadastroModel> {
        const checkCadastroExists =
            await this.cadastroRepository.checkExistence(usuario);

        if (checkCadastroExists) {
            throw new AppError('Usuário já cadastrados');
        }

        const senhaCriptografada = await this.hashProvider.generateHash(senha);

        const cadastro = await this.cadastroRepository.create({
            usuario,
            senha: senhaCriptografada,
        });

        return cadastro;
    }
}
