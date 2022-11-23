import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:irep/enums/contact_type_enum.dart';

class ContactModel extends Equatable {
  final String? info;
  final ContactTypeEnum? type;

  const ContactModel({this.info, this.type});

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

  @override
  List<Object?> get props => [
        info,
        type,
      ];
}
