import 'package:irep/enums/contact_type_enum.dart';
import 'package:irep/models/contact_model.dart';

class ResidenceModelEndereco {
  String? estado;
  String? cidade;
  int? numero;
  String? bairro;
  String? uuid;
  String? rua;
  String? cep;

  ResidenceModelEndereco({
    this.estado,
    this.cidade,
    this.numero,
    this.bairro,
    this.uuid,
    this.rua,
    this.cep,
  });
  ResidenceModelEndereco.fromJson(Map<String, dynamic> json) {
    estado = json['estado']?.toString();
    cidade = json['cidade']?.toString();
    numero = json['numero']?.toInt();
    bairro = json['bairro']?.toString();
    uuid = json['uuid']?.toString();
    rua = json['rua']?.toString();
    cep = json['cep']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['estado'] = estado;
    data['cidade'] = cidade;
    data['numero'] = numero;
    data['bairro'] = bairro;
    data['uuid'] = uuid;
    data['rua'] = rua;
    data['cep'] = cep;
    return data;
  }
}

class ResidenceModel {
  int? quartos;
  int? estacionamento;
  int? banheiros;
  bool? gas;
  String? nome;
  String? photo;
  String? uuid;
  bool? internet;
  bool? isFavorite;
  ResidenceModelEndereco? endereco;
  List<ContactModel>? contatos;

  ResidenceModel({
    this.quartos,
    this.estacionamento,
    this.banheiros,
    this.gas,
    this.nome,
    this.photo,
    this.uuid,
    this.internet,
    this.isFavorite = false,
    this.endereco,
    this.contatos,
  });
  factory ResidenceModel.fromJson(Map<String, dynamic> json) {
    List<ContactModel>? contatos;

    if (json['contato'] != null) {
      contatos = [];
      contatos.addAll([
        ContactModel(
            info: json['contato']['telefone'], type: ContactTypeEnum.PHONE),
        ContactModel(
            info: json['contato']['email'], type: ContactTypeEnum.EMAIL),
      ]);
    } else {
      contatos = null;
    }

    return ResidenceModel(
      quartos: json['quartos']?.toInt(),
      estacionamento: json['estacionamento']?.toInt(),
      banheiros: json['banheiros']?.toInt(),
      gas: json['gas'],
      nome: json['nome']?.toString(),
      photo: json['photo']?.toString(),
      uuid: json['uuid']?.toString(),
      internet: json['internet'],
      isFavorite: json['isFavorite'] ?? false,
      endereco: (json['endereco'] != null)
          ? ResidenceModelEndereco.fromJson(json['endereco'])
          : null,
      contatos: contatos,
    );
  }
  // Map<String, dynamic> toJson() {
  //   final data = <String, dynamic>{};
  //   data['quartos'] = quartos;
  //   data['estacionamento'] = estacionamento;
  //   data['banheiros'] = banheiros;
  //   data['gas'] = gas;
  //   data['nome'] = nome;
  //   data['photo'] = photo;
  //   data['uuid'] = uuid;
  //   data['internet'] = internet;
  //   data['isFavorite'] = isFavorite;
  //   if (endereco != null) {
  //     data['endereco'] = endereco!.toJson();
  //   }
  //   if (contato != null) {
  //     data['contato'] = contato!.toJson();
  //   }
  //   return data;
  // }
}
