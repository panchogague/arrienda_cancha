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
          primaryColor: const Color(0xffEE8655),
          secondaryColor: const Color(0xffF34F57)),
      CategoryModel(
          id: DateTime.now().toString(),
          name: 'Tenis',
          totalPlaces: 32,
          imgUrl: 'assets/tennis.png',
          primaryColor: const Color(0xffEE8655),
          secondaryColor: const Color(0xffF34F57)),
      CategoryModel(
          id: DateTime.now().toString(),
          name: 'Padel',
          totalPlaces: 25,
          imgUrl: 'assets/padel.png',
          primaryColor: const Color(0xffEE8655),
          secondaryColor: const Color(0xffF34F57)),
      CategoryModel(
          id: DateTime.now().toString(),
          name: 'Basketball',
          totalPlaces: 15,
          imgUrl: 'assets/basketball.png',
          primaryColor: const Color(0xffEE8655),
          secondaryColor: const Color(0xffF34F57)),
      CategoryModel(
          id: DateTime.now().toString(),
          name: 'Volleyball',
          totalPlaces: 8,
          imgUrl: 'assets/volleyball.png',
          primaryColor: const Color(0xffEE8655),
          secondaryColor: const Color(0xffF34F57)),
    ];
  }
}
