import AppError from '../../../shared/errors/AppError';
import ICreatePessoaDTO from '../dtos/ICreatePessoaDTO';
import FakePessoasRepository from '../repositories/fakes/FakePessoaRepository';
import CreatePessoaService from './CreatePessoaService';
import GetPessoaService from './GetPessoaService';

let createPessoaService: CreatePessoaService;
let getPessoaService: GetPessoaService;
let fakePessoasRepository: FakePessoasRepository;

describe('Buscar Pessoa', () => {
    beforeEach(() => {
        fakePessoasRepository = new FakePessoasRepository();
        createPessoaService = new CreatePessoaService(fakePessoasRepository);
        getPessoaService = new GetPessoaService(fakePessoasRepository);
    });

    it('Deve buscar uma pessoa existente com sucesso', async () => {
        const email = 'teste@teste.com';
        const pessoa: ICreatePessoaDTO = {
            cpf: '91716763096',
            dataNascimento: '21/06/2000',
            email,
            nome: 'Teste da Silva',
            telefone: '35999999999',
        };

        await createPessoaService.execute(pessoa);
        const resposta = await getPessoaService.execute(email);

        expect(resposta).toEqual(pessoa);
    });

    it('Deve retornar erro ao buscar pessoas inexistente', async () => {
        const email = 'teste@teste.com';

        expect(async () => {
            await getPessoaService.execute(email);
        }).rejects.toBeInstanceOf(AppError);
    });
});
