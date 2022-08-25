import 'package:court_finder/models/court_model.dart';
import 'package:flutter/material.dart';

class CourtProfileProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String name = '';
  String location = '';
  String howToAccess = '';
  String description = '';
  String cancellationPolicy = '';

  //TODO: obtener los dias

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void initialize(CourtModel model) {
    name = model.name;
    location = model.location;
    howToAccess = model.howToAccess;
    description = model.description;
    cancellationPolicy = model.cancellationPolicy;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
