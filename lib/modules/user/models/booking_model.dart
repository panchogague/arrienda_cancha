import 'package:court_finder/modules/user/models/models.dart';
import 'package:intl/intl.dart';

class BookingModel {
  DateTime selectedDate;
  CourtModel court;
  SlotTimeModel slot;
  PitchModel pitch;

  String get selectedDateFormat {
    var formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(selectedDate);
  }

  BookingModel(
      {required this.court,
      required this.selectedDate,
      required this.slot,
      required this.pitch});
}
