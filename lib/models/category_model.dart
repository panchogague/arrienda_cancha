import 'dart:convert';

class CategoryModel {
  CategoryModel(
      {required this.imgUrl,
      required this.name,
      required this.sizes,
      required this.surfaces,
      this.totalPlaces = 0,
      this.id});
  String? id;
  String imgUrl;
  String name;
  int totalPlaces;
  List<String> sizes;
  List<String> surfaces;

  factory CategoryModel.fromJson(String str) =>
      CategoryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromMap(Map<String, dynamic> json) => CategoryModel(
        imgUrl: json["imgUrl"],
        name: json["name"],
        sizes: (json["sizes"] as List).map((e) => e as String).toList(),
        surfaces: (json["surfaces"] as List).map((e) => e as String).toList(),
      );

  factory CategoryModel.fromFireBase(Map<String, dynamic> json, String key) =>
      CategoryModel(
          imgUrl: json["imgUrl"],
          name: json["name"],
          sizes: (json["sizes"] as List).map((e) => e as String).toList(),
          surfaces: (json["surfaces"] as List).map((e) => e as String).toList(),
          id: key);

  Map<String, dynamic> toMap() => {
        "imgUrl": imgUrl,
        "name": name,
        "sizes": sizes,
        "surfaces": surfaces,
      };
}
