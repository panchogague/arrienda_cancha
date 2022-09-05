import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:court_finder/models/models.dart';

class UserDB {
  final _db = FirebaseFirestore.instance;

  Future<String?> createUserCollection(UserModel user, String userId) async {
    try {
      await _db.collection('users').doc(userId).set(user.toMap());
      return null;
    } catch (error) {
      return 'Algo salió mal al crear el usuario';
    }
  }

  Future<UserModel?> loadUserData(String userId) async {
    UserModel? userLogin;
    try {
      final userDB = await _db.collection('users').doc(userId).get();
      userLogin = UserModel.fromFireBase(userDB.data()!, userDB.id);

      if (userLogin.isAdmin) {
        //TODO:cargar la info del recinto y las canchas
        //TODO:mover la db a archivos
        final courts = await _db
            .collection('courts')
            .where('userId', isEqualTo: userId)
            .get();
        //Por ahora vamos a trabajar 1 usuario 1 recinto, pero queda abierto para agregar mas recintos por usuario
        for (var element in courts.docs) {
          final data = element.data();
          userLogin.adminCourts.add(CourtModel.fromFireBase(data, element.id));
        }
      }
    } catch (error) {
      print(error);
    }
    return userLogin;
  }
}