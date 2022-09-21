import 'package:court_finder/helpers/format_helper.dart';
import 'package:court_finder/models/models.dart';
import 'package:intl/intl.dart';

class BookingModel {
  String courtId;
  String pitchId;
  String courtName;
  String pitchName;
  DateTime selectedDate;
  SlotTimeModel slots;
  String? id;
  int price;
  String cancellationPolicy;
  String location;
  String? userId;
  String status;

  BookingModel(
      {required this.courtId,
      required this.pitchId,
      required this.courtName,
      required this.pitchName,
      required this.selectedDate,
      required this.slots,
      required this.price,
      required this.cancellationPolicy,
      required this.location,
      this.status = 'Activa',
      this.id,
      this.userId});

  String get selectedDateFormat {
    var formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(selectedDate);
  }

  String get priceFormated => FormatHelper.priceFormated(price);

  Map<String, dynamic> toMap() => {
        "courtId": courtId,
        "pitchId": pitchId,
        "courtName": courtName,
        "pitchName": pitchName,
        "selectedDate": selectedDate,
        "cancellationPolicy": cancellationPolicy,
        "location": location,
        "userId": userId,
        "from": slots.from,
        "to": slots.to,
        "price": price,
        "status": status,
        "dtCreated": DateTime.now()
      };
}
