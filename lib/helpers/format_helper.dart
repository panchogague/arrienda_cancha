import 'package:intl/intl.dart';
import 'package:universal_io/io.dart';

class FormatHelper {
  static String periodFormated(int period) {
    final minutes = period % 60;
    final hours = (((period - minutes) / 60) % 24).round();

    final String hora = hours > 1 ? 'horas' : 'hora';

    if (hours == 0) {
      return '$period min';
    } else if (minutes == 0) {
      return '$hours $hora';
    } else {
      return '$hours $hora $minutes min';
    }
  }

  static String priceFormated(int? price) {
    if (price == null) {
      return '';
    }
    final formatCurrency =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'CLP');

    return formatCurrency.format(price);
  }
}
