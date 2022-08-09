import { inject, injectable } from 'tsyringe';

import IPessoaModel from '../models/IPessoaModel';
import IPessoaRepository from '../repositories/IPessoaRepository';

@injectable()
export default class GetPessoaService {
    constructor(
        @inject('PessoaRepository')
        private pessoaRepository: IPessoaRepository,
    ) {}

    public async execute(email: string): Promise<IPessoaModel> {
        const pessoa = await this.pessoaRepository.getByEmail(email);

        return pessoa;
    }
}
