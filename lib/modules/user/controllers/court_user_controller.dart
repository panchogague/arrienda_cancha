import 'package:get/get.dart';
import 'package:court_finder/database/pitch_db.dart';
import 'package:court_finder/models/models.dart';

class CourtUserController extends GetxController {
  CourtModel? _courtSelected; // = Rx<CourtModel?>(null);

  String? categoryIdSelected;

  CourtModel? get courtSelected => _courtSelected;
  set courtSelected(value) {
    _courtSelected = value;
    if (_courtSelected != null) {
      loadPitches();
    }
  }

  Future<void> loadPitches() async {
    if (categoryIdSelected != null) {
      _courtSelected!.pitches = await PitchDB().getPichesByCourtIdAndCategoryId(
          _courtSelected!.id!, categoryIdSelected!);
    }
  }

  List<FacilityModel> getFacilities() {
    List<FacilityModel> allFacilities = FacilityModel.getAllFacilities();

    if (_courtSelected != null) {
      if (_courtSelected!.facilities != null) {
        return _courtSelected!.facilities!
            .map((e) => allFacilities.firstWhere((f) => f.name == e))
            .toList();
      }
    }
    return [];
  }
}
