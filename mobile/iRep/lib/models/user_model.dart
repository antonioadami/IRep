import 'package:irep/models/contact_model.dart';

class UserModel {
  final String? name;
  final List<ContactModel>? contacts;
  final String? photo;
  const UserModel({
    this.name,
    this.contacts,
    this.photo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    List<ContactModel> _contacts = [];
    if (json['contacts'] != null) {
      json['contacts']
          .map((contactJson) =>
              _contacts.add(ContactModel.fromJson(contactJson)))
          .toList();
    }

    return UserModel(
      name: json['name']?.toString(),
      contacts: _contacts,
      photo: json['photo']?.toString(),
    );
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = contacts;
    data['photo'] = photo;
    return data;
  }
}
