import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:court_finder/models/models.dart';

class CourtDB {
  final _db = FirebaseFirestore.instance;

  Future<String?> createOrUpdateCourt(CourtModel court) async {
    try {
      if (court.id != null) {
        final courtDB = _db.collection('courts').doc(court.id);
        courtDB.update(court.toMap());
      } else {
        await _db.collection('courts').doc().set(court.toMap());
      }
      return null;
    } catch (e) {
      print(e);
      return 'Error al guardar la data';
    }
  }
}
