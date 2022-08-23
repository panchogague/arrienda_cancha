import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:court_finder/models/models.dart';

class AuthService extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  UserModel? userLogin;

  //final storage = const FlutterSecureStorage();

  Future<String?> createUser(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await createUserCollection(
          UserModel(
            firstName: 'Nombre',
            lastName: 'Apellido',
            email: email,
          ),
          userCredential.user!.uid);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return 'Algo salio mal';
    }
    return null;
  }

  Future createUserCollection(UserModel user, String userId) async {
    await _db.collection('users').doc(userId).set(user.toMap());
  }

  Future loadUserData(String userId) async {
    final userDB = await _db.collection('users').doc(userId).get();

    userLogin = UserModel.fromFireBase(userDB.data()!, userDB.id);
  }

  Future<String?> login(String email, String password) async {
    //TODO: Mock login remover esto
    userLogin = UserModel(
        email: 'test@test.com',
        firstName: 'test',
        lastName: 'lasttest',
        userId: 'WnKjzpSNtAeaXmcNJ56YHVmL6S12',
        isAdmin: false);
    return '';

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      await loadUserData(userCredential.user!.uid);

      //TODO:guardar token?
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
    return null;
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<String> readToken() async {
    userLogin = UserModel(
        email: 'test@test.com',
        firstName: 'test',
        lastName: 'lasttest',
        userId: 'WnKjzpSNtAeaXmcNJ56YHVmL6S12',
        isAdmin: false);
    return 'asasdasd';

    if (auth.currentUser != null) {
      var token = await auth.currentUser!.getIdTokenResult(true);
      await loadUserData(auth.currentUser!.uid);
      return token.token!;
    }
    return '';
  }
}
