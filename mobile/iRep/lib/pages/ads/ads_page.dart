import 'package:flutter/material.dart';
import 'package:irep/helpers/constants_helpers.dart';
import 'package:irep/helpers/widget_helpers.dart';
import 'package:irep/viewmodels/residence_view_model.dart';
import 'package:provider/provider.dart';

class AdsPage extends StatefulWidget {
  const AdsPage({Key? key}) : super(key: key);

  @override
  State<AdsPage> createState() => _AdsPageState();
}

class _AdsPageState extends State<AdsPage> {
  @override
  Widget build(BuildContext context) {
    ResidenceViewModel viewmodel = context.watch<ResidenceViewModel>();

    return Padding(
      padding: defaultPadding,
      child: SizedBox(
        child: Column(
          children: [
            AppBarWidget(),
            const SizedBox(height: 50),
            Row(
              children: const [
                Text(
                  'Meus Anúncios',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )
              ],
            ),
            ...viewmodel.userAdsResidences.map((e) {
              return ResidenceWidget(residence: e);
            }).toList()
          ],
        ),
      ),
    );
  }
}
