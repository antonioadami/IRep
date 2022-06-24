import 'package:flutter/material.dart';
import 'package:irep/helpers/color_helpers.dart';
import 'package:irep/helpers/constants_helpers.dart';
import 'package:irep/helpers/widget_helpers.dart';
import 'package:irep/viewmodels/login_view_model.dart';
import 'package:irep/widgets/avatar_default.dart';
import 'package:irep/widgets/contact_widget.dart';
import 'package:provider/src/provider.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginViewModel viewModel = context.watch<LoginViewModel>();
    return SizedBox(
      child: Stack(
        children: [
          Container(
            height: 300,
            color: Color(primaryColorRed),
          ),
          Padding(
            padding: defaultPadding,
            child: Column(
              children: [
                AppBarWidget(isPerfilPage: true),
                const SizedBox(height: 50),
                Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: AvatarDefault(
                      name: viewModel.user?.nome ?? '',
                      photo: viewModel.user?.photo,
                      isProfilePage: true,
                    )),
                const SizedBox(height: 25),
                Text(
                  viewModel.user?.nome! ?? '',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (viewModel.user != null)
                  ...viewModel.user!.contacts
                      .map((contact) => ContactWidget(contact: contact))
                      .toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
