import 'package:court_finder/database/user_db.dart';
import 'package:court_finder/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var userLogin = Rx<UserModel?>(null);

  AuthController() {
    auth.authStateChanges().listen((User? user) async {
      if (user != null && userLogin.value == null) {
        await loadUserData(user.uid);
      }
    });
  }

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
    userLogin.value = await UserDB().loadUserData(userId);
  }

  Future<String?> login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      await loadUserData(userCredential.user!.uid);
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
    if (auth.currentUser != null) {
      var token = await auth.currentUser!.getIdTokenResult(true);
      await loadUserData(auth.currentUser!.uid);
      return token.token!;
    }
    return '';
  }
}
