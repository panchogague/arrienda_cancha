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
        final ref = _db.collection('courts').doc();
        await ref.set(court.toMap());
        court.id = ref.id;
      }
      return null;
    } catch (e) {
      print(e);
      return 'Error al guardar la data';
    }
  }

  Future<List<CourtModel>> getCourtsByCategoryId(String categoryId) async {
    try {
      final courtsDB = await _db
          .collection('courts')
          .where('isActive', isEqualTo: true)
          .where('categories', arrayContains: categoryId)
          .get();

      return courtsDB.docs
          .map((e) => CourtModel.fromFireBase(e.data(), e.id))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
