import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:court_finder/models/models.dart';

class BookingDb {
  final _db = FirebaseFirestore.instance;

  Future<String?> createBooking(BookingModel booking) async {
    try {
      final ref = _db.collection('bookings').doc();
      await ref.set(booking.toMap());
      booking.id = ref.id;
      return null;
    } catch (e) {
      print(e);
      return 'Error al guardar la data';
    }
  }
}
