/* eslint-disable @typescript-eslint/no-unused-vars */
import IStorageProvider from '../IStorageProvider';

export default class FakeStorageProvider implements IStorageProvider {
    private files: string[] = [];

    public async save(file: string, folder: string): Promise<string> {
        this.files.push(file);

        return file;
    }

    public async delete(file: string, folder: string): Promise<void> {
        const index = this.files.findIndex(f => f === file);
        if (index !== -1) {
            this.files.splice(index, 1);
        }
    }

    public getList(): string[] {
        return this.files;
    }
}
