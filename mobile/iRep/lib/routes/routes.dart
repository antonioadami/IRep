import 'package:flutter/material.dart';
import 'package:irep/pages/dashboard/residence_details_page.dart';
import 'package:irep/pages/home/home_page.dart';
import 'package:irep/pages/login/login_page.dart';
import 'package:irep/pages/login/password_recovery.dart';
import 'package:irep/pages/login/register_page.dart';
import 'package:irep/pages/splashscreen_page.dart';
import 'package:irep/routes/name_routes.dart';

Map<String, Widget Function(BuildContext)> routes = {
  splashScreen: (context) => const SplashScreenWidget(),
  login: (context) => const LoginPage(),
  passwordRecovery: (context) => const PasswordRecovery(),
  register: (context) => const RegisterPage(),
  home: (context) => const HomePage(),
  residenceDetails: (context) => const ResidenceDetails(),
};
