import { Request, Response } from 'express';
import { container } from 'tsyringe';

import DeleteAvatarService from '../../../services/DeleteAvatarService';
import UploadAvatarService from '../../../services/UploadAvatarService';
import GetPessoaService from '../../../services/GetPessoaService';
import CreateCadastroService from '../../../services/CreateCadastroService';
import CreatePessoaService from '../../../services/CreatePessoaService';
import AppError from '../../../../../shared/errors/AppError';

export default class PessoaController {
    public async create(
        request: Request,
        response: Response,
    ): Promise<Response> {
        const createPessoaService = container.resolve(CreatePessoaService);
        const createCadastroService = container.resolve(CreateCadastroService);

        const { nome, email, dataNascimento, cpf, senha, telefone } =
            request.body;

        if (!nome || !email || !dataNascimento || !cpf || !senha || !telefone) {
            throw new AppError('Dados faltantes');
        }

        await createPessoaService.execute({
            cpf,
            dataNascimento,
            email,
            nome,
            telefone,
        });

        const ans = await createCadastroService.execute({
            dataNascimento,
            email,
            nome,
            senha,
            telefone,
        });

        return response.status(200).json(ans);
    }

    public async get(request: Request, response: Response): Promise<Response> {
        const { userEmail } = request;

        const getPessoaService = container.resolve(GetPessoaService);

        const pessoa = await getPessoaService.execute(userEmail);

        return response.status(200).json(pessoa);
    }

    public async uploadAvatar(
        request: Request,
        response: Response,
    ): Promise<Response> {
        const { userEmail } = request;

        const { file } = request;

        if (!file) {
            throw new AppError('Um arquivo de imagem deve ser enviado');
        }

        const uploadAvatarService = container.resolve(UploadAvatarService);
        await uploadAvatarService.execute(file.filename, userEmail);

        return response.status(200).json();
    }

    public async deleteAvatar(
        request: Request,
        response: Response,
    ): Promise<Response> {
        const { userEmail } = request;

        const deleteAvatarService = container.resolve(DeleteAvatarService);
        await deleteAvatarService.execute(userEmail);

        return response.status(204).json();
    }
}
