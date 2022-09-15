import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:court_finder/models/models.dart';

class PitchDB {
  final _db = FirebaseFirestore.instance;

  Future<String?> createOrUpdatePitch(String courtId, PitchModel pitch) async {
    try {
      if (pitch.id != null) {
        final pitchDB = _db
            .collection('courts')
            .doc(courtId)
            .collection('pitches')
            .doc(pitch.id);
        await pitchDB.update(pitch.toMap());
      } else {
        final ref =
            _db.collection('courts').doc(courtId).collection('pitches').doc();
        await ref.set(pitch.toMap());
        pitch.id = ref.id;
      }
      return null;
    } catch (e) {
      print(e);
      return 'Error al guardar la data';
    }
  }

  Future<List<PitchModel>> getPichesByCourtIdAndCategoryId(
      String courtId, String categoryId) async {
    try {
      final pitchesDB = await _db
          .collection('courts')
          .doc(courtId)
          .collection('pitches')
          .where('categoryId', isEqualTo: categoryId)
          .get();
      return pitchesDB.docs
          .map((e) => PitchModel.fromFireBase(e.data(), e.id))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<String?> deletePitch(String courtId, String id) async {
    try {
      await _db
          .collection('courts')
          .doc(courtId)
          .collection('pitches')
          .doc(id)
          .delete();
    } catch (e) {
      print(e);
      return 'Error al borrar registro';
    }
    return null;
  }
}
