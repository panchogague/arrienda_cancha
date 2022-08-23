import 'package:court_finder/modules/auth/services/auth_services.dart';
import 'package:court_finder/modules/user/providers/providers.dart';
import 'package:court_finder/modules/user/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);

    final size = MediaQuery.of(context).size;
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
              painter: _HeaderDiagonalPainter(),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: size.height * 0.9,
                child: ListView(padding: EdgeInsets.zero, children: [
                  const _DrawerHeader(),
                  SizedBox(height: size.height * 0.06),
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
                    onTap: () => uiProvider.currentIndexPage = 1,
                  ),
                  const Divider(),
                  ListTile(
                    leading:
                        const Icon(CupertinoIcons.heart_fill, color: iconColor),
                    title: Text(
                      'Favoritos',
                      style: style,
                    ),
                    onTap: () => uiProvider.currentIndexPage = 2,
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
                  Provider.of<AuthService>(context, listen: false).logout();
                  Navigator.pushReplacementNamed(context, 'login');
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

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      height: 200,
      child: Row(
        children: [
          const UserAvatar(
            width: 65,
            height: 65,
            showShadow: false,
            imgUrl:
                'https://www.eaglesvine.com/wp-content/uploads/2021/06/Gabbie-Carter_05.jpg',
          ),
          const SizedBox(width: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                authService.userLogin!.firstName,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              const SizedBox(height: 10),
              Text(
                authService.userLogin!.email,
                style: const TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _HeaderDiagonalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    //Properties
    paint.color = Color(0xffF34F57);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2;

    //Draw
    final path = Path();
    path.moveTo(0, size.height * 0.35);
    path.lineTo(size.width, size.height * 0.30);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
