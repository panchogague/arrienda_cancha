import 'package:court_finder/models/court_model.dart';
import 'package:flutter/material.dart';

class CourtService extends ChangeNotifier {
  CourtModel? court;

  CourtService(this.court);
}
