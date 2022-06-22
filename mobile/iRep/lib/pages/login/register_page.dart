import 'package:brasil_fields/brasil_fields.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:irep/helpers/constants_helpers.dart';
import 'package:irep/helpers/functions_helpers.dart';
import 'package:irep/helpers/widget_helpers.dart';
import 'package:irep/viewmodels/login_view_model.dart';
import 'package:irep/widgets/button_pattern.dart';
import 'package:irep/widgets/text_field_pattern.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerCpf = TextEditingController();
  TextEditingController controllerData = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();
  TextEditingController controllerRepetirSenha = TextEditingController();
  TextEditingController controllerTelefone = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel = context.read<LoginViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: defaultPadding,
        child: Column(
          children: [
            AppBarWidget(showBackButton: true),
            defaultSpacingInline,
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFieldPattern(
                        label: 'Nome',
                        onSaved: (text) {},
                        controller: controllerNome,
                      ),
                      TextFieldPattern(
                        label: 'CPF',
                        onSaved: (text) {},
                        controller: controllerCpf,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CpfInputFormatter(),
                        ],
                      ),
                      TextFieldPattern(
                        label: 'Data de Nascimento',
                        onSaved: (text) {},
                        controller: controllerData,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'A data de nascimento deve ser preenchida';
                          }
                          var split = text.split('/');
                          if (split.length != 3) {
                            return 'Data Inválida';
                          }
                          var year = int.parse(split[2]);
                          var month = int.parse(split[1]);
                          var day = int.parse(split[0]);

                          try {
                            DateTime date = DateTime(year, month, day);
                            return null;
                          } catch (_) {
                            return 'Data Inválida';
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          DataInputFormatter(),
                        ],
                      ),
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
                      TextFieldPattern(
                        label: 'Telefone',
                        onSaved: (text) {},
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],
                        controller: controllerTelefone,
                      ),
                      TextFieldPattern(
                        label: 'Senha',
                        onSaved: (text) {},
                        controller: controllerSenha,
                        obscureText: true,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return 'A senha deve ser preenchida';
                          }
                          return null;
                        },
                      ),
                      TextFieldPattern(
                        label: 'Repetir senha',
                        obscureText: true,
                        onSaved: (text) {},
                        controller: controllerRepetirSenha,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return 'A senha deve ser preenchida';
                          }
                          if (text != controllerSenha.text) {
                            return 'As senhas devem ser iguais';
                          }
                          return null;
                        },
                      ),
                      defaultSpacingInline,
                      ButtonPattern(
                          label: 'Cadastrar-se',
                          onTap: () async {
                            if (_formKey.currentState!.validate()) { 
                              _formKey.currentState!.save();
                              var result = await loginViewModel.registerUser(
                                cpf: controllerCpf.text,
                                email: controllerEmail.text,
                                nome: controllerNome.text,
                                senha: controllerSenha.text,
                                telefone: controllerTelefone.text,
                                dataNascimento: controllerData.text,
                              );
                              result.fold((error) {
                                errorSnackbar(context, error);
                              }, (success) {
                                succesSnackbar(context, success);
                                Navigator.pop(context);
                              });
                            }
                          }),
                      defaultSpacingInline,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
