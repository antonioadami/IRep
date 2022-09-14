import { Router } from 'express';
import multer from 'multer';

import uploadConfig from '../../../../../configs/upload';
import ensureAuthenticate from '../../../../pessoa/infra/middlewares/ensureAuthenticate';
import ImovelController from '../controllers/ImovelController';

const imovelRouter = Router();
const upload = multer(uploadConfig);

const imovelController = new ImovelController();

imovelRouter.post('/', ensureAuthenticate(), imovelController.create);
imovelRouter.get('/', imovelController.list);
imovelRouter.get('/:uuid', ensureAuthenticate(true), imovelController.get);
imovelRouter.post(
    '/image',
    ensureAuthenticate(),
    upload.single('file'),
    imovelController.uploadImage,
);
imovelRouter.delete(
    '/image',
    ensureAuthenticate(),
    imovelController.deleteImage,
);
export default imovelRouter;
