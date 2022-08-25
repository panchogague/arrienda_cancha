import 'package:court_finder/modules/auth/services/services.dart';
import 'package:court_finder/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AdminMenu extends StatelessWidget {
  const AdminMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const iconColor = Colors.blueGrey;
    TextStyle? style = Theme.of(context).textTheme.bodyText1;

    return Container(
        color: Colors.white,
        width: size.width * 0.20,
        child: Stack(children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: CustomPaint(
              painter: HeaderDiagonalPainter(),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: size.height * 0.8,
                child: ListView(padding: EdgeInsets.zero, children: [
                  const CustomDrawerHeader(),
                  SizedBox(height: size.height * 0.10),
                  ListTile(
                    leading: const Icon(
                      FontAwesomeIcons.house,
                      color: iconColor,
                    ),
                    title: Text(
                      'Home',
                      style: style,
                    ),
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, 'dashboard'),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(
                      FontAwesomeIcons.addressCard,
                      color: iconColor,
                    ),
                    title: Text(
                      'Perfil Recinto',
                      style: style,
                    ),
                    onTap: () => Navigator.pushReplacementNamed(
                        context, 'court_profile'),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.layers, color: iconColor),
                    title: Text(
                      'Mis Canchas',
                      style: style,
                    ),
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, 'my_pitches'),
                  ),
                  const Divider(),
                  ListTile(
                    leading:
                        const Icon(FontAwesomeIcons.folder, color: iconColor),
                    title: Text(
                      'Historial Reservas',
                      style: style,
                    ),
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, 'historial'),
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
        ]));
  }
}
