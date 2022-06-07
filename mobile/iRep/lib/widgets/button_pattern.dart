import 'package:flutter/material.dart';
import 'package:irep/helpers/color_helpers.dart';

class ButtonPattern extends StatelessWidget {
  String label;
  void Function()? onTap;

  ButtonPattern({
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
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        decoration: BoxDecoration(
            color: Color(primaryColorRed),
            borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}
