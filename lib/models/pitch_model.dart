import 'package:court_finder/helpers/format_helper.dart';
import 'package:court_finder/modules/admin/models/dynamic_price_model.dart';

class PitchModel {
  String? id;
  String name;
  int price;
  String? size;
  String? surface;
  int period;
  String? categoryId;
  String? category;
  List<DynamicPriceModel>? dynamicPrices;

  get priceFormated => FormatHelper.priceFormated(price);

  get periodFormated => FormatHelper.periodFormated(period);

  PitchModel(
      {required this.name,
      required this.price,
      this.size,
      this.surface,
      required this.period,
      this.categoryId,
      this.category,
      this.id,
      this.dynamicPrices});

  Map<String, dynamic> toMap() => {
        "name": name,
        "price": price,
        "size": size,
        "surface": surface,
        "period": period,
        "categoryId": categoryId,
        "category": category,
        "dynamicPrices": dynamicPrices != null
            ? dynamicPrices!.map((e) => e.toMap()).toList()
            : null,
      };

  factory PitchModel.fromFireBase(Map<dynamic, dynamic> json, String key) =>
      PitchModel(
        category: json["category"],
        categoryId: json["categoryId"],
        name: json["name"],
        period: json["period"],
        price: json["price"],
        size: json["size"],
        surface: json["surface"],
        id: key,
      );
}
