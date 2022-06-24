import 'package:flutter/material.dart';
import 'package:irep/helpers/color_helpers.dart';

class AvatarDefault extends StatelessWidget {
  String? photo;
  bool isProfilePage;
  String name;
  AvatarDefault({
    required this.photo,
    required this.name,
    this.isProfilePage = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return photo != null
        ? Container(
            padding: const EdgeInsets.all(50),
            height: 250,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                image: AssetImage(photo!),
                fit: BoxFit.cover,
              ),
            ),
            child: null,
          )
        : Container(
            height: 250,
            width: 250,
            child: Center(
              child: Text(
                name[0],
                style: TextStyle(
                  color: isProfilePage ? Color(primaryColorRed) : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: isProfilePage ? 200 : 25,
                ),
              ),
            ),
          );
  }
}
