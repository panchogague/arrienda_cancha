import 'package:court_finder/database/court_db.dart';
import 'package:court_finder/models/court_model.dart';
import 'package:flutter/material.dart';

class CourtService extends ChangeNotifier {
  CourtModel? court;
  final Map<String, List<CourtModel>> _courtsCategory =
      <String, List<CourtModel>>{};
  String? _categoryId;

  CourtService(this.court);

  bool isLoading = true;

  Future<void> populateCourtsByCategory(String categoryId) async {
    isLoading = true;
    notifyListeners();
    _categoryId = categoryId;
    _courtsCategory[categoryId] =
        await CourtDB().getCourtsByCategoryId(categoryId);
    //TODO:cambiar esto, agregar court si no existe, para mejorar performace

    isLoading = false;
    notifyListeners();
  }

  List<CourtModel> get courtsCategory {
    if (_categoryId != null) {
      if (_courtsCategory.containsKey(_categoryId)) {
        return _courtsCategory[_categoryId]!;
      }
    }
    return [];
  }
}
