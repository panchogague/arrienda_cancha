import 'package:court_finder/database/category_db.dart';
import 'package:court_finder/models/models.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  var categories = <CategoryModel>[].obs;
  var isLoading = true.obs;

  CategoryController() {
    loadCategories();
  }

  Future loadCategories() async {
    isLoading.value = true;
    categories.value = await CategoryDB().getAllCategories();
    isLoading.value = false;
  }
}
