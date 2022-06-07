// ignore_for_file: constant_identifier_names

import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum ContactTypeEnum {
  EMAIL,
  PHONE,
  OTHER,
}

extension ContactTypeEnumExtension on ContactTypeEnum {
  IconData? get icon {
    switch (this) {
      case ContactTypeEnum.EMAIL:
        return Icons.email;
      case ContactTypeEnum.PHONE:
        return Icons.phone;
      default:
        return null;
    }
  }
}

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
