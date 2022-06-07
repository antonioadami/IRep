import 'package:flutter/material.dart';
import 'package:irep/helpers/constants_helpers.dart';
import 'package:irep/helpers/widget_helpers.dart';
import 'package:irep/routes/name_routes.dart';
import 'package:irep/viewmodels/login_view_model.dart';
import 'package:irep/widgets/button_pattern.dart';
import 'package:irep/widgets/text_button_pattern.dart';
import 'package:irep/widgets/text_field_pattern.dart';
import 'package:provider/src/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: defaultPadding,
        child: Column(
          children: [
            AppBarWidget(),
            const Spacer(),
            TextFieldPattern(label: 'Email', onSaved: (text) {}),
            const SizedBox(height: 16),
            TextFieldPattern(
              label: 'Senha',
              onSaved: (text) {},
              obscureText: true,
            ),
            const Spacer(),
            ButtonPattern(
                label: 'Entrar',
                onTap: () {
                  context.read<LoginViewModel>().getInformation();

                  Navigator.pushNamed(
                    context,
                    home,
                  );
                }),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextButtonPattern(
                      label: 'Cadastrar',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          register,
                        );
                      }),
                ),
                Expanded(
                  child: TextButtonPattern(
                      label: 'Esqueceu sua senha?',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          passwordRecovery,
                        );
                      }),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
