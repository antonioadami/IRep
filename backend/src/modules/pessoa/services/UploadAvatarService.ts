import { inject, injectable } from 'tsyringe';

import IStorageProvider from '../../../shared/container/providers/StorageProvider/IStorageProvider';
import IPessoaRepository from '../repositories/IPessoaRepository';

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

        if (user.avatarUrl) {
            await this.storageProvider.delete(user.avatarUrl, 'avatar');
        }

        await this.storageProvider.save(file, 'avatar');
        await this.pessoaRepository.setAvatar(userEmail, file);
    }
}
