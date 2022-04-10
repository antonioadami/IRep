import { inject, injectable } from 'tsyringe';

// import AppError from '../../../infra/errors/AppError';

import IPessoaModel from '../models/IPessoaModel';
import IHashProvider from '../providers/HashProvider/models/IHashProvider';
import IPessoaRepository from '../repositories/IPessoaRepository';
import ICreatePessoaDTO from '../dtos/ICreatePessoaDTO';

@injectable()
export default class CreatePessoaService {
    constructor(
        @inject('HashProvider')
        private hashProvider: IHashProvider,
        @inject('PessoaRepository')
        private pessoaRepository: IPessoaRepository,
    ) {}

    public async execute({
        cpf,
        dataNascimento,
        email,
        nome,
    }: ICreatePessoaDTO): Promise<IPessoaModel> {
        // const checkClientExists = await this.clientsRepository.findByCPF(cpf);

        // if (checkClientExists) {
        //     throw new AppError('CPF already used');
        // }

        // const hashedPassword = await this.hashProvider.generateHash(password);

        const pessoa = await this.pessoaRepository.create({
            cpf,
            dataNascimento,
            email,
            nome,
        });

        // delete pessoa.password;

        return pessoa;
    }
}
