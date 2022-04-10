import ICreatePessoaDTO from '../dtos/ICreatePessoaDTO';
import IPessoaModel from '../models/IPessoaModel';

export default interface IPessoaRepository {
    create(data: ICreatePessoaDTO): Promise<IPessoaModel>;
}
