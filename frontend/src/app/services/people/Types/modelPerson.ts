export interface ModelPerson {
    cpf: string,
    email: string,
    nome: string,
    dataNascimento: string,
    senha: string,
    telefone: string,
}

export interface ModelPersonReturn {
  cpf: string,
  email: string,
  nome: string,
  dataNascimento: string,
  uuid: string,
  telefone: string,
}

export interface ModelRegister {
  username: string;
  codeDeliveryDetails: ModelCodeDelivery;
}

export interface ModelCodeDelivery
{
  Destination: string;
  AttributeName: string;
  DeliveryMedium: string;
}
