import session from '../../../../../infra/neo4j-driver/index';
import ICreatePessoaDTO from '../../../dtos/ICreatePessoaDTO';
import IPessoaModel from '../../../models/IPessoaModel';
import IPessoasRepository from '../../../repositories/IPessoaRepository';

export default class PessoasRepository implements IPessoasRepository {
    public async create(data: ICreatePessoaDTO): Promise<IPessoaModel> {
        const result = await session.run(
            'CREATE(c: Pessoa{nome: $nome, email: $email, cpf: $cpf, dataNascimento: $dataNascimento}) RETURN c',
            data,
        );

        const Pessoa = result.records[0].get(0).properties;
        return Pessoa;
    }
}
