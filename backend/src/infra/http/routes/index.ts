import { Router } from 'express';

import pessoaRouter from '../../../modules/pessoa/infra/http/routes/pessoa.routes';

const routes = Router();
routes.use('/pessoa', pessoaRouter);

export default routes;
