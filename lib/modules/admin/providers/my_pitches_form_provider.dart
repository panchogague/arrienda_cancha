import 'package:court_finder/database/pitch_db.dart';
import 'package:court_finder/models/models.dart';
import 'package:flutter/material.dart';

class MyPitchesFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<DropdownValueModel> categoriesDropdown = [
    DropdownValueModel('-1', 'Seleccione'),
  ];
  List<DropdownValueModel> sizeDropdown = [
    DropdownValueModel('-1', 'Seleccione'),
  ];
  List<DropdownValueModel> surfaceDropdown = [
    DropdownValueModel('-1', 'Seleccione'),
  ];
  List<DropdownValueModel> periodDropdown = [
    DropdownValueModel('-1', 'Seleccione'),
    DropdownValueModel('30', '30 min'),
    DropdownValueModel('45', '45 min'),
    DropdownValueModel('60', '1 hora'),
    DropdownValueModel('90', '1 hora 30 min'),
    DropdownValueModel('120', '2 hora'),
  ];
  List<CategoryModel> _categories = [];
  PitchModel pitch =
      PitchModel(name: '', price: 0, surface: '', period: 0, size: '');

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  loadCategoriesDropdown(List<CategoryModel> categories) {
    if (categoriesDropdown.length == 1) {
      categoriesDropdown.addAll(
          categories.map((e) => DropdownValueModel(e.id!, e.name)).toList());
      _categories = categories;
      notifyListeners();
    }
  }

  loadDropdown(String categoryId) {
    if (categoryId != '-1') {
      sizeDropdown = [
        DropdownValueModel('-1', 'Seleccione'),
      ];
      sizeDropdown.addAll(_categories
          .firstWhere((cat) => cat.id == categoryId)
          .sizes
          .map((e) => DropdownValueModel(e, e))
          .toList());

      surfaceDropdown = [
        DropdownValueModel('-1', 'Seleccione'),
      ];
      surfaceDropdown.addAll(_categories
          .firstWhere((cat) => cat.id == categoryId)
          .surfaces
          .map((e) => DropdownValueModel(e, e))
          .toList());

      notifyListeners();
    }
  }

  Future<String?> savePitch(String courtId) async {
    return await PitchDB().savePitch(courtId, pitch);
  }
}
