import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:irep/helpers/color_helpers.dart';
import 'package:irep/helpers/functions_helpers.dart';
import 'package:irep/models/error_model.dart';
import 'package:irep/models/residence_model.dart';
import 'package:irep/models/succes_model.dart';
import 'package:irep/routes/name_routes.dart';
import 'package:irep/viewmodels/login_view_model.dart';
import 'package:irep/viewmodels/residence_view_model.dart';
import 'package:irep/widgets/avatar_default.dart';
import 'package:irep/widgets/text_button_pattern.dart';
import 'package:provider/src/provider.dart';

class AppBarWidget extends StatelessWidget {
  bool showBackButton;
  bool isPerfilPage;
  AppBarWidget({
    this.showBackButton = false,
    this.isPerfilPage = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginViewModel viewModel = context.watch<LoginViewModel>();
    return Center(
      child: Row(
        children: [
          SizedBox(
            height: 42,
            width: 42,
            child: showBackButton
                ? IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  )
                : Container(),
          ),
          const Spacer(),
          Image.asset(
            "assets/images/irep_logo.png",
            color: isPerfilPage ? Colors.white : null,
          ),
          const Spacer(),
          SizedBox(
            height: 42,
            width: 42,
            child: viewModel.user != null && !isPerfilPage
                ? Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(primaryColorRed)),
                    child: AvatarDefault(
                      photo: viewModel.user!.photo,
                      name: viewModel.user!.nome!,
                    ),
                  )
                : isPerfilPage
                    ? TextButtonPattern(
                        label: 'Sair',
                        color: Colors.white,
                        onTap: () async {
                          viewModel.logOut();
                          Navigator.pop(context);
                        },
                      )
                    : Container(),
          ),
        ],
      ),
    );
  }
}

class ResidenceWidget extends StatefulWidget {
  ResidenceWidget({
    required this.residence,
    Key? key,
  }) : super(key: key);
  ResidenceModel residence;

  @override
  State<ResidenceWidget> createState() => _ResidenceWidgetState();
}

class _ResidenceWidgetState extends State<ResidenceWidget> {
  @override
  Widget build(BuildContext context) {
    ResidenceViewModel viewModel = context.watch<ResidenceViewModel>();

    return InkWell(
      onTap: () async {
        if (widget.residence.uuid == null) {
          errorSnackbar(
            context,
            ErrorModel(
              message: 'Não foi possível buscar os dados da residência.',
            ),
          );
        } else {
          successSnackbar(
            context,
            SuccessModel(
              message: 'Carregando os dados da residencia.',
            ),
          );
          var result = await viewModel.getResidenceInformation(
            widget.residence.uuid!,
          );

          result.fold((left) {
            errorSnackbar(
              context,
              ErrorModel(
                message: 'Não foi possível buscar os dados da residência.',
              ),
            );
          }, (right) {
            Navigator.pushNamed(
              context,
              residenceDetails,
              arguments: ResidenceModel.fromJson(jsonDecode(right.response)),
            );
          });
        }
      },
      child: Card(
        child: SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(primaryColorRed),
                      image: widget.residence.photo != null
                          ? DecorationImage(
                              image: AssetImage(widget.residence.photo!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: widget.residence.photo == null
                        ? const Icon(
                            Icons.home,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.residence.nome!,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    BuildInformation(residence: widget.residence)
                  ],
                ),
              ),
              if (widget.residence.isFavorite != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        widget.residence.isFavorite =
                            !widget.residence.isFavorite!;
                      });
                    },
                    child: Icon(
                      widget.residence.isFavorite!
                          ? Icons.star
                          : Icons.star_border_outlined,
                      color: Color(primaryColorRed),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildInformation extends StatelessWidget {
  BuildInformation({
    required this.residence,
    Key? key,
  }) : super(key: key);
  ResidenceModel residence;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (residence.quartos != null)
          LineInformation(
              information: '${residence.quartos!.toString()} quartos'),
        if (residence.banheiros != null)
          LineInformation(
              information: '${residence.banheiros!.toString()} banheiros'),
        if (residence.estacionamento != null)
          LineInformation(
              information:
                  '${residence.estacionamento!.toString()} vaga(s) na garagem'),
        if (residence.internet != null && residence.internet!)
          LineInformation(information: 'Internet'),
        if (residence.gas != null && residence.gas!)
          LineInformation(information: 'Gás'),
      ],
    );
  }
}

class LineInformation extends StatelessWidget {
  IconData? icon;
  String information;
  LineInformation({
    required this.information,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon ?? Icons.done,
          size: 16,
        ),
        const SizedBox(width: 10),
        Text(information),
      ],
    );
  }
}
