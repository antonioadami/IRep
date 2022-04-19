import { Request, Response } from 'express';
import { container } from 'tsyringe';

import LoginService from '@modules/pessoa/services/LoginService';

import AppError from '../../../../../infra/http/errors/AppError';

export default class AuthController {
    public async login(
        request: Request,
        response: Response,
    ): Promise<Response> {
        const loginService = container.resolve(LoginService);
        const { usuario, senha } = request.body;

        if (!usuario || !senha) {
            throw new AppError('Dados faltantes');
        }

        const token = await loginService.execute({ usuario, senha });

        return response.status(200).json({ token });
    }
}
