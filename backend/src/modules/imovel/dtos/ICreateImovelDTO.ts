import ICreateEnderecoDTO from './ICreateEnderecoDTO';

export default interface ICreateImovelDTO {
    uuid?: string;
    userEmail: string;
    nome: string;
    quartos: number;
    banheiros: number;
    estacionamento: number;
    gas: boolean;
    internet: boolean;
    endereco: ICreateEnderecoDTO;
    images: string[];
}
