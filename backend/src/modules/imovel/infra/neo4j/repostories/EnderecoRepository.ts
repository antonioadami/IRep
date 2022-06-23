import session from '../../../../../infra/neo4j-driver/index';
import ICreateEnderecoDTO from '../../../dtos/ICreateEnderecoDTO';
import IEnderecoModel from '../../../models/IEnderecoModel';
import IEnderecoRepository from '../../../repositories/IEnderecoRepository';

export default class EnderecoRepository implements IEnderecoRepository {
    public async create(data: ICreateEnderecoDTO): Promise<IEnderecoModel> {
        const result = await session.run(
            'MATCH (i: Imovel{uuid:$uuidImovel}) CREATE (i)-[:LOCALIZA_SE]->(e: Endereco{uuid: $uuid, estado: $estado, cidade: $cidade, bairro: $bairro, rua: $rua, cep: $cep, numero: $numero}) RETURN e',
            data,
        );

        const Endereco = result.records[0].get(0).properties;
        return Endereco;
    }

    public async get(uuidImovel: string): Promise<IEnderecoModel> {
        const result = await session.run(
            'MATCH (i: Imovel{uuid:$uuidImovel})-[:LOCALIZA_SE]->(e) RETURN e',
            { uuidImovel },
        );

        const Endereco = result.records[0].get(0).properties;
        return Endereco;
    }
}
