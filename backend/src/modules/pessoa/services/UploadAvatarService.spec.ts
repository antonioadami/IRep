import FakeStorageProvider from '../../../shared/container/providers/StorageProvider/fake/FakeStorageProvider';
import AppError from '../../../shared/errors/AppError';
import ICreatePessoaDTO from '../dtos/ICreatePessoaDTO';
import FakePessoasRepository from '../repositories/fakes/FakePessoaRepository';
import CreatePessoaService from './CreatePessoaService';
import UploadAvatarService from './UploadAvatarService';

let createPessoaService: CreatePessoaService;
let uploadAvatarService: UploadAvatarService;
let fakePessoasRepository: FakePessoasRepository;
let fakeStorageProvider: FakeStorageProvider;

describe('Upload Avatar', () => {
    beforeEach(() => {
        fakeStorageProvider = new FakeStorageProvider();
        fakePessoasRepository = new FakePessoasRepository();
        createPessoaService = new CreatePessoaService(fakePessoasRepository);
        uploadAvatarService = new UploadAvatarService(
            fakeStorageProvider,
            fakePessoasRepository,
        );
    });

    it('Deve apagar avatar anterior para salvar um novo', async () => {
        const email = 'teste@teste.com';
        const filename1 = 'filename1';
        const filename2 = 'filename2';
        const pessoa: ICreatePessoaDTO = {
            cpf: '91716763096',
            dataNascimento: '21/06/2000',
            email,
            nome: 'Teste da Silva',
            telefone: '35999999999',
        };

        await createPessoaService.execute(pessoa);

        await uploadAvatarService.execute(filename1, email);
        await uploadAvatarService.execute(filename2, email);

        const uploadedFiles = fakeStorageProvider.getList();

        expect(uploadedFiles).not.toContain(filename1);
        expect(uploadedFiles).toContain(filename2);
    });

    it('Deve fazer o upload de um avatar com sucesso', async () => {
        const email = 'teste@teste.com';
        const filename = 'filename';
        const pessoa: ICreatePessoaDTO = {
            cpf: '91716763096',
            dataNascimento: '21/06/2000',
            email,
            nome: 'Teste da Silva',
            telefone: '35999999999',
        };

        await createPessoaService.execute(pessoa);

        await uploadAvatarService.execute(filename, email);

        const uploadedFiles = fakeStorageProvider.getList();

        expect(uploadedFiles).toContain(filename);
    });

    it('Deve retornar erro fazer upload de avatar em pessoa não existente', async () => {
        const email = 'teste@teste.com';
        const filename = 'filename';

        expect(async () => {
            await uploadAvatarService.execute(filename, email);
        }).rejects.toBeInstanceOf(AppError);
    });
});
