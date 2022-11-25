import 'package:flutter/widgets.dart';

class NavigateViewModel extends ChangeNotifier {
  int selectedIndex = 0;
  void changeSelectedIndex(int newIndex) {
    selectedIndex = newIndex;
    notifyListeners();
  }
}
