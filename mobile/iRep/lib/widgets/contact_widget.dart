import 'package:flutter/material.dart';
import 'package:irep/enums/contact_type_enum.dart';
import 'package:irep/helpers/color_helpers.dart';
import 'package:irep/models/contact_model.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({required this.contact, Key? key}) : super(key: key);
  final ContactModel contact;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Icon(
                contact.type!.icon,
                color: Color(primaryColorRed),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(left: 35),
              child: Text(
                contact.info!,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
