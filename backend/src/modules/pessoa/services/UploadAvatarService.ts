import { inject, injectable } from 'tsyringe';

import IStorageProvider from '../../../shared/container/providers/StorageProvider/IStorageProvider';

@injectable()
export default class UploadAvatarService {
    constructor(
        @inject('StorageProvider')
        private storageProvider: IStorageProvider,
    ) {}

    public async execute(file: string): Promise<void> {
        await this.storageProvider.save(file, 'avatar');
    }
}
