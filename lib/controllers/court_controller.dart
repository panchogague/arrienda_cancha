import 'package:court_finder/database/court_db.dart';
import 'package:court_finder/models/models.dart';
import 'package:get/get.dart';

class CourtController extends GetxController {
  var isLoading = true.obs;
  final Map<String, List<CourtModel>> _courtsCategory =
      <String, List<CourtModel>>{};
  String? _categoryId;

  var court = Rx<CourtModel?>(null);

  Future<void> populateCourtsByCategory(String categoryId) async {
    isLoading.value = true;

    _categoryId = categoryId;
    _courtsCategory[categoryId] =
        await CourtDB().getCourtsByCategoryId(categoryId);
    //TODO:cambiar esto, agregar court si no existe, para mejorar performace

    isLoading.value = false;
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
