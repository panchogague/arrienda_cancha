import 'package:court_finder/database/user_db.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:court_finder/models/models.dart';

class AuthService extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  UserModel? userLogin;

  AuthService() {
    userLogin = UserModel(
      email: 'test@test.com',
      firstName: 'test',
      lastName: 'lasttest',
      userId: 'WnKjzpSNtAeaXmcNJ56YHVmL6S12',
      isAdmin: true,
    );
    userLogin!.adminCourts.add(CourtModel(
        id: 'cRms8GVfTLOOKw5z5i7i',
        name: 'Canchas guaton linares',
        imgUrl: '',
        location: 'Calle Aranda #235',
        price: '',
        description:
            'Anim nostrud mollit laboris enim exercitation ex in excepteur sint exercitation voluptate nulla. Qui officia enim laborum cupidatat laboris Lorem nulla adipisicing. Non mollit velit consequat voluptate cillum est. Non sit esse sit voluptate sit nisi consectetur laborum pariatur elit velit laboris irure.',
        howToAccess: 'Sint et laboris occaecat cillum commodo ut. Pariatur laborum ullamco ex sit deserunt quis reprehenderit dolore amet aliqua. Aliqua est deserunt eiusmod veniam elit. Dolor deserunt sunt veniam voluptate in velit laborum enim sunt.',
        cancellationPolicy: 'Ad ea reprehenderit do velit in ut culpa labore ut irure elit eu.',
        userId: 'WnKjzpSNtAeaXmcNJ56YHVmL6S12',
        openDays: [2, 3, 4, 5, 6]));
  }

  //final storage = const FlutterSecureStorage();

  Future<String?> createUser(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await UserDB().createUserCollection(
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

  Future loadUserData(String userId) async {
    userLogin = await UserDB().loadUserData(userId);
  }

  Future<String?> login(String email, String password) async {
    //TODO: Mock login remover esto
    // return '';

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
    //return 'asasdasd';

    if (auth.currentUser != null) {
      var token = await auth.currentUser!.getIdTokenResult(true);
      await loadUserData(auth.currentUser!.uid);
      return token.token!;
    }
    return '';
  }
}
