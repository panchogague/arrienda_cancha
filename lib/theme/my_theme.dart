import 'package:flutter/material.dart';

class CustomTheme {
  static const Color iconColor = Color(0xff0098C3);
  static const Color textColor = Colors.black87;
  static const Color subTitle = Colors.grey;

  static final myTheme = ThemeData.light().copyWith(
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedLabelStyle: TextStyle(fontSize: 12),
    selectedItemColor: Color(0xffF34F57),
    showUnselectedLabels: false,
  ));
}
