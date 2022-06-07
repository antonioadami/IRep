import 'package:flutter/material.dart';
import 'package:irep/helpers/constants_helpers.dart';
import 'package:irep/helpers/widget_helpers.dart';
import 'package:irep/models/residence_model.dart';

class ResidenceDetails extends StatelessWidget {
  const ResidenceDetails({Key? key}) : super(key: key);

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
            residence.name!,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(residence.image!),
                  fit: BoxFit.cover,
                ),
              ),
              child: null,
            ),
          ),
          Text(
            residence.address!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...residence.description!
              .split(',')
              .map((e) => Text('- $e', style: const TextStyle(fontSize: 16)))
              .toList(),
          const SizedBox(height: 10),
          const Text(
            'Contatos',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...residence.contacts!
              .map((e) => Text('- $e', style: const TextStyle(fontSize: 16)))
              .toList()
        ],
      ),
    ));
  }
}
