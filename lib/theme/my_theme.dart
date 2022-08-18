import 'package:flutter/material.dart';

const primary = Color(0xffF34F57);

final myTheme = ThemeData.light().copyWith(
    primaryColor: primary,
    textTheme: const TextTheme(
      headline1: TextStyle(
          color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold),
      headline2: TextStyle(
          color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold),
      headline3: TextStyle(color: Colors.black87, fontSize: 18),
      headline4: TextStyle(
          color: Colors.blueGrey, fontSize: 15, fontWeight: FontWeight.w500),
      headline5: TextStyle(
          color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w500),
      bodyText1: TextStyle(
          color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),
      bodyText2: TextStyle(
          color: Colors.black54, fontSize: 14, fontWeight: FontWeight.bold),
      subtitle1: TextStyle(color: Colors.blueGrey, fontSize: 12),
      subtitle2: TextStyle(
          color: Colors.black87, fontSize: 12, fontWeight: FontWeight.w600),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      selectedLabelStyle: TextStyle(fontSize: 10),
      unselectedIconTheme: IconThemeData(size: 18),
      selectedIconTheme: IconThemeData(size: 20),
      selectedItemColor: primary,
      showUnselectedLabels: false,
    ));
