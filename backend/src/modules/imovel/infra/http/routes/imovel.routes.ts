import { Router } from 'express';
import ensureAuthenticate from '../../../../pessoa/infra/middlewares/ensureAuthenticate';
import ImovelController from '../controllers/ImovelController';

const imovelRouter = Router();

const imovelController = new ImovelController();

imovelRouter.post('/', ensureAuthenticate(), imovelController.create);
imovelRouter.get('/', imovelController.list);
imovelRouter.get('/:uuid', ensureAuthenticate(true), imovelController.get);

export default imovelRouter;
