import 'package:flutter/material.dart';
import 'package:irep/enums/contact_type_enum.dart';
import 'package:irep/helpers/color_helpers.dart';
import 'package:irep/helpers/constants_helpers.dart';
import 'package:irep/helpers/widget_helpers.dart';
import 'package:irep/models/residence_model.dart';

class ResidenceDetails extends StatelessWidget {
  const ResidenceDetails({Key? key}) : super(key: key);

  String _addressString(ResidenceModel residence) {
    ResidenceModelEndereco endereco = residence.endereco!;

    return '${endereco.rua}, '
        '${endereco.numero}, '
        '${endereco.bairro}, '
        '${endereco.cidade} - '
        '${endereco.cep} - '
        '${endereco.estado}';
  }

  @override
  Widget build(BuildContext context) {
    final residence =
        ModalRoute.of(context)!.settings.arguments as ResidenceModel;
    return Scaffold(
        body: Padding(
      padding: defaultPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarWidget(
            showBackButton: true,
          ),
          const SizedBox(height: 20),
          Text(
            residence.nome!,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: residence.photo != null
                    ? DecorationImage(
                        image: AssetImage(residence.photo!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: residence.photo == null
                  ? Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(primaryColorRed),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 80,
                      ),
                    )
                  : null,
            ),
          ),
          Text(
            _addressString(residence),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          BuildInformation(residence: residence),
          const SizedBox(height: 20),
          const Text(
            'Contatos',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          ...residence.contatos!
              .map(
                (contact) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: LineInformation(
                    information: contact.info!,
                    icon: contact.type!.icon!,
                  ),
                ),
              )
              .toList(),
        ],
      ),
    ));
  }
}
