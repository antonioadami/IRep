import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:irep/enums/contact_type_enum.dart';

class ContactModel {
  String? info;
  ContactTypeEnum? type;

  ContactModel({this.info, this.type});

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      info: json['info'],
      type: ContactTypeEnum.values.firstWhereOrNull(
            (contactType) =>
                describeEnum(contactType) == (json['type']).toUpperCase(),
          ) ??
          ContactTypeEnum.OTHER,
    );
  }
}
