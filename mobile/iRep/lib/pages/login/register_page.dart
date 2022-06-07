import 'package:flutter/material.dart';
import 'package:irep/helpers/constants_helpers.dart';
import 'package:irep/helpers/widget_helpers.dart';
import 'package:irep/widgets/button_pattern.dart';
import 'package:irep/widgets/text_field_pattern.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: defaultPadding,
        child: Column(
          children: [
            AppBarWidget(showBackButton: true),
            const Spacer(),
            TextFieldPattern(label: 'Nome', onSaved: (text) {}),
            const SizedBox(height: 16),
            TextFieldPattern(label: 'CPF', onSaved: (text) {}),
            const SizedBox(height: 16),
            TextFieldPattern(label: 'Email', onSaved: (text) {}),
            const SizedBox(height: 16),
            TextFieldPattern(label: 'Senha', onSaved: (text) {}),
            const SizedBox(height: 16),
            TextFieldPattern(label: 'Repetir senha', onSaved: (text) {}),
            const Spacer(),
            ButtonPattern(
                label: 'Cadastrar-se',
                onTap: () {
                  _registerUser();
                }),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  _registerUser() {}
}
