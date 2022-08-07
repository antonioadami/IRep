import ICreateCadastroDTO from 'modules/pessoa/dtos/ICreateCadastroDTO';
import IVerificaCadastroDTO from 'modules/pessoa/dtos/IVerificaCadastroDTO';
import ISignUpAnswer from 'modules/pessoa/models/ISignUpAnswer';

export default interface IAuthProvider {
    signIn(user: string, password: string): Promise<string>;
    signUp(attributes: ICreateCadastroDTO): Promise<ISignUpAnswer>;
    verify(data: IVerificaCadastroDTO): Promise<void>;
}
