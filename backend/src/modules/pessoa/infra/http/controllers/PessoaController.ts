import { Request, Response } from 'express';
import { container } from 'tsyringe';

import GetPessoaService from '../../../services/GetPessoaService';
import CreateCadastroService from '../../../services/CreateCadastroService';
import CreatePessoaService from '../../../services/CreatePessoaService';
import AppError from '../../../../../infra/http/errors/AppError';

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
        const { uuid } = request.user;

        const getPessoaService = container.resolve(GetPessoaService);

        const pessoa = await getPessoaService.execute(uuid);

        return response.status(200).json(pessoa);
    }
}
