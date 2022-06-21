import { Router } from 'express';

import pessoaRouter from '../../../modules/pessoa/infra/http/routes/pessoa.routes';
import authRouter from '../../../modules/pessoa/infra/http/routes/auth.routes';
import imovelRouter from '../../../modules/imovel/infra/http/routes/imovel.routes';

const routes = Router();
routes.use('/imovel', imovelRouter);
routes.use('/auth', authRouter);
routes.use('/pessoa', pessoaRouter);

routes.get('/test', (req, res) => {
    return res.json({ message: 'OK' });
});

export default routes;
