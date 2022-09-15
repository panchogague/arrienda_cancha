import 'package:court_finder/helpers/format_helper.dart';
import 'package:court_finder/models/models.dart';
import 'package:flutter/material.dart';

class PickerSlotProvider extends ChangeNotifier {
  int _selectedIndex = -1;
  int _selectedPitchIndex = -1;
  DateTime _dateSelected = DateTime.now();
  CourtModel? courtSelected;
  List<SlotTimeModel> _slots = [];

  get selectedIndex => _selectedIndex;
  set selectedIndex(val) {
    _selectedIndex = val;

    //TODO: obtener los precios variables, actualizar pitch
    for (var pitch in courtSelected!.pitches) {
      if (pitch.dynamicPrices != null) {
        final pricesActive = pitch.dynamicPrices!
            .where((d) =>
                d.isActive &&
                d.applicableDays.contains(_dateSelected.weekday.toString()))
            .toList();

        final slot = _slots[_selectedIndex];

        final existDynamicPrice = pricesActive
            .where((p) =>
                p.fromToDouble <= slot.fromToDouble &&
                p.toToDouble >= slot.toToDouble)
            .toList();
        if (existDynamicPrice.isNotEmpty) {
          pitch.priceDynamic = existDynamicPrice[0].price!;
        } else {
          pitch.priceDynamic = null;
        }
      }
    }
    notifyListeners();
  }

  get selectedPitchIndex => _selectedPitchIndex;
  set selectedPitchIndex(val) {
    _selectedPitchIndex = val;
    notifyListeners();
  }

  set dateSelected(value) {
    _dateSelected = value;
    notifyListeners();
  }

  void cleanProperties() {
    _selectedIndex = -1;
    _selectedPitchIndex = -1;
    _dateSelected = DateTime.now();
    courtSelected = null;
  }

  List<SlotTimeModel> getSlots() {
    List<SlotTimeModel> results = [];
    if (_selectedPitchIndex >= 0) {
      if (courtSelected!.openDays != null) {
        final openDay = courtSelected!.openDays!
            .where((op) => op.dayId == _dateSelected.weekday)
            .toList();

        if (openDay.isNotEmpty) {
          final pitch = courtSelected!.pitches[_selectedPitchIndex];

          final day = openDay[0];
          //TODO:check las reservas
          double from = day.fromToDouble;
          double to = day.toToDouble;

          while (from < to) {
            String hFrom = FormatHelper.convertDoubleToHour(from);
            from += (pitch.period / 60);
            String hTo = FormatHelper.convertDoubleToHour(from);
            results.add(SlotTimeModel(to: hTo, from: hFrom));
          }
        }
      }
    }
    _slots = results;
    return results;
  }
}
