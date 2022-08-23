import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:court_finder/models/category_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CategoryService extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  List<CategoryModel> categories = [];

  bool isLoading = true;

  final storage = const FlutterSecureStorage();

  CategoryService() {
    loadCategories();
  }

  Future loadCategories() async {
    isLoading = true;
    notifyListeners();
    try {
      var snap = await _db.collection('categories').get();
      for (var element in snap.docs) {
        final data = element.data();
        categories.add(CategoryModel.fromFireBase(data, element.id));
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }
}
