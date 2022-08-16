import 'package:flutter/material.dart';

class CategoryModel {
  String name;
  String id; //TODO:cambiar esto si migramos de firebase
  int totalPlaces;
  Color primaryColor;
  Color secondaryColor;
  String imgUrl;

  CategoryModel(
      {required this.id,
      required this.name,
      required this.totalPlaces,
      required this.primaryColor,
      required this.secondaryColor,
      required this.imgUrl});

  static List<CategoryModel> getAllCategories() {
    return [
      CategoryModel(
          id: DateTime.now().toString(),
          name: 'Fútbol',
          totalPlaces: 72,
          imgUrl: 'assets/futbol.png',
          primaryColor: const Color(0xff56ab2f),
          secondaryColor: const Color(0xffa8e063)),
      CategoryModel(
          id: DateTime.now().toString(),
          name: 'Tenis',
          totalPlaces: 32,
          imgUrl: 'assets/tennis.png',
          primaryColor: const Color(0xff2193b0),
          secondaryColor: const Color(0xff6dd5ed)),
      CategoryModel(
          id: DateTime.now().toString(),
          name: 'Padel',
          totalPlaces: 25,
          imgUrl: 'assets/padel.png',
          primaryColor: const Color(0xffbdc3c7),
          secondaryColor: const Color(0xff2c3e50)),
      CategoryModel(
          id: DateTime.now().toString(),
          name: 'Basketball',
          totalPlaces: 15,
          imgUrl: 'assets/basketball.png',
          primaryColor: const Color(0xffff5f6d),
          secondaryColor: const Color(0xffffc371)),
      CategoryModel(
          id: DateTime.now().toString(),
          name: 'Volleyball',
          totalPlaces: 8,
          imgUrl: 'assets/volleyball.png',
          primaryColor: const Color(0xffffd89b),
          secondaryColor: const Color(0xff19547b)),
    ];
  }
}
