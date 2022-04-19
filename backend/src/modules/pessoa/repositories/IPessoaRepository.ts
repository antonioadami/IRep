import ICreatePessoaDTO from '../dtos/ICreatePessoaDTO';
import IPessoaModel from '../models/IPessoaModel';

export default interface IPessoaRepository {
    create(data: ICreatePessoaDTO): Promise<IPessoaModel>;
    getByEmail(email: string): Promise<IPessoaModel>;
    checkExistence(cpf: string, email: string): Promise<IPessoaModel | null>;
}
