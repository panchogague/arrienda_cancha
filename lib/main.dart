import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:court_finder/theme/my_theme.dart';
import 'package:court_finder/modules/user/screens/screens.dart';
import 'package:court_finder/modules/user/providers/providers.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UIProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PickerSlotProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Court Finder App',
        debugShowCheckedModeBanner: false,
        theme: myTheme,
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomeScreen(),
          'search': (_) => const SearchScreen(),
          'court': (_) => const CourtScreen(),
        },
      ),
    );
  }
}
