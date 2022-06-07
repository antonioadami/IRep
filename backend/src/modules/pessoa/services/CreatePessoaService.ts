import { inject, injectable } from 'tsyringe';
import { v4 as uuidv4 } from 'uuid';

import AppError from '../../../infra/http/errors/AppError';
import IPessoaModel from '../models/IPessoaModel';
import IPessoaRepository from '../repositories/IPessoaRepository';
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

        const uuid = uuidv4();

        const pessoa = await this.pessoaRepository.create({
            uuid,
            cpf,
            dataNascimento,
            email,
            nome,
            telefone,
        });

        return pessoa;
    }
}
