import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:court_finder/modules/user/controllers/controllers.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiCtrl = Get.find<UIController>();

    return Obx(() => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: uiCtrl.currentIndexPage.value,
          onTap: (value) {
            Navigator.of(context).popUntil((route) => route.isFirst);
            uiCtrl.currentIndexPage.value = value;
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.houseChimney), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.futbol), label: 'Historial'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favoritos'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: 'Perfil')
          ],
        ));
  }
}
