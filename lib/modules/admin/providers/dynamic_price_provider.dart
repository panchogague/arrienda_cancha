import 'package:court_finder/database/pitch_db.dart';
import 'package:court_finder/helpers/format_helper.dart';
import 'package:court_finder/models/models.dart';
import 'package:court_finder/modules/admin/models/models.dart';
import 'package:flutter/material.dart';

class DynamicPriceProvider extends ChangeNotifier {
  List<String> applicableDays = [];

  PitchModel? pitch;

  DynamicPriceProvider(this.pitch) {
    if (pitch != null) {
      if (pitch!.dynamicPrices != null) {
        final horaBaja = pitch!.dynamicPrices!
            .firstWhere((e) => e.type == TypePrice.horaBaja.name);
        final horaMedia = pitch!.dynamicPrices!
            .firstWhere((e) => e.type == TypePrice.horaMedia.name);
        final horaAlta = pitch!.dynamicPrices!
            .firstWhere((e) => e.type == TypePrice.horaAlta.name);

        _isActiveBaja = horaBaja.isActive;
        priceBaja = horaBaja.price != null ? horaBaja.price.toString() : '';
        _fromBaja = horaBaja.from;
        _toBaja = horaBaja.to;
        applicableDaysBaja = horaBaja.applicableDays
            .map((e) => FormatHelper.dayOfWeek(int.parse(e)))
            .toList();

        _isActiveMedia = horaMedia.isActive;
        priceMedia = horaMedia.price != null ? horaMedia.price.toString() : '';
        _fromMedia = horaMedia.from;
        _toMedia = horaMedia.to;
        applicableDaysMedia = horaMedia.applicableDays
            .map((e) => FormatHelper.dayOfWeek(int.parse(e)))
            .toList();

        _isActiveAlta = horaAlta.isActive;
        priceAlta = horaAlta.price != null ? horaAlta.price.toString() : '';
        _fromAlta = horaAlta.from;
        _toAlta = horaAlta.to;
        applicableDaysAlta = horaAlta.applicableDays
            .map((e) => FormatHelper.dayOfWeek(int.parse(e)))
            .toList();
      }
    } else {
      //TODO:clean form
    }
  }

  void loadApplicableDays(List<OpenDayModel> openDays) {
    if (applicableDays.isEmpty) {
      applicableDays.addAll(openDays.map((e) => e.dayName));
      if (applicableDaysBaja.isEmpty) {
        applicableDaysBaja = applicableDays;
      }
      if (applicableDaysMedia.isEmpty) {
        applicableDaysMedia = applicableDays;
      }
      if (applicableDaysAlta.isEmpty) {
        applicableDaysAlta = applicableDays;
      }
    }
  }

  //Hora baja
  bool _isActiveBaja = false;
  String priceBaja = '';
  List<String> applicableDaysBaja = [];
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
  List<String> applicableDaysMedia = [];
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
  List<String> applicableDaysAlta = [];
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

  Future<String?> saveDynamicPrice(CourtModel court) async {
    //TODO:validar
    if (pitch != null) {
      final List<DynamicPriceModel> model = [
        DynamicPriceModel(
            type: TypePrice.horaBaja.name,
            applicableDays: applicableDaysBaja
                .map((e) => FormatHelper.dayOfWeekId(e))
                .toList(),
            price: priceBaja.isNotEmpty ? int.parse(priceBaja) : null,
            from: fromBaja,
            to: toBaja,
            isActive: isActiveBaja),
        DynamicPriceModel(
            type: TypePrice.horaMedia.name,
            applicableDays: applicableDaysMedia
                .map((e) => FormatHelper.dayOfWeekId(e))
                .toList(),
            price: priceMedia.isNotEmpty ? int.parse(priceMedia) : null,
            from: fromMedia,
            to: toMedia,
            isActive: isActiveMedia),
        DynamicPriceModel(
            type: TypePrice.horaAlta.name,
            applicableDays: applicableDaysAlta
                .map((e) => FormatHelper.dayOfWeekId(e))
                .toList(),
            price: priceAlta.isNotEmpty ? int.parse(priceAlta) : null,
            from: fromAlta,
            to: toAlta,
            isActive: isActiveAlta)
      ];

      pitch!.dynamicPrices = model;
      String? resp = await PitchDB().createOrUpdatePitch(court.id!, pitch!);
      return resp;
    } else {
      return 'error'; //TODO:mejorar esto
    }
  }
}
