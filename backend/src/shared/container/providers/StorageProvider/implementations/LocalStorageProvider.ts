import fs from 'fs';
import { resolve } from 'path';

import upload from '../../../../../configs/upload';
import IStorageProvider from '../IStorageProvider';

export default class LocalStorageProvider implements IStorageProvider {
    public async save(file: string, folder: string): Promise<string> {
        await fs.promises.rename(
            resolve(upload.tmpFolder, file),
            resolve(`${upload.tmpFolder}/${folder}`, file),
        );

        return file;
    }

    public async delete(file: string, folder: string): Promise<void> {
        const filename = resolve(`${upload.tmpFolder}/${folder}`, file);

        try {
            await fs.promises.stat(filename);
        } catch {
            return;
        }

        await fs.promises.unlink(filename);
    }
}
