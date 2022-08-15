import 'package:flutter/material.dart';
import 'package:court_finder/theme/myTheme.dart';
import 'package:court_finder/modules/user/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: myTheme,
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomeScreen(),
        'search': (_) => const HomeScreen(),
        'pitch': (_) => const PitchScreen(),
      },
    );
  }
}
