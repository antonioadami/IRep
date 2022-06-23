import { inject, injectable } from 'tsyringe';

import IImovelModel from '../models/IImovelModel';

import IPessoaRepository from '../../pessoa/repositories/IPessoaRepository';
import IEnderecoRepository from '../repositories/IEnderecoRepository';
import IImovelRepository from '../repositories/IImovelRepository';

@injectable()
export default class GetImovelService {
    constructor(
        @inject('ImovelRepository')
        private imovelRepository: IImovelRepository,
        @inject('EnderecoRepository')
        private enderecoRepository: IEnderecoRepository,
        @inject('PessoaRepository')
        private pessoaRepository: IPessoaRepository,
    ) {}

    public async execute(
        uuid: string,
        userUuid: string,
    ): Promise<IImovelModel> {
        const imovel = await this.imovelRepository.get(uuid);

        if (userUuid) {
            const endereco = await this.enderecoRepository.get(uuid);
            const pessoa = await this.pessoaRepository.getByUuid(userUuid);
            imovel.endereco = endereco;
            imovel.contato = { email: pessoa.email, telefone: pessoa.telefone };
        }

        return imovel;
    }
}
