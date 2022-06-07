import 'package:flutter/material.dart';
import 'package:irep/helpers/constants_helpers.dart';
import 'package:irep/helpers/widget_helpers.dart';
import 'package:irep/viewmodels/residence_view_model.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    ResidenceViewModel viewmodel = context.watch<ResidenceViewModel>();

    return Padding(
      padding: defaultPadding,
      child: Column(
        children: [
          AppBarWidget(),
          const SizedBox(height: 50),
          Row(
            children: const [
              Text(
                'Moradias',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )
            ],
          ),
          ...viewmodel.residences.map((e) {
            return ResidenceWidget(residence: e);
          }).toList()
        ],
      ),
    );
  }
}
