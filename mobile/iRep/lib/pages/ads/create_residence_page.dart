import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:irep/helpers/color_helpers.dart';
import 'package:irep/helpers/constants_helpers.dart';
import 'package:irep/helpers/widget_helpers.dart';
import 'package:irep/viewmodels/residence_view_model.dart';
import 'package:irep/widgets/button_pattern.dart';
import 'package:irep/widgets/text_field_pattern.dart';
import 'package:provider/provider.dart';

class CreateResidencePage extends StatefulWidget {
  const CreateResidencePage({Key? key}) : super(key: key);

  @override
  State<CreateResidencePage> createState() => _CreateResidencePageState();
}

class _CreateResidencePageState extends State<CreateResidencePage> {
  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerCidade = TextEditingController();
  TextEditingController controllerCep = TextEditingController();
  TextEditingController controllerBairro = TextEditingController();
  TextEditingController controllerRua = TextEditingController();
  TextEditingController controllerNumero = TextEditingController();
  TextEditingController controllerEstado = TextEditingController();
  TextEditingController controllerQuartos = TextEditingController();
  TextEditingController controllerBanheiros = TextEditingController();
  TextEditingController controllerEstacionamento = TextEditingController();
  bool temGas = false;
  bool temInternet = false;

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    ResidenceViewModel viewmodel = context.watch<ResidenceViewModel>();

    return Padding(
      padding: defaultPadding,
      child: SizedBox(
        height: 680,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarWidget(),
            spacingStack8,
            const Text(
              'Criar anúncio',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            spacingStack8,
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFieldPattern(
                        label: 'Nome',
                        controller: controllerNome,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return 'Obrigatório';
                          }
                          return null;
                        },
                      ),
                      TextFieldPattern(
                        label: 'CEP',
                        controller: controllerCep,
                        keyboardType: TextInputType.number,
                        inputFormatters: [CepInputFormatter()],
                        validator: (text) {
                          if (text!.isEmpty) {
                            return 'Obrigatório';
                          }
                          return null;
                        },
                      ),
                      TextFieldPattern(
                        label: 'Estado',
                        controller: controllerEstado,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return 'Obrigatório';
                          }
                          return null;
                        },
                      ),
                      TextFieldPattern(
                        label: 'Cidade',
                        controller: controllerCidade,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return 'Obrigatório';
                          }
                          return null;
                        },
                      ),
                      TextFieldPattern(
                        label: 'Bairro',
                        controller: controllerBairro,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return 'Obrigatório';
                          }
                          return null;
                        },
                      ),
                      TextFieldPattern(
                        label: 'Rua',
                        controller: controllerRua,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return 'Obrigatório';
                          }
                          return null;
                        },
                      ),
                      TextFieldPattern(
                        label: 'Número',
                        controller: controllerNumero,
                        keyboardType: TextInputType.number,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return 'Obrigatório';
                          }
                          return null;
                        },
                      ),
                      Row(
                        children: [
                          TextFieldPattern(
                            label: 'Banheiros',
                            width: 100,
                            controller: controllerBanheiros,
                            keyboardType: TextInputType.number,
                            validator: (text) {
                              if (text!.isEmpty) {
                                return 'Obrigatório';
                              }
                              return null;
                            },
                          ),
                          const Spacer(),
                          TextFieldPattern(
                            label: 'Quartos',
                            width: 100,
                            controller: controllerQuartos,
                            keyboardType: TextInputType.number,
                            validator: (text) {
                              if (text!.isEmpty) {
                                return 'Obrigatório';
                              }
                              return null;
                            },
                          ),
                          const Spacer(),
                          TextFieldPattern(
                            label: 'Garagem',
                            width: 100,
                            controller: controllerEstacionamento,
                            keyboardType: TextInputType.number,
                            validator: (text) {
                              if (text!.isEmpty) {
                                return 'Obrigatório';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          const Text('Gás'),
                          const SizedBox(width: 5),
                          Checkbox(
                            value: temGas,
                            onChanged: (_) => setState(() {
                              temGas = !temGas;
                            }),
                            checkColor: Color(primaryColorRed),
                          ),
                          const Spacer(),
                          const Text('Internet'),
                          const SizedBox(width: 5),
                          Checkbox(
                            value: temInternet,
                            onChanged: (_) => setState(() {
                              temInternet = !temInternet;
                            }),
                            fillColor: MaterialStateColor.resolveWith(
                              (states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Color(primaryColorRed);
                                }
                                return Colors.black;
                              },
                            ),
                          ),
                          const Spacer(),
                        ],
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
                            : 'Criar anúncio',
                        onTap: () {},
                      ),
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
