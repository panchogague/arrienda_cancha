import 'package:flutter/material.dart';

class UIProvider extends ChangeNotifier {
  late GlobalKey<ScaffoldState> scaffoldKey;

  UIProvider() {
    scaffoldKey = GlobalKey();
  }
}
