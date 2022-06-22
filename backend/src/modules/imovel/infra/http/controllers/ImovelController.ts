import { Request, Response } from 'express';
import { container } from 'tsyringe';

import CreateImovelService from '../../../services/CreateImovelService';
import ICreateImovelDTO from '../../../dtos/ICreateImovelDTO';

import AppError from '../../../../../infra/http/errors/AppError';

export default class ImovelController {
    public async create(
        request: Request,
        response: Response,
    ): Promise<Response> {
        const createImovelService = container.resolve(CreateImovelService);

        const user = request.user.uuid;

        const data = request.body as ICreateImovelDTO;

        if (
            !data.nome ||
            !data.quartos ||
            !data.banheiros ||
            !data.estacionamento ||
            data.gas === undefined ||
            data.internet === undefined ||
            !data.endereco.estado ||
            !data.endereco.cidade ||
            !data.endereco.bairro ||
            !data.endereco.rua ||
            !data.endereco.numero ||
            !data.endereco.cep
        ) {
            throw new AppError('Dados faltantes');
        }

        const imovel = await createImovelService.execute(data, user);

        return response.status(200).json(imovel);
    }
}
