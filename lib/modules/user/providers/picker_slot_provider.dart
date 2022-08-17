import 'package:flutter/material.dart';

class PickerSlotProvider extends ChangeNotifier {
  int _selectedIndex = 1;

  get selectedIndex => _selectedIndex;
  set selectedIndex(val) {
    _selectedIndex = val;
    notifyListeners();
  }
}
