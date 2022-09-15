import 'package:court_finder/helpers/format_helper.dart';

class OpenDayModel {
  int dayId;
  String from;
  String to;

  OpenDayModel(this.dayId, this.from, this.to);

  Map<String, dynamic> toMap() => {
        "dayId": dayId,
        "from": from,
        "to": to,
      };

  factory OpenDayModel.fromMap(Map<String, dynamic> json) =>
      OpenDayModel(json["dayId"], json["from"], json["to"]);

  String get dayName => FormatHelper.dayOfWeek(dayId);

  double get fromToDouble => FormatHelper.convertHourStringToDouble(from);
  double get toToDouble => FormatHelper.convertHourStringToDouble(to);
}
