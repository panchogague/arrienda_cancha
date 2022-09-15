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

  static String convertTime(int hour, int min) {
    return '${hour.toString().padLeft(2, '0')}:${min.toString().padLeft(2, '0')}';
  }

  static final Map<int, String> _dayOfWeek = {
    1: 'Lunes',
    2: 'Martes',
    3: 'Miércoles',
    4: 'Jueves',
    5: 'Viernes',
    6: 'Sábado',
    7: 'Domingo'
  };

  static String dayOfWeek(int dayId) => _dayOfWeek[dayId] ?? '';
  static String dayOfWeekId(String name) =>
      _dayOfWeek.keys.firstWhere((val) => _dayOfWeek[val] == name).toString();

  static String convertDoubleToHour(double hour) {
    int flooredValue = hour.floor();
    double decimalValue = hour - flooredValue;
    String hourValue = _getHourString(flooredValue);
    String minuteString = _getMinuteString(decimalValue);
    return '$hourValue:$minuteString';
  }

  static String _getMinuteString(double decimalValue) {
    return '${(decimalValue * 60).toInt()}'.padLeft(2, '0');
  }

  static String _getHourString(int flooredValue) {
    return '${flooredValue % 24}'.padLeft(2, '0');
  }

  static double convertHourStringToDouble(String hour) {
    final hFrom = hour.split(':');
    return double.parse(hFrom[0]) + (double.parse(hFrom[1]) / 60);
  }
}
