import 'package:court_finder/database/pitch_db.dart';
import 'package:court_finder/models/models.dart';
import 'package:flutter/material.dart';

class PitchesFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<DropdownValueModel> categoriesDropdown = [];
  List<String> sizeDropdown = [];
  List<String> surfaceDropdown = [];
  List<DropdownValueModel> periodDropdown = [
    DropdownValueModel('30', '30 min'),
    DropdownValueModel('45', '45 min'),
    DropdownValueModel('60', '1 hora'),
    DropdownValueModel('90', '1 hora 30 min'),
    DropdownValueModel('120', '2 hora'),
  ];

  List<CategoryModel> _categories = [];
  PitchModel pitch = PitchModel(
      name: '',
      price: 0,
      surface: null,
      period: 0,
      size: null,
      categoryId: null);

  String? _sizeValue;
  String? get sizeValue => _sizeValue;
  set sizeValue(val) {
    _sizeValue = val;
    notifyListeners();
  }

//Optimizar esta parte, me daba error al usar el objeto
  String? _surfaceValue;
  String? get surfaceValue => _surfaceValue;
  set surfaceValue(val) {
    _surfaceValue = val;
    notifyListeners();
  }

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
    if (categoriesDropdown.isEmpty) {
      categoriesDropdown.addAll(
          categories.map((e) => DropdownValueModel(e.id!, e.name)).toList());
      _categories = categories;
      notifyListeners();
    }
  }

  loadDropdown(String categoryId) {
    pitch.size = null;
    pitch.surface = null;
    surfaceDropdown = [];
    sizeDropdown = [];

    sizeDropdown.addAll(_categories
        .firstWhere((cat) => cat.id == categoryId)
        .sizes
        .map((e) => e)
        .toList());

    surfaceDropdown.addAll(_categories
        .firstWhere((cat) => cat.id == categoryId)
        .surfaces
        .map((e) => e)
        .toList());

    notifyListeners();
  }

  Future<String?> savePitch(String courtId) async {
    return await PitchDB().savePitch(courtId, pitch);
  }
}
