import AppError from '../../../shared/errors/AppError';
import ICreatePessoaDTO from '../dtos/ICreatePessoaDTO';
import FakePessoasRepository from '../repositories/fakes/FakePessoaRepository';
import CreatePessoaService from './CreatePessoaService';

let createPessoaService: CreatePessoaService;
let fakePessoasRepository: FakePessoasRepository;

describe('Criar Pessoa', () => {
    beforeEach(() => {
        fakePessoasRepository = new FakePessoasRepository();
        createPessoaService = new CreatePessoaService(fakePessoasRepository);
    });

    it('Deve criar uma pessoa com sucesso', async () => {
        const pessoa: ICreatePessoaDTO = {
            cpf: '91716763096',
            dataNascimento: '21/06/2000',
            email: 'teste@teste.com',
            nome: 'Teste da Silva',
            telefone: '35999999999',
        };

        const resposta = await createPessoaService.execute(pessoa);

        expect(resposta).toEqual(pessoa);
    });

    it('Deve retornar erro ao criar duas pessoas com mesmo cpf', async () => {
        const pessoa1: ICreatePessoaDTO = {
            cpf: '91716763096',
            dataNascimento: '21/06/2000',
            email: 'teste@teste.com',
            nome: 'Teste da Silva',
            telefone: '35999999999',
        };

        const pessoa2: ICreatePessoaDTO = {
            cpf: '91716763096',
            dataNascimento: '19/09/2020',
            email: 'email@teste.com',
            nome: 'Teste de Oliveira',
            telefone: '35988888888',
        };

        await createPessoaService.execute(pessoa1);

        expect(async () => {
            await createPessoaService.execute(pessoa2);
        }).rejects.toBeInstanceOf(AppError);
    });

    it('Deve retornar erro ao criar duas pessoas com mesmo email', async () => {
        const pessoa1: ICreatePessoaDTO = {
            cpf: '91716763096',
            dataNascimento: '21/06/2000',
            email: 'teste@teste.com',
            nome: 'Teste da Silva',
            telefone: '35999999999',
        };

        const pessoa2: ICreatePessoaDTO = {
            cpf: '41766428070',
            dataNascimento: '19/09/2020',
            email: 'teste@teste.com',
            nome: 'Teste de Oliveira',
            telefone: '35988888888',
        };

        await createPessoaService.execute(pessoa1);

        expect(async () => {
            await createPessoaService.execute(pessoa2);
        }).rejects.toBeInstanceOf(AppError);
    });
});
