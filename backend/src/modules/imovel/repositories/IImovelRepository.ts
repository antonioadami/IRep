import ICreateImovelDTO from '../dtos/ICreateImovelDTO';
import IImovelModel from '../models/IImovelModel';

export default interface IImovelRepository {
    create(data: ICreateImovelDTO): Promise<IImovelModel>;
    list(): Promise<IImovelModel[]>;
    get(uuid: string): Promise<IImovelModel>;
    getAuthenticated(uuid: string, userEmail: string): Promise<IImovelModel>;
    setImages(uuidImovel: string, images: string[]): Promise<IImovelModel>;
}
