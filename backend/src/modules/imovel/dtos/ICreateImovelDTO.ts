import ICreateEnderecoDTO from './ICreateEnderecoDTO';

export default interface ICreateImovelDTO {
    uuid?: string;
    pessoaUuid: string;
    nome: string;
    quartos: number;
    banheiros: number;
    estacionamento: number;
    gas: boolean;
    internet: boolean;
    endereco: ICreateEnderecoDTO;
}
