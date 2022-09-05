import 'package:court_finder/database/court_db.dart';
import 'package:court_finder/models/models.dart';
import 'package:court_finder/modules/admin/models/models.dart';
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

  List<CheckboxOpenDayModel> daysOfWeeks = [
    CheckboxOpenDayModel('Lunes', id: '1'),
    CheckboxOpenDayModel('Martes', id: '2'),
    CheckboxOpenDayModel('Miércoles', id: '3'),
    CheckboxOpenDayModel('Jueves', id: '4'),
    CheckboxOpenDayModel('Viernes', id: '5'),
    CheckboxOpenDayModel('Sábado', id: '6'),
    CheckboxOpenDayModel('Domingo', id: '7'),
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
        int indx = daysOfWeeks.indexWhere((i) => i.id == '${day.dayId}');
        daysOfWeeks[indx].value = true;
        TimeOfDay from = TimeOfDay(
            hour: int.parse(day.from.split(":")[0]),
            minute: int.parse(day.from.split(":")[1]));
        daysOfWeeks[indx].from = from;

        TimeOfDay to = TimeOfDay(
            hour: int.parse(day.to.split(":")[0]),
            minute: int.parse(day.to.split(":")[1]));
        daysOfWeeks[indx].to = to;
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

  void checkDaysOfWeek(int index) {
    daysOfWeeks[index].value =
        !daysOfWeeks[index].value; // Individual task value
    notifyListeners();
  }

  void setHourDaysOfWeek(int index, TimeOfDay? from, TimeOfDay? to) {
    if (from != null) {
      daysOfWeeks[index].from = from;
    }

    if (to != null) {
      daysOfWeeks[index].to = to;
    }
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Future<String?> createOrUpdateCourt(String userId) async {
    court.userId = userId;
    court.openDays = [];
    for (var day in daysOfWeeks.where((CheckboxOpenDayModel d) => d.value)) {
      String from =
          '${day.from!.hour.toString().padLeft(2, '0')}:${day.from!.minute.toString().padLeft(2, '0')}';
      String to =
          '${day.to!.hour.toString().padLeft(2, '0')}:${day.to!.minute.toString().padLeft(2, '0')}';

      final openHour = OpenDayModel(int.parse(day.id), from, to);
      court.openDays!.add(openHour);
    }

    court.facilities = [];
    for (var facility in facilities.where((CheckboxValueModel d) => d.value)) {
      court.facilities!.add(facility.name);
    }

    return await CourtDB().createOrUpdateCourt(court);
  }
}
