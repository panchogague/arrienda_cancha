import 'package:court_finder/database/category_db.dart';
import 'package:court_finder/models/category_model.dart';

import 'package:flutter/material.dart';

class CategoryService extends ChangeNotifier {
  List<CategoryModel> categories = [];

  bool isLoading = true;

  CategoryService() {
    loadCategories();
  }

  Future loadCategories() async {
    isLoading = true;
    notifyListeners();
    categories = await CategoryDB().getAllCategories();
    isLoading = false;
    notifyListeners();
  }
}
