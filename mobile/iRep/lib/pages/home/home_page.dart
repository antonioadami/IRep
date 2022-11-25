import 'package:flutter/material.dart';
import 'package:irep/helpers/color_helpers.dart';
import 'package:irep/pages/ads/create_residence_page.dart';
import 'package:irep/pages/dashboard/dashboard_page.dart';
import 'package:irep/pages/perfil/perfil_page.dart';
import 'package:irep/viewmodels/navigate_view_model.dart';
import 'package:irep/viewmodels/residence_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> widgetOptions = const [
    DashboardPage(),
    CreateResidencePage(),
    PerfilPage(),
  ];

  @override
  void initState() {
    super.initState();
    var viewmodel = context.read<ResidenceViewModel>();
    viewmodel.getResidences();
  }

  @override
  Widget build(BuildContext context) {
    NavigateViewModel navigateViewModel = context.watch<NavigateViewModel>();
    int _selectedIndex = navigateViewModel.selectedIndex;
    return Scaffold(
      body: Column(children: [
        widgetOptions.elementAt(_selectedIndex),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
              color: Color(primaryColorRed),
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 1 ? Icons.work : Icons.work_outline,
              color: Color(primaryColorRed),
            ),
            label: 'Criar anúncio',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 2
                  ? Icons.account_box
                  : Icons.account_box_outlined,
              color: Color(primaryColorRed),
            ),
            label: 'Conta',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(primaryColorRed),
        onTap: navigateViewModel.changeSelectedIndex,
      ),
    );
  }
}
