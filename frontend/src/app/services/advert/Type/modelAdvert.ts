export interface ModelAdvert {
  nome: string;
  quartos: number;
  banheiros: number;
  estacionamento: number;
  internet: boolean;
  gas: boolean;
  endereco?: ModelAddress;
  uuid?: string;
  contato?: ModelContact;
}

export interface ModelAddress {
  estado: string;
  cidade: string;
  bairro: string;
  rua: string;
  numero: number;
  cep: string;
}

export interface ModelContact {
  email: string;
  telefone: string;
}
