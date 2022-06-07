import { inject, injectable } from 'tsyringe';

import IPessoaModel from '../models/IPessoaModel';
import IPessoaRepository from '../repositories/IPessoaRepository';

@injectable()
export default class GetPessoaService {
    constructor(
        @inject('PessoaRepository')
        private pessoaRepository: IPessoaRepository,
    ) {}

    public async execute(uuid: string): Promise<IPessoaModel> {
        const pessoa = await this.pessoaRepository.getByUuid(uuid);

        return pessoa;
    }
}
