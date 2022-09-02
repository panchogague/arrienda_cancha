import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:court_finder/models/category_model.dart';

class CategoryDB {
  final _db = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getAllCategories() async {
    List<CategoryModel> result = [];
    try {
      var snap = await _db.collection('categories').get();
      for (var element in snap.docs) {
        final data = element.data();
        result.add(CategoryModel.fromFireBase(data, element.id));
      }
    } catch (e) {
      print(e);
    }

    return result;
  }
}
