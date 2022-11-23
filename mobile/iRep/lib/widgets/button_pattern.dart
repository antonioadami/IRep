import 'package:flutter/material.dart';
import 'package:irep/helpers/color_helpers.dart';

class ButtonPattern extends StatelessWidget {
final  dynamic label;
final  void Function()? onTap;

  const ButtonPattern({
    required this.label,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 51,
        alignment: Alignment.center,
        child: label is String
            ? Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 16,
                ),
              )
            : label,
        decoration: BoxDecoration(
            color: Color(primaryColorRed),
            borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}
