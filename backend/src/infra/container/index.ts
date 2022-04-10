import { container } from 'tsyringe';

import '../../modules/pessoa/providers';
import IPessoaRepository from '../../modules/pessoa/repositories/IPessoaRepository';
import PessoaRepository from '../../modules/pessoa/infra/neo4j/repositories/PessoaRepository';

container.registerSingleton<IPessoaRepository>(
    'PessoaRepository',
    PessoaRepository,
);
