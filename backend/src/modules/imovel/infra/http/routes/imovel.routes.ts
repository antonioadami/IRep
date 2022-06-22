import { Router } from 'express';
import ensureAuthenticate from '../../../../pessoa/infra/middlewares/ensureAuthenticate';
import ImovelController from '../controllers/ImovelController';

const imovelRouter = Router();

const imovelController = new ImovelController();

imovelRouter.post('/', ensureAuthenticate, imovelController.create);
// imovelRouter.get('/', ensureAuthenticate, imovelController.get);

export default imovelRouter;
