import { Router } from 'express';
import PessoaController from '../controllers/PessoaController';

const pessoaRouter = Router();

const pessoaController = new PessoaController();

pessoaRouter.post('/', pessoaController.create);

export default pessoaRouter;
