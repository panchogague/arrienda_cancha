import 'dart:convert';

class CategoryModel {
  CategoryModel(
      {required this.imgUrl,
      required this.name,
      this.totalPlaces = 0,
      this.id});
  String? id;
  String imgUrl;
  String name;
  int totalPlaces;

  factory CategoryModel.fromJson(String str) =>
      CategoryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromMap(Map<String, dynamic> json) => CategoryModel(
        imgUrl: json["imgUrl"],
        name: json["name"],
      );

  factory CategoryModel.fromFireBase(Map<String, dynamic> json, String key) =>
      CategoryModel(imgUrl: json["imgUrl"], name: json["name"], id: key);

  Map<String, dynamic> toMap() => {
        "imgUrl": imgUrl,
        "name": name,
      };
}
