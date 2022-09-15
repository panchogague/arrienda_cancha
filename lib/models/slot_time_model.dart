import 'package:court_finder/helpers/format_helper.dart';

class SlotTimeModel {
  bool isAvailable;
  String to;
  String from; //TODO: quizas cambiar por tipo hora

  String get slotToString {
    return '$from - $to';
  }

  SlotTimeModel(
      {required this.to, required this.from, this.isAvailable = true});

  double get fromToDouble => FormatHelper.convertHourStringToDouble(from);
  double get toToDouble => FormatHelper.convertHourStringToDouble(to);
}
