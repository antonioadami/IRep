// ignore_for_file: constant_identifier_names

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
