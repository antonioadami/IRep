import ICreateEnderecoDTO from '../dtos/ICreateEnderecoDTO';
import IEnderecoModel from '../models/IEnderecoModel';

export default interface IEnderecoRepository {
    create(data: ICreateEnderecoDTO): Promise<IEnderecoModel>;
}
