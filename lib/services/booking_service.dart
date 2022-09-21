import 'package:court_finder/database/booking_db.dart';
import 'package:court_finder/models/booking_model.dart';
import 'package:flutter/cupertino.dart';

class BookingService extends ChangeNotifier {
  final String? userId;
  final List<BookingModel> myBookings = [];

  BookingService(this.userId);

  Future<String?> createBooking(BookingModel booking) async {
    booking.userId = userId;
    final resp = await BookingDb().createBooking(booking);
    if (resp == null) {
      myBookings.add(booking);
      return null;
    }

    return resp;
  }
}
