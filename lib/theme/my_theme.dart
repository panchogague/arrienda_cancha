import 'package:flutter/material.dart';

final myTheme = ThemeData.light().copyWith(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
  selectedLabelStyle: TextStyle(fontSize: 12),
  selectedItemColor: Color(0xffF34F57),
  showUnselectedLabels: false,
));
