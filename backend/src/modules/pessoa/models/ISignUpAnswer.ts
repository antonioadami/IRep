import { CodeDeliveryDetails } from 'amazon-cognito-identity-js';

export default interface ISignUpAnswer {
    codeDeliveryDetails: CodeDeliveryDetails;
    username: string;
}
