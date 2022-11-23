// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldPattern extends StatelessWidget {
  String label;
  String? initialValue;
  Function(String?)? onSaved;
  String? Function(String?)? validator;
  List<TextInputFormatter>? inputFormatters;
  TextInputType? keyboardType;
  int? maxLines;
  TextEditingController? controller;
  bool? obscureText;
  double? width;

  TextFieldPattern({
    required this.label,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
    this.maxLines,
    this.initialValue,
    this.controller,
    this.obscureText,
    this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextFormField(
          initialValue: initialValue,
          controller: controller,
          decoration: InputDecoration(
            focusColor: Colors.grey,
            labelText: label,
            labelStyle: const TextStyle(
              color: Colors.grey,
            ),
            fillColor: Colors.grey.shade200,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: .5,
              ),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: .5,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
          ),
          maxLines: maxLines ?? 1,
          inputFormatters: inputFormatters ?? [],
          keyboardType: keyboardType ?? TextInputType.text,
          validator: validator,
          onSaved: onSaved ?? (_) {},
          obscureText: obscureText ?? false,
        ),
      ),
    );
  }
}
