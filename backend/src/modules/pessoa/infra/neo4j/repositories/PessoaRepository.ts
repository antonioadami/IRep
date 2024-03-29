import session from '../../../../../shared/infra/neo4j-driver/index';
import ICreatePessoaDTO from '../../../dtos/ICreatePessoaDTO';
import IPessoaModel from '../../../models/IPessoaModel';
import IPessoasRepository from '../../../repositories/models/IPessoaRepository';

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
            'CREATE(p: Pessoa{nome: $nome, email: $email, cpf: $cpf, dataNascimento: $dataNascimento, telefone: $telefone}) RETURN p',
            data,
        );

        const Pessoa = result.records[0].get(0).properties;
        return Pessoa;
    }

    public async getByEmail(email: string): Promise<IPessoaModel | null> {
        const result = await session.run(
            'MATCH(p: Pessoa{email: $email}) RETURN p',
            { email },
        );

        const Pessoa = result.records[0].get(0).properties;
        return Pessoa;
    }

    public async setAvatar(
        email: string,
        avatarUrl: string,
    ): Promise<IPessoaModel | null> {
        const result = await session.run(
            'MATCH(p: Pessoa{email: $email}) SET p.avatarUrl = $avatarUrl RETURN p',
            { email, avatarUrl },
        );

        const Pessoa = result.records[0].get(0).properties;
        return Pessoa;
    }
}
