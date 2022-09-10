import { inject, injectable } from 'tsyringe';
import { v4 as uuidv4 } from 'uuid';

import ICreateImovelDTO from '../dtos/ICreateImovelDTO';
import IImovelModel from '../models/IImovelModel';
import IEnderecoRepository from '../repositories/IEnderecoRepository';
import IImovelRepository from '../repositories/IImovelRepository';

@injectable()
export default class CreateImovelService {
    constructor(
        @inject('ImovelRepository')
        private imovelRepository: IImovelRepository,
        @inject('EnderecoRepository')
        private enderecoRepository: IEnderecoRepository,
    ) {}

    public async execute(
        data: ICreateImovelDTO,
        userEmail: string,
    ): Promise<IImovelModel> {
        const uuidImovel = uuidv4();
        const uuidEndereco = uuidv4();

        const imovel = await this.imovelRepository.create({
            ...data,
            images: [],
            uuid: uuidImovel,
            userEmail,
        });
        const endereco = await this.enderecoRepository.create({
            ...data.endereco,
            uuid: uuidEndereco,
            uuidImovel,
        });

        imovel.endereco = endereco;

        return imovel;
    }
}
