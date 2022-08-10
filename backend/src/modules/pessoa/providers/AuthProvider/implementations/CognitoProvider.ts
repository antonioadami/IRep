import { CognitoIdentityServiceProvider } from 'aws-sdk';
import {
    ChangePasswordRequest,
    ChangePasswordResponse,
    ConfirmForgotPasswordRequest,
    ConfirmForgotPasswordResponse,
    ConfirmSignUpRequest,
    ForgotPasswordRequest,
    ForgotPasswordResponse,
    InitiateAuthRequest,
    ResendConfirmationCodeRequest,
    ResendConfirmationCodeResponse,
    SignUpRequest,
    SignUpResponse,
} from 'aws-sdk/clients/cognitoidentityserviceprovider';

import ICreateCadastroDTO from 'modules/pessoa/dtos/ICreateCadastroDTO';
import IVerificaCadastroDTO from 'modules/pessoa/dtos/IVerificaCadastroDTO';
import ICadastroModel from 'modules/pessoa/models/ICadastroModel';
import ISignUpAnswer from 'modules/pessoa/models/ISignUpAnswer';
import AppError from '../../../../../shared/errors/AppError';
import IAuthProvider from '../models/IAuthProvider';

export default class CognitoProvider implements IAuthProvider {
    private identityServiceProvider: CognitoIdentityServiceProvider;

    constructor() {
        this.identityServiceProvider = new CognitoIdentityServiceProvider({
            region: process.env.AWS_SERVICE_REGION,
        });
    }

    public async signIn(
        user: string,
        password: string,
    ): Promise<ICadastroModel> {
        const params: InitiateAuthRequest = {
            ClientId: process.env.AWS_COGNITO_CLIENT_ID as string,
            AuthFlow: 'USER_PASSWORD_AUTH',
            AuthParameters: {
                USERNAME: user,
                PASSWORD: password,
            },
        };

        const signIn = new Promise((resolve, reject) => {
            this.identityServiceProvider.initiateAuth(params, (err, result) => {
                if (err) {
                    return reject(
                        new AppError(err.message || JSON.stringify(err)),
                    );
                }

                return resolve({
                    token: result.AuthenticationResult?.AccessToken,
                    refreshToken: result.AuthenticationResult?.RefreshToken,
                });
            });
        });

        const ans = (await Promise.resolve(signIn)) as ICadastroModel;

        return ans;
    }

    public async signUp(
        attributes: ICreateCadastroDTO,
    ): Promise<ISignUpAnswer> {
        const params: SignUpRequest = {
            ClientId: process.env.AWS_COGNITO_CLIENT_ID as string,
            Password: attributes.senha,
            Username: attributes.email,
            UserAttributes: [
                {
                    Name: 'email',
                    Value: attributes.email,
                },
                {
                    Name: 'phone_number',
                    Value: `+55${attributes.telefone}`,
                },
                {
                    Name: 'name',
                    Value: attributes.nome,
                },
                {
                    Name: 'birthdate',
                    Value: attributes.dataNascimento,
                },
            ],
        };

        const signUp = new Promise((resolve, reject) => {
            this.identityServiceProvider.signUp(params, (err, result) => {
                if (err) {
                    return reject(
                        new AppError(err.message || JSON.stringify(err)),
                    );
                }
                return resolve(result);
            });
        });

        const ans = (await Promise.resolve(signUp)) as SignUpResponse;

        return {
            codeDeliveryDetails: ans.CodeDeliveryDetails,
            username: attributes.email,
        };
    }

    public async verify(data: IVerificaCadastroDTO): Promise<void> {
        const params: ConfirmSignUpRequest = {
            ClientId: process.env.AWS_COGNITO_CLIENT_ID as string,
            ConfirmationCode: data.code,
            Username: data.email,
        };

        const verify = new Promise((resolve, reject) => {
            this.identityServiceProvider.confirmSignUp(
                params,
                (err, result) => {
                    if (err) {
                        return reject(
                            new AppError(err.message || JSON.stringify(err)),
                        );
                    }
                    return resolve(result);
                },
            );
        });

        await Promise.resolve(verify);
    }

    public async resendCode(
        email: string,
    ): Promise<ResendConfirmationCodeResponse> {
        const params: ResendConfirmationCodeRequest = {
            ClientId: process.env.AWS_COGNITO_CLIENT_ID as string,
            Username: email,
        };

        const verify = new Promise((resolve, reject) => {
            this.identityServiceProvider.resendConfirmationCode(
                params,
                (err, result) => {
                    if (err) {
                        return reject(
                            new AppError(err.message || JSON.stringify(err)),
                        );
                    }

                    return resolve(result);
                },
            );
        });

        const ans = (await Promise.resolve(
            verify,
        )) as ResendConfirmationCodeResponse;

        return ans;
    }

    public async changePassword(
        accessToken: string,
        oldPassword: string,
        newPassword: string,
    ): Promise<ChangePasswordResponse> {
        const params: ChangePasswordRequest = {
            PreviousPassword: oldPassword,
            ProposedPassword: newPassword,
            AccessToken: accessToken,
        };

        const changePassword = new Promise((resolve, reject) => {
            this.identityServiceProvider.changePassword(
                params,
                (err, result) => {
                    if (err) {
                        return reject(
                            new AppError(err.message || JSON.stringify(err)),
                        );
                    }

                    return resolve(result);
                },
            );
        });

        const ans = (await Promise.resolve(
            changePassword,
        )) as ChangePasswordResponse;

        return ans;
    }

    public async forgotPassword(user: string): Promise<ForgotPasswordResponse> {
        const params: ForgotPasswordRequest = {
            ClientId: process.env.AWS_COGNITO_CLIENT_ID as string,
            Username: user,
        };

        const changePassword = new Promise((resolve, reject) => {
            this.identityServiceProvider.forgotPassword(
                params,
                (err, result) => {
                    if (err) {
                        return reject(
                            new AppError(err.message || JSON.stringify(err)),
                        );
                    }

                    return resolve(result);
                },
            );
        });

        const ans = (await Promise.resolve(
            changePassword,
        )) as ForgotPasswordResponse;

        return ans;
    }

    public async confirmForgotPassword(
        user: string,
        password: string,
        code: string,
    ): Promise<ConfirmForgotPasswordResponse> {
        const params: ConfirmForgotPasswordRequest = {
            ClientId: process.env.AWS_COGNITO_CLIENT_ID as string,
            Username: user,
            Password: password,
            ConfirmationCode: code,
        };

        const changePassword = new Promise((resolve, reject) => {
            this.identityServiceProvider.confirmForgotPassword(
                params,
                (err, result) => {
                    if (err) {
                        return reject(
                            new AppError(err.message || JSON.stringify(err)),
                        );
                    }

                    return resolve(result);
                },
            );
        });

        const ans = (await Promise.resolve(
            changePassword,
        )) as ConfirmForgotPasswordResponse;

        return ans;
    }
}
