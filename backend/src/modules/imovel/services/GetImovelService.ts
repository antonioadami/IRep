import { inject, injectable } from 'tsyringe';

import IImovelModel from '../models/IImovelModel';
import IEnderecoRepository from '../repositories/IEnderecoRepository';
import IImovelRepository from '../repositories/IImovelRepository';

@injectable()
export default class GetImovelService {
    constructor(
        @inject('ImovelRepository')
        private imovelRepository: IImovelRepository,
        @inject('EnderecoRepository')
        private enderecoRepository: IEnderecoRepository,
    ) {}

    public async execute(
        uuid: string,
        isAuthenticated: boolean,
    ): Promise<IImovelModel> {
        const imovel = await this.imovelRepository.get(uuid);

        if (isAuthenticated) {
            const endereco = await this.enderecoRepository.get(uuid);
            imovel.endereco = endereco;
        }

        return imovel;
    }
}
