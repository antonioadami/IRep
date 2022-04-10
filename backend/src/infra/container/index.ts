import { container } from 'tsyringe';

import '../../modules/pessoa/providers';
import ICadastroRepository from '../../modules/pessoa/repositories/ICadastroRepository';
import CadastroRepository from '../../modules/pessoa/infra/neo4j/repositories/CadastroRepository';

import IPessoaRepository from '../../modules/pessoa/repositories/IPessoaRepository';
import PessoaRepository from '../../modules/pessoa/infra/neo4j/repositories/PessoaRepository';

container.registerSingleton<IPessoaRepository>(
    'PessoaRepository',
    PessoaRepository,
);
container.registerSingleton<ICadastroRepository>(
    'CadastroRepository',
    CadastroRepository,
);
