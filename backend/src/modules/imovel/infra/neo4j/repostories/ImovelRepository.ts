import session from '../../../../../infra/neo4j-driver/index';

import ICreateImovelDTO from '../../../dtos/ICreateImovelDTO';
import IImovelModel from '../../../models/IImovelModel';
import IImovelRepository from '../../../repositories/IImovelRepository';

export default class ImovelRepository implements IImovelRepository {
    public async create(data: ICreateImovelDTO): Promise<IImovelModel> {
        const result = await session.run(
            'MATCH (p:Pessoa {uuid: $pessoaUuid}) CREATE (p)<-[:PERTENCE]-(i: Imovel{nome: $nome, quartos: $quartos, banheiros: $banheiros, estacionamento: $estacionamento, uuid: $uuid, gas: $gas, internet: $internet}) RETURN i',
            data,
        );

        const Imovel = result.records[0].get(0).properties;
        return Imovel;
    }
}
