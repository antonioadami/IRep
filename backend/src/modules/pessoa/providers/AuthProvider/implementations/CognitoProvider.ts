import {
    CognitoUserPool,
    CognitoUserAttribute,
    CognitoUser,
    ISignUpResult,
    CodeDeliveryDetails,
} from 'amazon-cognito-identity-js';

import ICreateCadastroDTO from 'modules/pessoa/dtos/ICreateCadastroDTO';
import IVerificaCadastroDTO from 'modules/pessoa/dtos/IVerificaCadastroDTO';
import ISignUpAnswer from 'modules/pessoa/models/ISignUpAnswer';
import AppError from '../../../../../infra/http/errors/AppError';
import IAuthProvider from '../models/IAuthProvider';

export default class CognitoProvider implements IAuthProvider {
    private userPool;

    constructor() {
        // Inicializar o provedor de credenciais do Amazon Cognito
        // AWS.config.region = process.env.AWS_REGION; // Região
        // AWS.config.credentials = new AWS.CognitoIdentityCredentials({
        //     IdentityPoolId: process.env.AWS_COGNITO_IDENTITY_POOL_ID as string,
        // });

        this.userPool = new CognitoUserPool({
            UserPoolId: process.env.AWS_COGNITO_USER_POOL_ID as string,
            ClientId: process.env.AWS_COGNITO_CLIENT_ID as string,
        });
    }

    public async signIn(user: string, password: string): Promise<string> {
        throw new Error('Method not implemented.');
    }

    public async signUp(
        attributes: ICreateCadastroDTO,
    ): Promise<ISignUpAnswer> {
        const attributeList: CognitoUserAttribute[] = [];

        attributeList.push(
            new CognitoUserAttribute({
                Name: 'email',
                Value: attributes.email,
            }),
        );

        attributeList.push(
            new CognitoUserAttribute({
                Name: 'phone_number',
                Value: `+55${attributes.telefone}`,
            }),
        );

        attributeList.push(
            new CognitoUserAttribute({
                Name: 'name',
                Value: attributes.nome,
            }),
        );

        attributeList.push(
            new CognitoUserAttribute({
                Name: 'birthdate',
                Value: attributes.dataNascimento,
            }),
        );

        const signUp = new Promise((resolve, reject) => {
            this.userPool.signUp(
                attributes.email,
                attributes.senha,
                attributeList,
                [],
                (err, result) => {
                    if (err) {
                        reject(
                            new AppError(err.message || JSON.stringify(err)),
                        );
                    }
                    resolve(result);
                },
            );
        });

        const ans = (await Promise.resolve(signUp)) as ISignUpResult;

        return {
            codeDeliveryDetails: ans.codeDeliveryDetails,
            username: ans.user.getUsername(),
        };
    }

    public async verify(data: IVerificaCadastroDTO): Promise<void> {
        const cognitoUser = new CognitoUser({
            Username: data.email,
            Pool: this.userPool,
        });

        const verify = new Promise((resolve, reject) => {
            cognitoUser.confirmRegistration(data.code, true, (err, result) => {
                if (err) {
                    reject(new AppError(err.message || JSON.stringify(err)));
                }
                resolve(result);
            });
        });

        await Promise.resolve(verify);
    }

    public async resendCode(email: string): Promise<CodeDeliveryDetails> {
        const cognitoUser = new CognitoUser({
            Username: email,
            Pool: this.userPool,
        });

        const verify = new Promise((resolve, reject) => {
            cognitoUser.resendConfirmationCode((err, result) => {
                if (err) {
                    reject(new AppError(err.message || JSON.stringify(err)));
                }
                resolve(result);
            });
        });

        const ans = (await Promise.resolve(verify)) as CodeDeliveryDetails;

        return ans;
    }
}
