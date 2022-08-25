import 'dart:convert';

import 'package:court_finder/models/models.dart';

class UserModel {
  UserModel({
    required this.firstName,
    this.isAdmin = false,
    required this.lastName,
    this.userId,
    required this.email,
  });

  String firstName;
  bool isAdmin;
  String lastName;
  String email;
  String? userId;
  List<CourtModel> adminCourts = [];

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<dynamic, dynamic> json) => UserModel(
        firstName: json["firstName"],
        isAdmin: json["isAdmin"],
        lastName: json["lastName"],
        //userId: json["userId"],
        email: json["email"],
      );

  factory UserModel.fromFireBase(Map<dynamic, dynamic> json, String key) =>
      UserModel(
        firstName: json["firstName"],
        isAdmin: json["isAdmin"],
        lastName: json["lastName"],
        userId: key,
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "firstName": firstName,
        "isAdmin": isAdmin,
        "lastName": lastName,
        //"userId": userId,
        "email": email,
      };
}
