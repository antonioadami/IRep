import 'package:equatable/equatable.dart';
import 'package:irep/enums/contact_type_enum.dart';
import 'package:irep/models/contact_model.dart';

class ResidenceModelEndereco extends Equatable {
  final String? estado;
  final String? cidade;
  final int? numero;
  final String? bairro;
  final String? uuid;
  final String? rua;
  final String? cep;

  const ResidenceModelEndereco({
    this.estado,
    this.cidade,
    this.numero,
    this.bairro,
    this.uuid,
    this.rua,
    this.cep,
  });
  factory ResidenceModelEndereco.fromJson(Map<String, dynamic> json) {
    return ResidenceModelEndereco(
      estado: json['estado']?.toString(),
      cidade: json['cidade']?.toString(),
      numero: json['numero']?.toInt(),
      bairro: json['bairro']?.toString(),
      uuid: json['uuid']?.toString(),
      rua: json['rua']?.toString(),
      cep: json['cep']?.toString(),
    );
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

  @override
  List<Object?> get props => [
        estado,
        cidade,
        numero,
        bairro,
        uuid,
        rua,
        cep,
      ];
}

class ResidenceModel extends Equatable {
  final int? quartos;
  final int? estacionamento;
  final int? banheiros;
  final bool? gas;
  final String? nome;
  final String? photo;
  final String? uuid;
  final bool? internet;
  final ResidenceModelEndereco? endereco;
  final List<ContactModel>? contatos;

  const ResidenceModel({
    this.quartos,
    this.estacionamento,
    this.banheiros,
    this.gas,
    this.nome,
    this.photo,
    this.uuid,
    this.internet,
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

  @override
  List<Object?> get props => [
        quartos,
        estacionamento,
        banheiros,
        gas,
        nome,
        photo,
        uuid,
        internet,
        endereco,
        contatos,
      ];
}
