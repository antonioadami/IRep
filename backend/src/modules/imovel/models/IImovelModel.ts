import IEnderecoModel from './IEnderecoModel';

export default interface IImovelModel {
    uuid: string;
    nome: string;
    quartos: number;
    banheiros: number;
    estacionamento: number;
    gas: boolean;
    internet: boolean;
    endereco: IEnderecoModel;
    contato: { email: string; telefone: string };
}
