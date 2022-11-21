import ICreatePessoaDTO from 'src/modules/pessoa/dtos/ICreatePessoaDTO';
import IPessoaModel from 'src/modules/pessoa/models/IPessoaModel';
import IPessoasRepository from '../models/IPessoaRepository';

export default class FakePessoasRepository implements IPessoasRepository {
    private pessoas: IPessoaModel[] = [];

    public async checkExistence(
        cpf: string,
        email: string,
    ): Promise<IPessoaModel | null> {
        const pessoa = this.pessoas.find(
            p => p.cpf === cpf || p.email === email,
        );

        if (!pessoa) {
            return null;
        }
        return pessoa;
    }

    public async create(data: ICreatePessoaDTO): Promise<IPessoaModel> {
        const pessoa = data as IPessoaModel;
        this.pessoas.push(pessoa);

        return pessoa;
    }

    public async getByEmail(email: string): Promise<IPessoaModel | null> {
        const pessoa = this.pessoas.find(p => p.email === email);

        if (!pessoa) {
            return null;
        }
        return pessoa;
    }

    public async setAvatar(
        email: string,
        avatarUrl: string,
    ): Promise<IPessoaModel | null> {
        const index = this.pessoas.findIndex(p => p.email === email);

        this.pessoas[index].avatarUrl = avatarUrl;

        return this.pessoas[index];
    }
}
