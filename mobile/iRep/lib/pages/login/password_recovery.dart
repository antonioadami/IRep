import 'package:flutter/material.dart';
import 'package:irep/helpers/color_helpers.dart';
import 'package:irep/helpers/constants_helpers.dart';
import 'package:irep/helpers/widget_helpers.dart';

class PasswordRecovery extends StatelessWidget {
  const PasswordRecovery({Key? key}) : super(key: key);

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
            // const Text(
            //   'Insira o e-mail cadastrado e enviaremos um link para você voltar a acessar a sua conta.',
            //   style: TextStyle(fontSize: 20),
            // ),
            // const SizedBox(height: 16),
            // TextFieldPattern(label: 'Email', onSaved: (text) {}),
            // const Spacer(),
            // ButtonPattern(label: 'Enviar', onTap: () {}),
            // const Spacer(),
            const Text(
              'Redefinir senha',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(
                Icons.construction_outlined,
                size: 150,
                color: Color(primaryColorRed),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Ainda estamos em construção! Em breve esta função estará disponível. '
              'Por favor entre em contato com os administradores para redefinir sua senha.',
              style: TextStyle(fontSize: 20),
            ),
            const Spacer(),
            const Spacer(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
