import 'package:court_finder/modules/auth/services/services.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';
import 'package:court_finder/theme/my_theme.dart';
import 'package:court_finder/modules/user/providers/providers.dart';
import 'package:court_finder/modules/user/screens/screens.dart';
import 'package:court_finder/modules/auth/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset('app_settings');
  runApp(const MyApp());
}

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
        ChangeNotifierProvider(
          create: (_) => CourtProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => BookingProvider(),
        ),
        ChangeNotifierProvider(create: (_) => AuthService())
      ],
      child: MaterialApp(
        title: 'Court Finder App',
        debugShowCheckedModeBanner: false,
        theme: myTheme,
        initialRoute: 'checking',
        routes: {
          'home': (_) => const HomeScreen(),
          'search': (_) => const SearchScreen(),
          'court': (_) => const CourtScreen(),
          'confirm_booking': (_) => const ConfirmationBookingScreen(),
          'comments': (_) => const CommentsScreen(),

          //Auth
          'login': (_) => const LoginScreen(),
          'register': (_) => const RegisterScreen(),
          'checking': (_) => const CheckAuthScreen(),
        },
      ),
    );
  }
}
