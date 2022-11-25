import 'package:flutter/material.dart';
import 'package:irep/viewmodels/navigate_view_model.dart';
import 'package:irep/pages/splashscreen_page.dart';
import 'package:irep/service/residence_service.dart';
import 'package:irep/viewmodels/login_view_model.dart';
import 'package:irep/viewmodels/residence_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ResidenceViewModel(
            ResidenceService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => NavigateViewModel(),
        ),
      ],
      child: const SplashScreenPage(),
    ),
  );
}
