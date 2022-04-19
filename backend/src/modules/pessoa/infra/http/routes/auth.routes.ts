import { Router } from 'express';
import AuthController from '../controllers/AuthController';

const authRouter = Router();

const authController = new AuthController();

authRouter.post('/login', authController.login);

export default authRouter;
