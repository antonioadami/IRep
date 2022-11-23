import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:irep/helpers/constants_helpers.dart';
import 'package:irep/helpers/functions_helpers.dart';
import 'package:irep/helpers/widget_helpers.dart';
import 'package:irep/models/create_user_response.dart';
import 'package:irep/viewmodels/login_view_model.dart';
import 'package:irep/widgets/button_pattern.dart';
import 'package:irep/widgets/text_button_pattern.dart';
import 'package:irep/widgets/text_field_pattern.dart';
import 'package:provider/provider.dart';

class VerifyCodePage extends StatefulWidget {
  const VerifyCodePage({Key? key}) : super(key: key);

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  TextEditingController controller = TextEditingController();

  late CreatePersonResponseCodeDeliveryDetails codeDeliveryDetails;
  late String username;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    var response =
        ModalRoute.of(context)?.settings.arguments as CreatePersonResponse;

    codeDeliveryDetails = response.codeDeliveryDetails!;
    username = response.username!;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showSnackBar();
    });
  }

  void _showSnackBar() {
    successSnackbar(
      context,
      message: 'Código enviado para ${codeDeliveryDetails.destination!}',
    );
  }

  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel = context.read<LoginViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: defaultPadding,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppBarWidget(showBackButton: true),
              spacingStack32,
              const Text(
                "Insira o código abaixo.",
                style: TextStyle(fontSize: 20),
              ),
              spacingStack32,
              TextFieldPattern(
                label: 'Código',
                controller: controller,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (text) {
                  if (text!.isEmpty) {
                    return 'O código deve ser preenchido';
                  }
                  if (text.length != 6) {
                    return 'O código deve ter 6 caracteres.';
                  }
                  return null;
                },
              ),
              spacingStack32,
              ButtonPattern(
                label: isLoading
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : 'Verificar',
                onTap: () async {
                  if (!isLoading && _formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    _formKey.currentState!.save();
                    var result = await loginViewModel.verifyUser(
                      email: username,
                      code: controller.text,
                    );
                    result.fold((error) {
                      errorSnackbar(context, message: error.message!);
                    }, (success) {
                      successSnackbar(context, message: success.message!);
                      Navigator.of(context).pop();
                    });
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
              ),
              spacingStack16,
              TextButtonPattern(
                  label: 'Reenviar código',
                  onTap: () async {
                    var result = await loginViewModel.resendCode(
                      email: username,
                    );

                    result.fold((failure) {
                      errorSnackbar(
                        context,
                        message: failure.message!,
                      );
                    }, (success) {
                      codeDeliveryDetails = success.codeDeliveryDetails!;
                      _showSnackBar();
                      setState(() {});
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
