import 'package:irep/enums/contact_type_enum.dart';
import 'package:irep/models/contact_model.dart';

class UserModel {
  String? cpf;
  String? nome;
  String? dataNascimento;
  String? uuid;
  String? photo;
  List<ContactModel> contacts;
  UserModel({
    this.cpf,
    this.nome,
    this.dataNascimento,
    this.uuid,
    this.photo,
    this.contacts = const [],
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    List<ContactModel> contacts = [];
    contacts.add(ContactModel(
      info: json['telefone']?.toString(),
      type: ContactTypeEnum.PHONE,
    ));
    contacts.add(ContactModel(
      info: json['email']?.toString(),
      type: ContactTypeEnum.EMAIL,
    ));
    return UserModel(
      cpf: json['cpf']?.toString(),
      nome: json['nome']?.toString(),
      photo: json['photo']?.toString(),
      dataNascimento: json['dataNascimento']?.toString(),
      uuid: json['uuid']?.toString(),
      contacts: contacts,
    );
  }
}
