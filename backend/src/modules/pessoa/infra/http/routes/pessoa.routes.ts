import { Router } from 'express';
import multer from 'multer';
import uploadConfig from '../../../../../configs/upload';

import ensureAuthenticate from '../../middlewares/ensureAuthenticate';
import PessoaController from '../controllers/PessoaController';

const upload = multer(uploadConfig);

const pessoaRouter = Router();

const pessoaController = new PessoaController();

pessoaRouter.post('/', pessoaController.create);
pessoaRouter.post(
    '/avatar',
    ensureAuthenticate(),
    upload.single('file'),
    pessoaController.uploadAvatar,
);
pessoaRouter.delete(
    '/avatar',
    ensureAuthenticate(),
    pessoaController.deleteAvatar,
);
pessoaRouter.get('/', ensureAuthenticate(), pessoaController.get);

export default pessoaRouter;
