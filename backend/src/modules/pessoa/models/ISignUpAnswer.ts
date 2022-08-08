import { CodeDeliveryDetailsType } from 'aws-sdk/clients/cognitoidentityserviceprovider';

export default interface ISignUpAnswer {
    codeDeliveryDetails: CodeDeliveryDetailsType | undefined;
    username: string;
}
