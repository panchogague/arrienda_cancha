import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:court_finder/modules/auth/controllers/controllers.dart';
import 'package:court_finder/modules/user/controllers/controllers.dart';
import 'package:court_finder/widgets/widgets.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiCtrl = Get.find<UIController>();
    const iconColor = Colors.blueGrey;
    TextStyle? style = Theme.of(context).textTheme.headline2;
    return Drawer(
      backgroundColor: Colors.white,
      child: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: CustomPaint(
              painter: HeaderDiagonalPainter(),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: Get.height * 0.9,
                child: ListView(padding: EdgeInsets.zero, children: [
                  const CustomDrawerHeader(),
                  SizedBox(height: Get.height * 0.06),
                  ListTile(
                    leading: const Icon(
                      Icons.person,
                      color: iconColor,
                    ),
                    title: Text(
                      'Mi Perfil',
                      style: style,
                    ),
                    onTap: () {},
                  ),
                  const Divider(),
                  ListTile(
                    leading:
                        const Icon(FontAwesomeIcons.futbol, color: iconColor),
                    title: Text(
                      'Mis Reservas',
                      style: style,
                    ),
                    onTap: () => uiCtrl.currentIndexPage.value = 1,
                  ),
                  const Divider(),
                  ListTile(
                    leading:
                        const Icon(CupertinoIcons.heart_fill, color: iconColor),
                    title: Text(
                      'Favoritos',
                      style: style,
                    ),
                    onTap: () => uiCtrl.currentIndexPage.value = 2,
                  ),
                  const Divider(),
                  ListTile(
                    leading:
                        const Icon(Icons.settings_outlined, color: iconColor),
                    title: Text(
                      'Settings',
                      style: style,
                    ),
                    onTap: () {},
                  ),
                ]),
              ),
              const Spacer(),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: iconColor,
                ),
                title: Text(
                  'Logout',
                  style: style,
                ),
                onTap: () {
                  final authCtrl = Get.find<AuthController>();
                  authCtrl.logout();
                  Get.offAllNamed('/login');
                },
              ),
              const SizedBox(
                height: 15,
              )
            ],
          ),
        ],
      ),
    );
  }
}
