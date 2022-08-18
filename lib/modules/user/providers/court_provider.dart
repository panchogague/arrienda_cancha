import 'package:court_finder/modules/user/models/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CourtProvider extends ChangeNotifier {
  CourtModel? _courtSelected;
  DateTime _dateSelected = DateTime.now();

  CourtModel? get courtSelected => _courtSelected;
  set courtSelected(value) {
    _courtSelected = value;
  }

  set dateSelected(value) {
    _dateSelected = value;
    notifyListeners();
  }

  List<SlotTimeModel> get slots {
    var formatter = DateFormat('yyyy-MM-dd');
    String key = formatter.format(_dateSelected);

    if (_courtSelected!.slotTimePerDate.containsKey(key)) {
      return _courtSelected!.slotTimePerDate[key]!;
    } else {
      return [];
    }
  }
}
