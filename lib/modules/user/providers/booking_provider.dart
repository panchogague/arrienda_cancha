import 'package:court_finder/models/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingProvider extends ChangeNotifier {
  DateTime _selectedDate = DateTime.now();
  SlotTimeModel? _slot;
  PitchModel? _pitch;

  get showBooking => _slot != null && _pitch != null;

  String get selectedDateFormat {
    var formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(_selectedDate);
  }

  String get slotsFormat => '${_slot!.from} - ${_slot!.to}';

  DateTime get selectedDate => _selectedDate;
  set selectedDate(value) {
    _selectedDate = value;
    dateAnimationController?.forward(from: 0.0);
    notifyListeners();
  }

  SlotTimeModel get slot => _slot!;

  set slot(value) {
    _slot = value;
    slotAnimationController?.forward(from: 0.0);
    priceAnimationController?.forward(from: 0.0);
    notifyListeners();
  }

  PitchModel get pitch => _pitch!;

  set pitch(value) {
    _pitch = value;
    priceAnimationController?.forward(from: 0.0);
    pitchAnimationController?.forward(from: 0.0);
    notifyListeners();
  }

  void cleanProverties() {
    _selectedDate = DateTime.now();
    _slot = null;
    _pitch = null;
    priceAnimationController = null;
    pitchAnimationController = null;
    dateAnimationController = null;
    slotAnimationController = null;
  }

  //Animation

  AnimationController? priceAnimationController;
  AnimationController? pitchAnimationController;
  AnimationController? dateAnimationController;
  AnimationController? slotAnimationController;
}
