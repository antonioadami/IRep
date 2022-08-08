import {
    ChangePasswordResponse,
    ResendConfirmationCodeResponse,
} from 'aws-sdk/clients/cognitoidentityserviceprovider';
import ICreateCadastroDTO from 'modules/pessoa/dtos/ICreateCadastroDTO';
import IVerificaCadastroDTO from 'modules/pessoa/dtos/IVerificaCadastroDTO';
import ICadastroModel from 'modules/pessoa/models/ICadastroModel';
import ISignUpAnswer from 'modules/pessoa/models/ISignUpAnswer';

export default interface IAuthProvider {
    signIn(user: string, password: string): Promise<ICadastroModel>;
    signUp(attributes: ICreateCadastroDTO): Promise<ISignUpAnswer>;
    verify(data: IVerificaCadastroDTO): Promise<void>;
    resendCode(email: string): Promise<ResendConfirmationCodeResponse>;
    changePassword(
        accessToken: string,
        oldPassword: string,
        newPassword: string,
    ): Promise<ChangePasswordResponse>;
}
