import 'package:flutter/material.dart';
import 'package:irep/enums/contact_type_enum.dart';
import 'package:irep/helpers/color_helpers.dart';
import 'package:irep/models/contact_model.dart';

class ContactWidget extends StatelessWidget {
  ContactWidget({required this.contact, Key? key}) : super(key: key);
  ContactModel contact;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            alignment: Alignment.centerRight,
            width: 75,
            child: Icon(
              contact.type!.icon,
              color: Color(primaryColorRed),
            ),
          ),
          Expanded(
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
