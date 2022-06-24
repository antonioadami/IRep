import 'package:flutter/material.dart';
import 'package:irep/helpers/color_helpers.dart';
import 'package:irep/pages/login/login_page.dart';
import 'package:irep/routes/name_routes.dart';
import 'package:irep/routes/routes.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: splashScreen,
    );
  }
}

class SplashScreenWidget extends StatelessWidget {
  const SplashScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: LoginPage(),
      duration: 3000,
      imageSize: 500,
      imageSrc: "assets/images/irep_logo.png",
      speed: 2,
      backgroundColor: Color(primaryColorRed),
    );
  }
}
