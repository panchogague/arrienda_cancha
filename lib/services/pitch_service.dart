import 'dart:math';

import 'package:court_finder/models/models.dart';
import 'package:flutter/material.dart';

class PitchService extends ChangeNotifier {
  List<PitchModel> pitches;

  PitchService(this.pitches);

  void refreshGrid() {
    // pitches.insert(0, newPitch);
    notifyListeners();
  }
}
