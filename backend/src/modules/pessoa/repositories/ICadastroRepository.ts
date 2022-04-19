import ICreateCadastroDTO from '../dtos/ICreateCadastroDTO';
import ICadastroModel from '../models/ICadastroModel';

export default interface ICadastroRepository {
    create(data: ICreateCadastroDTO): Promise<ICadastroModel>;
    getByUsuario(usuario: string): Promise<ICadastroModel>;
    checkExistence(usuario: string): Promise<ICadastroModel | null>;
}
