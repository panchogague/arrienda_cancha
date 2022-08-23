import 'dart:io';

import 'package:intl/intl.dart';

class PitchModel {
  String name;
  int price;
  String size;
  String surface;

  get priceFormated {
    final formatCurrency =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'CLP');

    return formatCurrency.format(price);
  }

  PitchModel(
      {required this.name,
      required this.price,
      required this.size,
      required this.surface});
}
