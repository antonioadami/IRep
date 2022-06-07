import session from '../../../../../infra/neo4j-driver/index';
import ICreateCadastroDTO from '../../../dtos/ICreateCadastroDTO';
import ICadastroModel from '../../../models/ICadastroModel';
import ICadastroRepository from '../../../repositories/ICadastroRepository';

export default class CadastroRepository implements ICadastroRepository {
    public async checkExistence(
        usuario: string,
    ): Promise<ICadastroModel | null> {
        const result = await session.run(
            'MATCH (c: Cadastro) where c.usuario=$usuario RETURN c',
            { usuario },
        );

        if (result.records[0]) {
            return result.records[0].get(0).properties;
        }

        return null;
    }

    public async create(data: ICreateCadastroDTO): Promise<ICadastroModel> {
        const result = await session.run(
            'MATCH (p: Pessoa{email:$usuario}) CREATE (p)-[:PERTENCE]->(c: Cadastro{usuario: $usuario, senha: $senha}) RETURN c, p.uuid',
            data,
        );

        const Cadastro = result.records[0].get(0).properties;
        return Cadastro;
    }

    public async getByUsuario(usuario: string): Promise<ICadastroModel> {
        const result = await session.run(
            'MATCH (p:Pessoa)-[:PERTENCE]->(c: Cadastro{usuario:$usuario}) RETURN c, p.uuid',
            { usuario },
        );

        const Cadastro =
            result.records.length > 0
                ? result.records[0].get(0).properties
                : null;

        const uuid = result.records[0].get(1);
        return { ...Cadastro, uuid };
    }
}
