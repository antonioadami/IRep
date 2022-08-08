import { Router } from 'express';
import ensureAuthenticate from '../../middlewares/ensureAuthenticate';
import AuthController from '../controllers/AuthController';

const authRouter = Router();

const authController = new AuthController();

authRouter.post('/login', authController.login);
authRouter.post('/verify', authController.verify);
authRouter.post('/resendCode', authController.resendCode);
authRouter.post(
    '/changePassword',
    ensureAuthenticate(),
    authController.changePassword,
);

export default authRouter;
