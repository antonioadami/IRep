import { Request, Response } from 'express';
import { container } from 'tsyringe';

import DeleteImageService from '../../../services/DeleteImageService';
import UploadImageService from '../../../services/UploadImageService';
import CreateImovelService from '../../../services/CreateImovelService';
import ListImoveisService from '../../../services/ListImoveisService';
import GetImovelService from '../../../services/GetImovelService';
import ICreateImovelDTO from '../../../dtos/ICreateImovelDTO';

import AppError from '../../../../../shared/errors/AppError';

export default class ImovelController {
    public async create(
        request: Request,
        response: Response,
    ): Promise<Response> {
        const createImovelService = container.resolve(CreateImovelService);

        const { userEmail } = request;

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

        const imovel = await createImovelService.execute(data, userEmail);

        return response.status(200).json(imovel);
    }

    public async list(request: Request, response: Response): Promise<Response> {
        const listImoveisService = container.resolve(ListImoveisService);

        const imovel = await listImoveisService.execute();

        return response.status(200).json(imovel);
    }

    public async get(request: Request, response: Response): Promise<Response> {
        const getImovelService = container.resolve(GetImovelService);

        const { userEmail } = request;

        const { uuid } = request.params;

        if (!uuid) {
            throw new AppError('Dados faltantes');
        }

        const imovel = await getImovelService.execute(uuid, userEmail);

        return response.status(200).json(imovel);
    }

    public async uploadImage(
        request: Request,
        response: Response,
    ): Promise<Response> {
        const { uuid } = request.body;
        const { file } = request;
        const { userEmail } = request;

        if (!file) {
            throw new AppError('Um arquivo de imagem deve ser enviado');
        }

        const uploadImageService = container.resolve(UploadImageService);
        await uploadImageService.execute(file.filename, userEmail, uuid);

        return response.status(204).json();
    }

    public async deleteImage(
        request: Request,
        response: Response,
    ): Promise<Response> {
        const { uuid, imageUrl } = request.body;
        const { userEmail } = request;

        if (!uuid || !imageUrl) {
            throw new AppError('Informe o uuid do imóvel e a url da imagem');
        }

        const deleteImageService = container.resolve(DeleteImageService);
        await deleteImageService.execute(imageUrl, userEmail, uuid);

        return response.status(204).json();
    }
}
