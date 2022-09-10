import session from '../../../../../shared/infra/neo4j-driver/index';

import ICreateImovelDTO from '../../../dtos/ICreateImovelDTO';
import IImovelModel from '../../../models/IImovelModel';
import IImovelRepository from '../../../repositories/IImovelRepository';

export default class ImovelRepository implements IImovelRepository {
    public async create(data: ICreateImovelDTO): Promise<IImovelModel> {
        const result = await session.run(
            'MATCH (p:Pessoa {email: $userEmail}) CREATE (p)<-[:PERTENCE]-(i: Imovel{nome: $nome, quartos: $quartos, banheiros: $banheiros, estacionamento: $estacionamento, uuid: $uuid, gas: $gas, internet: $internet, images: $images}) RETURN i',
            data,
        );

        const imovel = result.records[0].get(0).properties;
        return imovel;
    }

    public async list(): Promise<IImovelModel[]> {
        const result = await session.run('MATCH (i: Imovel) RETURN i');

        const imoveis = result.records.map(record => record.get(0).properties);

        return imoveis;
    }

    public async get(uuid: string): Promise<IImovelModel> {
        const result = await session.run(
            'MATCH (i: Imovel {uuid: $uuid}) RETURN i',
            { uuid },
        );

        const imovel = result.records[0]?.get(0).properties;
        return imovel;
    }

    public async getAuthenticated(
        uuid: string,
        userEmail: string,
    ): Promise<IImovelModel> {
        const result = await session.run(
            'MATCH (p:Pessoa {email: $userEmail})<-[:PERTENCE]-(i: Imovel {uuid: $uuid})  RETURN i',
            { uuid, userEmail },
        );

        const imovel = result.records[0]?.get(0).properties;
        return imovel;
    }

    public async setImages(
        uuid: string,
        images: string[],
    ): Promise<IImovelModel> {
        const result = await session.run(
            'MATCH (i: Imovel {uuid: $uuid}) set i.images = $images RETURN i',
            { uuid, images },
        );

        const imovel = result.records[0]?.get(0).properties;
        return imovel;
    }
}
