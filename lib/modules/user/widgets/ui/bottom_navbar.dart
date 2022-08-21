import 'package:court_finder/modules/user/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: uiProvider.currentIndexPage,
      onTap: (value) {
        Navigator.of(context).popUntil((route) => route.isFirst);
        uiProvider.currentIndexPage = value;
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.houseChimney), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.futbol), label: 'Historial'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoritos'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Perfil')
      ],
    );
  }
}
