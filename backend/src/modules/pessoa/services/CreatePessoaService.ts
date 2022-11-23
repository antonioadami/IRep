import { inject, injectable } from 'tsyringe';

import AppError from '../../../shared/errors/AppError';
import IPessoaModel from '../models/IPessoaModel';
import IPessoaRepository from '../repositories/models/IPessoaRepository';
import ICreatePessoaDTO from '../dtos/ICreatePessoaDTO';

@injectable()
export default class CreatePessoaService {
    constructor(
        @inject('PessoaRepository')
        private pessoaRepository: IPessoaRepository,
    ) {}

    public async execute({
        cpf,
        dataNascimento,
        email,
        nome,
        telefone,
    }: ICreatePessoaDTO): Promise<IPessoaModel> {
        const checkPessoaExists = await this.pessoaRepository.checkExistence(
            cpf,
            email,
        );

        if (checkPessoaExists) {
            throw new AppError('Cpf ou email já cadastrado');
        }

        const pessoa = await this.pessoaRepository.create({
            cpf,
            dataNascimento,
            email,
            nome,
            telefone,
        });

        return pessoa;
    }
}
