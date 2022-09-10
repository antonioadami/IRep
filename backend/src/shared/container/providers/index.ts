import { container } from 'tsyringe';

import IStorageProvider from './StorageProvider/IStorageProvider';
// import LocalStorageProvider from './StorageProvider/implementations/LocalStorageProvider';
import S3StorageProvider from './StorageProvider/implementations/S3StorageProvider';

container.registerSingleton<IStorageProvider>(
    'StorageProvider',
    S3StorageProvider,
);
