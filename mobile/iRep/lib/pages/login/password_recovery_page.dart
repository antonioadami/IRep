import 'package:flutter/material.dart';
import 'package:irep/helpers/constants_helpers.dart';
import 'package:irep/helpers/widget_helpers.dart';
import 'package:irep/widgets/button_pattern.dart';
import 'package:irep/widgets/text_field_pattern.dart';

class PasswordRecovery extends StatelessWidget {
  PasswordRecovery({Key? key}) : super(key: key);
  final TextEditingController controllerEmail = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
            Expanded(
                child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      'Insira o e-mail cadastrado e enviaremos '
                      'um link para você voltar a acessar a sua conta.',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 16),
                    TextFieldPattern(
                      label: 'Email',
                      controller: controllerEmail,
                    ),
                    const Spacer(),
                    ButtonPattern(label: 'Enviar', onTap: () {}),
                    const Spacer(),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
