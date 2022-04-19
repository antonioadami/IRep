import { Request, Response } from 'express';
import { container } from 'tsyringe';

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

        const { nome, email, dataNascimento, cpf, senha } = request.body;

        if (!nome || !email || !dataNascimento || !cpf || !senha) {
            throw new AppError('Dados faltantes');
        }

        const dataNasc = dataNascimento;

        const pessoa = await createPessoaService.execute({
            cpf,
            dataNascimento: dataNasc,
            email,
            nome,
        });

        await createCadastroService.execute({
            usuario: email,
            senha,
        });

        return response.status(200).json(pessoa);
    }
}
