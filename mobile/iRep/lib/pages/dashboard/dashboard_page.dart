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
          const SizedBox(height: 40),
          Row(
            children: const [
              Text(
                'Residências',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: MediaQuery.of(context).size.height - 236,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (viewmodel.residences.isEmpty)
                    Card(
                      child: Container(
                        width: double.infinity,
                        height: 75,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Icon(Icons.block),
                            Text(
                              'Não há anúncios para exibir',
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    )
                  else
                    ...viewmodel.residences.map((e) {
                      return ResidenceWidget(residence: e);
                    }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
