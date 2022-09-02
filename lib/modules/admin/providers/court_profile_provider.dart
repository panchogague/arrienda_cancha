import 'package:court_finder/database/court_db.dart';
import 'package:court_finder/models/court_model.dart';
import 'package:court_finder/models/models.dart';
import 'package:court_finder/modules/admin/models/checkbox_value_model.dart';
import 'package:flutter/material.dart';

class CourtProfileProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  CourtModel court = CourtModel(
      name: '',
      location: '',
      howToAccess: '',
      description: '',
      cancellationPolicy: '',
      imgUrl: '',
      price: '',
      userId: '');

  List<CheckboxValueModel> facilities = [];

  CourtProfileProvider() {
    for (var facility in FacilityModel.getAllFacilities()) {
      facilities.add(CheckboxValueModel(facility.name));
    }
  }

  List<CheckboxValueModel> daysOfWeeks = [
    CheckboxValueModel('Lunes', id: '1'),
    CheckboxValueModel('Martes', id: '2'),
    CheckboxValueModel('Miércoles', id: '3'),
    CheckboxValueModel('Jueves', id: '4'),
    CheckboxValueModel('Viernes', id: '5'),
    CheckboxValueModel('Sábado', id: '6'),
    CheckboxValueModel('Domingo', id: '7'),
  ];

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void initialize(CourtModel model) {
    court = model;

    if (court.openDays != null) {
      for (var day in court.openDays!) {
        int indx = daysOfWeeks.indexWhere((i) => i.id == '$day');
        daysOfWeeks[indx].value = true;
      }
    }

    if (court.facilities != null) {
      for (var facility in court.facilities!) {
        int indx = facilities.indexWhere((i) => i.name == facility);
        facilities[indx].value = true;
      }
    }
  }

  void checkFacilities(bool b, int index) {
    facilities[index].value = !facilities[index].value; // Individual task value
    notifyListeners();
  }

  void checkDaysOfWeek(bool b, int index) {
    daysOfWeeks[index].value =
        !daysOfWeeks[index].value; // Individual task value
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Future<String?> createOrUpdateCourt(String userId) async {
    court.userId = userId;
    court.openDays = [];
    for (var day in daysOfWeeks.where((CheckboxValueModel d) => d.value)) {
      court.openDays!.add(int.parse(day.id));
    }

    court.facilities = [];
    for (var facility in facilities.where((CheckboxValueModel d) => d.value)) {
      court.facilities!.add(facility.name);
    }

    return await CourtDB().createOrUpdateCourt(court);
  }
}
