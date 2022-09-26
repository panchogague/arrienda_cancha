import 'package:court_finder/modules/admin/screens/screens.dart';
import 'package:court_finder/modules/auth/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:court_finder/modules/auth/screens/screens.dart';
import 'package:court_finder/modules/user/screens/home_screen.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authCtrl = Get.find<AuthController>();
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authCtrl.readToken(),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) {
              return const Text('Wait ...');
            }

            if (snapshot.data == '') {
              Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const LoginScreen(),
                        transitionDuration: const Duration(seconds: 0)));
              });
            } else {
              Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) =>
                            authCtrl.userLogin.value!.isAdmin
                                ? const DashboardScreen()
                                : const HomeScreen(),
                        transitionDuration: const Duration(seconds: 0)));
              });
            }

            return Container();
          },
        ),
      ),
    );
  }
}
