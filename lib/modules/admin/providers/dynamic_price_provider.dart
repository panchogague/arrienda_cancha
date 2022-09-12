import 'package:court_finder/database/pitch_db.dart';
import 'package:court_finder/models/models.dart';
import 'package:court_finder/modules/admin/models/models.dart';
import 'package:flutter/material.dart';

class DynamicPriceProvider extends ChangeNotifier {
  List<CheckboxValueModel> applicableDays = [];

  void loadApplicableDays(List<OpenDayModel> openDays) {
    if (applicableDays.isEmpty) {
      applicableDays.addAll(openDays.map((e) =>
          CheckboxValueModel(e.dayName, id: e.dayId.toString(), value: false)));
      applicableDaysBaja = applicableDays;
      applicableDaysMedia = applicableDays;
      applicableDaysAlta = applicableDays;
    }
  }

  //Hora baja
  bool _isActiveBaja = false;
  String priceBaja = '';
  List<CheckboxValueModel> applicableDaysBaja = [];
  String _fromBaja = '';
  String _toBaja = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set isActiveBaja(val) {
    _isActiveBaja = val;
    notifyListeners();
  }

  bool get isActiveBaja => _isActiveBaja;

  set fromBaja(val) {
    _fromBaja = val;
    notifyListeners();
  }

  String get fromBaja => _fromBaja;

  set toBaja(val) {
    _toBaja = val;
    notifyListeners();
  }

  String get toBaja => _toBaja;

  //Hora Media
  bool _isActiveMedia = false;
  String priceMedia = '';
  List<CheckboxValueModel> applicableDaysMedia = [];
  String _fromMedia = '';
  String _toMedia = '';

  set isActiveMedia(val) {
    _isActiveMedia = val;
    notifyListeners();
  }

  bool get isActiveMedia => _isActiveMedia;

  set fromMedia(val) {
    _fromMedia = val;
    notifyListeners();
  }

  String get fromMedia => _fromMedia;

  set toMedia(val) {
    _toMedia = val;
    notifyListeners();
  }

  String get toMedia => _toMedia;

  //Hora Alta
  bool _isActiveAlta = false;
  String priceAlta = '';
  List<CheckboxValueModel> applicableDaysAlta = [];
  String _fromAlta = '';
  String _toAlta = '';

  set isActiveAlta(val) {
    _isActiveAlta = val;
    notifyListeners();
  }

  bool get isActiveAlta => _isActiveAlta;

  set fromAlta(val) {
    _fromAlta = val;
    notifyListeners();
  }

  String get fromAlta => _fromAlta;

  set toAlta(val) {
    _toAlta = val;
    notifyListeners();
  }

  String get toAlta => _toAlta;

  Future<String?> saveDynamicPrice(CourtModel court, PitchModel pitch) async {
    //TODO:validar
    final List<DynamicPriceModel> model = [
      DynamicPriceModel(
          type: TypePrice.horaBaja.name,
          applicableDays: applicableDaysBaja.map((e) => e.id).toList(),
          price: priceBaja.isNotEmpty ? int.parse(priceBaja) : null,
          from: fromBaja,
          to: toBaja,
          isActive: isActiveBaja),
      DynamicPriceModel(
          type: TypePrice.horaMedia.name,
          applicableDays: applicableDaysMedia.map((e) => e.id).toList(),
          price: priceMedia.isNotEmpty ? int.parse(priceMedia) : null,
          from: fromMedia,
          to: toMedia,
          isActive: isActiveMedia),
      DynamicPriceModel(
          type: TypePrice.horaAlta.name,
          applicableDays: applicableDaysAlta.map((e) => e.id).toList(),
          price: priceAlta.isNotEmpty ? int.parse(priceAlta) : null,
          from: fromAlta,
          to: toAlta,
          isActive: isActiveAlta)
    ];

    pitch.dynamicPrices = model;
    String? resp = await PitchDB().createOrUpdatePitch(court.id!, pitch);
    return resp;
  }
}
