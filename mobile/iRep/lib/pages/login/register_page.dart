import 'package:brasil_fields/brasil_fields.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:irep/helpers/constants_helpers.dart';
import 'package:irep/helpers/functions_helpers.dart';
import 'package:irep/helpers/widget_helpers.dart';
import 'package:irep/routes/name_routes.dart';
import 'package:irep/viewmodels/login_view_model.dart';
import 'package:irep/widgets/button_pattern.dart';
import 'package:irep/widgets/text_field_pattern.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController controllerNome = TextEditingController(text: 'Gustavo');

  TextEditingController controllerCpf =
      TextEditingController(text: '005.237.110-77');

  TextEditingController controllerData =
      TextEditingController(text: '16/09/1999');

  TextEditingController controllerEmail =
      TextEditingController(text: 'kbaasajhv@g.cvom');

  TextEditingController controllerSenha =
      TextEditingController(text: 'Maria1622*');

  TextEditingController controllerRepetirSenha =
      TextEditingController(text: 'Maria1622*');

  TextEditingController controllerTelefone =
      TextEditingController(text: '(37) 99983-4175');

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

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
            spacingStack8,
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFieldPattern(
                        label: 'Nome',
                        controller: controllerNome,
                      ),
                      TextFieldPattern(
                        label: 'CPF',
                        controller: controllerCpf,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CpfInputFormatter(),
                        ],
                        validator: (text) {
                          if (text!.isEmpty) {
                            return 'o CPF deve ser preenchido.';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                      ),
                      TextFieldPattern(
                        label: 'Data de Nascimento',
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
                            if (date.year != year ||
                                date.month != month ||
                                date.day != date.day) {
                              return 'Data Inválida';
                            }
                            return null;
                          } catch (_) {
                            return 'Data Inválida';
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          DataInputFormatter(),
                        ],
                        keyboardType: TextInputType.number,
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
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFieldPattern(
                        label: 'Telefone',
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],
                        controller: controllerTelefone,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return 'O telefone deve ser preenchido';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                      ),
                      TextFieldPattern(
                        label: 'Senha',
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
                      spacingStack8,
                      ButtonPattern(
                          label: isLoading
                              ? const SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : 'Cadastrar-se',
                          onTap: () async {
                            if (!isLoading &&
                                _formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              _formKey.currentState!.save();
                              var result = await loginViewModel.createUser(
                                cpf: controllerCpf.text,
                                email: controllerEmail.text,
                                nome: controllerNome.text,
                                senha: controllerSenha.text,
                                telefone: controllerTelefone.text,
                                dataNascimento: controllerData.text,
                              );
                              result.fold((error) {
                                errorSnackbar(context, message: error.message!);
                              }, (success) {
                                Navigator.popAndPushNamed(
                                  context,
                                  verifyCode,
                                  arguments: success,
                                );
                              });
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }),
                      spacingStack8,
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
