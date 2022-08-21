import 'package:flutter/material.dart';

class UIProvider extends ChangeNotifier {
  GlobalKey<ScaffoldState>? scaffoldKey;
  int _currentIndexPage = 0;

  get currentIndexPage => _currentIndexPage;

  set currentIndexPage(value) {
    _currentIndexPage = value;
    notifyListeners();
  }
}
