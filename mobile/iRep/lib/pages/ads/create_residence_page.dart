import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:irep/helpers/color_helpers.dart';
import 'package:irep/helpers/constants_helpers.dart';
import 'package:irep/helpers/functions_helpers.dart';
import 'package:irep/helpers/widget_helpers.dart';
import 'package:irep/viewmodels/navigate_view_model.dart';
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
  TextEditingController controllerNome =
      TextEditingController(text: 'Republica Novo Mundo');
  TextEditingController controllerCidade =
      TextEditingController(text: 'Santa Rita do Sapucaí');
  TextEditingController controllerCep =
      TextEditingController(text: '37.540-000');
  TextEditingController controllerBairro =
      TextEditingController(text: 'Bairro Monte Verde');
  TextEditingController controllerRua =
      TextEditingController(text: 'Rua Manuel Patta');
  TextEditingController controllerNumero = TextEditingController(text: '484');
  TextEditingController controllerEstado = TextEditingController(text: 'MG');
  TextEditingController controllerQuartos = TextEditingController(text: '4');
  TextEditingController controllerBanheiros = TextEditingController(text: '2');
  TextEditingController controllerEstacionamento =
      TextEditingController(text: '2');
  bool temGas = false;
  bool temInternet = true;

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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CepInputFormatter(),
                        ],
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
                        onTap: () async {
                          if (!isLoading && _formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            _formKey.currentState!.save();

                            var result = await viewmodel.createResidence(
                              nome: controllerNome.text,
                              cidade: controllerCidade.text,
                              cep: controllerCep.text,
                              bairro: controllerBairro.text,
                              rua: controllerRua.text,
                              numero: int.parse(controllerNumero.text),
                              estado: controllerEstado.text,
                              quartos: int.parse(controllerQuartos.text),
                              banheiros: int.parse(controllerBanheiros.text),
                              estacionamentos:
                                  int.parse(controllerEstacionamento.text),
                              gas: temGas,
                              internet: temInternet,
                            );

                            result.fold(
                              (left) => errorSnackbar(
                                context,
                                message: left.message ?? '',
                              ),
                              (right) async {
                                await viewmodel.getResidences();
                                context
                                    .read<NavigateViewModel>()
                                    .changeSelectedIndex(0);
                              },
                            );

                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
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
