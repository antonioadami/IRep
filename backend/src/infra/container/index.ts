import { container } from 'tsyringe';

import '../../modules/pessoa/providers';

import EnderecoRepository from '../../modules/imovel/infra/neo4j/repostories/EnderecoRepository';
import ImovelRepository from '../../modules/imovel/infra/neo4j/repostories/ImovelRepository';
import IImovelRepository from '../../modules/imovel/repositories/IImovelRepository';
import IEnderecoRepository from '../../modules/imovel/repositories/IEnderecoRepository';
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
container.registerSingleton<IImovelRepository>(
    'ImovelRepository',
    ImovelRepository,
);
container.registerSingleton<IEnderecoRepository>(
    'EnderecoRepository',
    EnderecoRepository,
);
