import 'package:flutter/material.dart';
import 'package:irep/helpers/color_helpers.dart';
import 'package:irep/models/residence_model.dart';
import 'package:irep/routes/name_routes.dart';
import 'package:irep/viewmodels/login_view_model.dart';
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
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, residenceDetails,
            arguments: widget.residence);
      },
      child: Card(
        child: SizedBox(
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage(widget.residence.image!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: null,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      widget.residence.name!,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.residence.address!,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    )
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
