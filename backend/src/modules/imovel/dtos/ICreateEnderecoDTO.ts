export default interface ICreateEnderecoDTO {
    uuid?: string;
    uuidImovel: string;
    estado: string;
    cidade: string;
    bairro: string;
    rua: string;
    cep: string;
    numero: number;
}
