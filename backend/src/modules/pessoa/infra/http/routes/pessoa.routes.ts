import { Router } from 'express';
import ensureAuthenticate from '../../middlewares/ensureAuthenticate';
import PessoaController from '../controllers/PessoaController';

const pessoaRouter = Router();

const pessoaController = new PessoaController();

pessoaRouter.post('/', pessoaController.create);
pessoaRouter.get('/', ensureAuthenticate, pessoaController.get);

export default pessoaRouter;
