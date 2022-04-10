import session from '../../../../../infra/neo4j-driver/index';
import ICreatePessoaDTO from '../../../dtos/ICreatePessoaDTO';
import IPessoaModel from '../../../models/IPessoaModel';
import IPessoasRepository from '../../../repositories/IPessoaRepository';

export default class PessoasRepository implements IPessoasRepository {
    public async checkExistence(
        cpf: string,
        email: string,
    ): Promise<IPessoaModel | null> {
        const result = await session.run(
            'MATCH(p: Pessoa) where p.cpf=$cpf or p.email=$email RETURN p',
            { cpf, email },
        );

        if (result.records[0]) {
            return result.records[0].get(0).properties;
        }

        return null;
    }

    public async create(data: ICreatePessoaDTO): Promise<IPessoaModel> {
        const result = await session.run(
            'CREATE(p: Pessoa{nome: $nome, email: $email, cpf: $cpf, dataNascimento: $dataNascimento}) RETURN p',
            data,
        );

        const Pessoa = result.records[0].get(0).properties;
        return Pessoa;
    }
}
