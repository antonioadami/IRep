import { inject, injectable } from 'tsyringe';

import AppError from '../../../shared/errors/AppError';
import IStorageProvider from '../../../shared/container/providers/StorageProvider/IStorageProvider';
import IImovelRepository from '../repositories/IImovelRepository';

@injectable()
export default class UploadImageService {
    constructor(
        @inject('StorageProvider')
        private storageProvider: IStorageProvider,
        @inject('ImovelRepository')
        private imovelRepository: IImovelRepository,
    ) {}

    public async execute(
        file: string,
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

        const { images } = imovel;

        images.push(file);

        await this.storageProvider.save(file, 'imovel');
        await this.imovelRepository.setImages(uuid, images);
    }
}
