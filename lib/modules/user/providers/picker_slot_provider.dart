import 'package:flutter/material.dart';

class PickerSlotProvider extends ChangeNotifier {
  int _selectedIndex = -1;
  int _selectedPitchIndex = -1;

  get selectedIndex => _selectedIndex;
  set selectedIndex(val) {
    _selectedIndex = val;
    notifyListeners();
  }

  get selectedPitchIndex => _selectedPitchIndex;
  set selectedPitchIndex(val) {
    _selectedPitchIndex = val;
    notifyListeners();
  }

  void cleanProperties() {
    _selectedIndex = -1;
    _selectedPitchIndex = -1;
  }
}
