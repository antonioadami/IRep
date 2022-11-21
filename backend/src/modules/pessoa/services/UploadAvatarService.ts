import { inject, injectable } from 'tsyringe';
import AppError from '../../../shared/errors/AppError';

import IStorageProvider from '../../../shared/container/providers/StorageProvider/IStorageProvider';
import IPessoaRepository from '../repositories/models/IPessoaRepository';

@injectable()
export default class UploadAvatarService {
    constructor(
        @inject('StorageProvider')
        private storageProvider: IStorageProvider,
        @inject('PessoaRepository')
        private pessoaRepository: IPessoaRepository,
    ) {}

    public async execute(file: string, userEmail: string): Promise<void> {
        const user = await this.pessoaRepository.getByEmail(userEmail);

        if (!user) {
            throw new AppError('Usuário não encontrado');
        }

        if (user.avatarUrl) {
            await this.storageProvider.delete(user.avatarUrl, 'avatar');
        }

        await this.storageProvider.save(file, 'avatar');
        await this.pessoaRepository.setAvatar(userEmail, file);
    }
}
