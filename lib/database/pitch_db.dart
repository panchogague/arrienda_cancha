import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:court_finder/models/models.dart';

class PitchDB {
  final _db = FirebaseFirestore.instance;

  Future<String?> savePitch(String courtId, PitchModel pitch) async {
    try {
      await _db
          .collection('courts')
          .doc(courtId)
          .collection('pitches')
          .doc()
          .set(pitch.toMap());
      return null;
    } catch (e) {
      print(e);
      return 'Error al guardar la data';
    }
  }
}
