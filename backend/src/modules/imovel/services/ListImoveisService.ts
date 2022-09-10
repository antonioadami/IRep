import { inject, injectable } from 'tsyringe';

import IImovelModel from '../models/IImovelModel';
import IImovelRepository from '../repositories/IImovelRepository';

@injectable()
export default class ListImoveisService {
    constructor(
        @inject('ImovelRepository')
        private imovelRepository: IImovelRepository,
    ) {}

    public async execute(): Promise<IImovelModel[]> {
        const imoveis = await this.imovelRepository.list();

        imoveis.map(imovel => {
            const imovelAux = imovel;
            imovelAux.images = imovel.images.map(
                image => `${process.env.AWS_BUCKET_URL}/imovel/${image}`,
            );

            return imovelAux;
        });

        return imoveis;
    }
}
