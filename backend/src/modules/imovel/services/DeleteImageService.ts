import { inject, injectable } from 'tsyringe';

import AppError from '../../../shared/errors/AppError';
import IStorageProvider from '../../../shared/container/providers/StorageProvider/IStorageProvider';
import IImovelRepository from '../repositories/IImovelRepository';

@injectable()
export default class DeleteImageService {
    constructor(
        @inject('StorageProvider')
        private storageProvider: IStorageProvider,
        @inject('ImovelRepository')
        private imovelRepository: IImovelRepository,
    ) {}

    public async execute(
        fileUrl: string,
        userEmail: string,
        uuid: string,
    ): Promise<void> {
        const imovel = await this.imovelRepository.getAuthenticated(
            uuid,
            userEmail,
        );

        if (!imovel) {
            throw new AppError('O imóvel informado não pertence a você');
        }

        const filename = fileUrl.replace(
            `${process.env.AWS_BUCKET_URL}/imovel/`,
            '',
        );

        const { images } = imovel;

        const imageIndex = images.indexOf(filename);

        if (imageIndex === -1) {
            throw new AppError('Imagem não encontrada');
        }

        images.splice(imageIndex, 1);

        await this.storageProvider.delete(filename, 'imovel');
        await this.imovelRepository.setImages(uuid, images);
    }
}
