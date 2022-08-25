import 'package:court_finder/modules/admin/screens/screens.dart';
import 'package:court_finder/modules/auth/services/services.dart';
import 'package:court_finder/services/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:court_finder/theme/my_theme.dart';
import 'package:court_finder/modules/user/providers/providers.dart';
import 'package:court_finder/modules/user/screens/screens.dart';
import 'package:court_finder/modules/auth/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UIProvider()),
        ChangeNotifierProvider(create: (_) => PickerSlotProvider()),
        ChangeNotifierProvider(create: (_) => CourtProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => CategoryService()),
        ChangeNotifierProvider(create: (_) => CourtService()),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('es', ''), // Spanish, no country code
        ],
        title: 'Court Finder App',
        debugShowCheckedModeBanner: false,
        theme: myTheme,
        initialRoute: 'checking',
        scaffoldMessengerKey: NotificationService.messengerKey,
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

          //Admin
          'dashboard': (_) => const DashboardScreen(),
          'my_pitches': (_) => const MyPitchesScreen(),
          'court_profile': (_) => const CourtProfileScreen(),
          'historial': (_) => const BookingHistoryScreen(),
        },
      ),
    );
  }
}
