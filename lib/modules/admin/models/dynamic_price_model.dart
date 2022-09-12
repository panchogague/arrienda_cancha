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
}
