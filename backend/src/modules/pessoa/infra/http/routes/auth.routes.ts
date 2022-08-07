import { Router } from 'express';
import AuthController from '../controllers/AuthController';

const authRouter = Router();

const authController = new AuthController();

authRouter.post('/login', authController.login);
authRouter.post('/verify', authController.verify);
authRouter.post('/resendCode', authController.resendCode);

export default authRouter;
