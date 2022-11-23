import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:irep/helpers/constants_helpers.dart';
import 'package:irep/helpers/functions_helpers.dart';
import 'package:irep/helpers/widget_helpers.dart';
import 'package:irep/routes/name_routes.dart';
import 'package:irep/viewmodels/login_view_model.dart';
import 'package:irep/widgets/button_pattern.dart';
import 'package:irep/widgets/text_button_pattern.dart';
import 'package:irep/widgets/text_field_pattern.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController controllerEmail =
      TextEditingController(text: 'gustavo.simoes@btgpactual.com');

  TextEditingController controllerSenha =
      TextEditingController(text: 'Zoio0811*');

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel = context.read<LoginViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: defaultPadding,
          child: Column(
            children: [
              AppBarWidget(),
              const Spacer(),
              TextFieldPattern(
                label: 'Email',
                onSaved: (text) {},
                controller: controllerEmail,
                validator: (text) {
                  if (text!.isEmpty) {
                    return 'O email deve ser preenchido';
                  }
                  if (!EmailValidator.validate(text)) {
                    return 'Insira um e-mail válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFieldPattern(
                label: 'Senha',
                onSaved: (text) {},
                obscureText: true,
                controller: controllerSenha,
              ),
              const Spacer(),
              ButtonPattern(
                  label: isLoading
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : 'Entrar',
                  onTap: () async {
                    if (!isLoading && _formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      _formKey.currentState!.save();
                      var result = await loginViewModel.handleLogin(
                        email: controllerEmail.text,
                        senha: controllerSenha.text,
                      );

                      result.fold((error) {
                        errorSnackbar(context, message: error.message);
                      }, (success) async {
                        await loginViewModel.getUserInformation();
                        if (loginViewModel.user != null) {
                          Navigator.pushNamed(
                            context,
                            home,
                          );
                        } else {
                          errorSnackbar(
                            context,
                            message: 'Erro ao buscar os dados do usuário',
                          );
                        }
                      });
                    }
                    setState(() {
                      isLoading = false;
                    });
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
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
