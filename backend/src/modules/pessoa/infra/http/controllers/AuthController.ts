import { Request, Response } from 'express';
import { container } from 'tsyringe';

import VerifyService from '../../../services/VerifyService';
import LoginService from '../../../services/LoginService';

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

    public async verify(
        request: Request,
        response: Response,
    ): Promise<Response> {
        const verifyService = container.resolve(VerifyService);
        const { email, code } = request.body;

        if (!email || !code) {
            throw new AppError('Dados faltantes');
        }

        await verifyService.execute({ email, code });

        return response.status(200).json();
    }
}
