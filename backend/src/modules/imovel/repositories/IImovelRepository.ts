import ICreateImovelDTO from '../dtos/ICreateImovelDTO';
import IImovelModel from '../models/IImovelModel';

export default interface IImovelRepository {
    create(data: ICreateImovelDTO): Promise<IImovelModel>;
    list(): Promise<IImovelModel[]>;
}
