import 'package:court_finder/helpers/format_helper.dart';

enum TypePrice { horaBaja, horaMedia, horaAlta }

class DynamicPriceModel {
  bool isActive;
  String type;
  int? price;
  List<String> applicableDays;
  String from;
  String to;

  DynamicPriceModel(
      {this.isActive = false,
      required this.type,
      this.price,
      required this.applicableDays,
      this.to = '',
      this.from = ''});

  Map<String, dynamic> toMap() => {
        "isActive": isActive,
        "price": price,
        "type": type,
        "applicableDays": applicableDays,
        "from": from,
        "to": to,
      };

  factory DynamicPriceModel.fromMap(
          Map<String, dynamic> json) =>
      DynamicPriceModel(
          isActive: json['isActive'],
          price: json['price'],
          to: json['to'],
          from: json['from'],
          applicableDays: json.containsKey('applicableDays')
              ? (json['applicableDays'] as List)
                  .map((e) => e as String)
                  .toList()
              : [],
          type: json['type']);

  double get fromToDouble => FormatHelper.convertHourStringToDouble(from);
  double get toToDouble => FormatHelper.convertHourStringToDouble(to);
}
