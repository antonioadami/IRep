import 'package:flutter/material.dart';
import 'package:irep/pages/splashscreen_page.dart';
import 'package:irep/viewmodels/login_view_model.dart';
import 'package:irep/viewmodels/residence_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ResidenceViewModel()),
        ChangeNotifierProvider(create: (context) => LoginViewModel())
      ],
      child: const SplashScreenPage(),
    ),
  );
}
