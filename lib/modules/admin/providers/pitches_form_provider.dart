import 'dart:math';

import 'package:court_finder/database/court_db.dart';
import 'package:court_finder/database/pitch_db.dart';
import 'package:court_finder/models/models.dart';
import 'package:court_finder/modules/admin/models/models.dart';
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

  final List<CategoryModel> _categories;

  PitchModel? pitch;
  PitchesFormProvider(this._categories) {
    if (categoriesDropdown.isEmpty) {
      categoriesDropdown.addAll(
          _categories.map((e) => DropdownValueModel(e.id!, e.name)).toList());
    }
  }

  String? id;
  String price = '';
  String name = '';
  String? categoryId;
  String? category;
  String? _sizeValue;
  String? period;
  String? get sizeValue => _sizeValue;
  set sizeValue(val) {
    _sizeValue = val;
    notifyListeners();
  }

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

  loadDropdown(String categoryId, {bool isNotify = true}) {
    _sizeValue = null;
    _surfaceValue = null;
    surfaceDropdown = [];
    sizeDropdown = [];

    if (_categories.isNotEmpty) {
      category = _categories.firstWhere((c) => c.id == categoryId).name;

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
    }

    if (isNotify) {
      notifyListeners();
    }
  }

  Future<String?> savePitch(CourtModel court) async {
    if (pitch != null) {
      pitch!.name = name;
      pitch!.price = int.parse(price);
      pitch!.period = int.parse(period!);
      pitch!.size = _sizeValue;
      pitch!.surface = _surfaceValue;
      pitch!.category = category;
      pitch!.categoryId = categoryId;
    } else {
      pitch = PitchModel(
          name: name,
          price: int.parse(price),
          period: int.parse(period!),
          id: id,
          size: _sizeValue,
          surface: _surfaceValue,
          category: category,
          categoryId: categoryId);
    }

    bool isInsert = pitch!.id == null;

    String? resp = await PitchDB().createOrUpdatePitch(court.id!, pitch!);
    if (resp == null) {
      if (isInsert) {
        court.pitches.insert(0, pitch!);
      }
      court.priceFrom = court.pitches.map((e) => e.price).reduce(min);
      if (!court.categories.contains(pitch!.categoryId)) {
        court.categories.add(pitch!.categoryId!);
      }
      await CourtDB().createOrUpdateCourt(court);
    }
    notifyListeners();
    return resp;
  }

  Future<String?> deletePitch(CourtModel court, String id) async {
    isLoading = true;
    String? resp = await PitchDB().deletePitch(court.id!, id);
    if (resp == null) {
      court.pitches.removeWhere((pitch) => pitch.id == id);
      court.priceFrom = court.pitches.map((e) => e.price).reduce(min);
      court.categories = [];

      for (var pitch in court.pitches) {
        if (!court.categories.contains(pitch.categoryId)) {
          court.categories.add(pitch.categoryId!);
        }
      }

      await CourtDB().createOrUpdateCourt(court);
    }
    isLoading = false;
    return resp;
  }

  void setValues(PitchModel model) {
    pitch = model;
    loadDropdown(model.categoryId!, isNotify: false);
    name = model.name;
    category = model.category;
    categoryId = model.categoryId;
    id = model.id;
    period = '${model.period}';
    _sizeValue = model.size;
    _surfaceValue = model.surface;
    price = '${model.price}';
    notifyListeners();
  }

  void cleanValues() {
    name = '';
    price = '';
    period = null;
    id = null;
    _sizeValue = null;
    _surfaceValue = null;
    category = '';
    categoryId = null;
    sizeDropdown = [];
    surfaceDropdown = [];
    pitch = null;
  }
}
