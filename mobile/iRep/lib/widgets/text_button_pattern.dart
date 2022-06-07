import 'package:flutter/material.dart';
import 'package:irep/helpers/color_helpers.dart';

class TextButtonPattern extends StatelessWidget {
  String label;
  void Function()? onTap;
  Color? color;

  TextButtonPattern({
    required this.label,
    required this.onTap,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: color ?? Color(primaryColorRed),
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
