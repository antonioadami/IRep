import { inject, injectable } from 'tsyringe';

import AppError from '../../../shared/errors/AppError';

import IPessoaModel from '../models/IPessoaModel';
import IPessoaRepository from '../repositories/models/IPessoaRepository';

@injectable()
export default class GetPessoaService {
    constructor(
        @inject('PessoaRepository')
        private pessoaRepository: IPessoaRepository,
    ) {}

    public async execute(email: string): Promise<IPessoaModel> {
        const pessoa = await this.pessoaRepository.getByEmail(email);

        if (!pessoa) {
            throw new AppError('Usuário não encontrado');
        }

        if (pessoa.avatarUrl) {
            pessoa.avatarUrl = `${process.env.AWS_BUCKET_URL}/avatar/${pessoa.avatarUrl}`;
        }

        return pessoa;
    }
}
