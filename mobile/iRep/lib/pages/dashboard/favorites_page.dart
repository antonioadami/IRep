import 'package:flutter/material.dart';
import 'package:irep/helpers/constants_helpers.dart';
import 'package:irep/helpers/widget_helpers.dart';
import 'package:irep/viewmodels/residence_view_model.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    ResidenceViewModel viewmodel = context.watch<ResidenceViewModel>();

    return Padding(
      padding: defaultPadding,
      child: SizedBox(
        child: Column(
          children: [
            AppBarWidget(),
            const SizedBox(height: 40),
            Row(
              children: const [
                Text(
                  'Favoritos',
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
                    ...viewmodel.residences.map((residence) {
                      if (residence.isFavorite!) {
                        return ResidenceWidget(residence: residence);
                      }
                      return Container();
                    }).toList(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
