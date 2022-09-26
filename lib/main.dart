import 'package:court_finder/modules/admin/providers/providers.dart';
import 'package:court_finder/modules/admin/screens/screens.dart';
import 'package:court_finder/modules/auth/controllers/controllers.dart';
import 'package:court_finder/modules/auth/services/services.dart';
import 'package:court_finder/services/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
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
    Get.put(AuthController());
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PickerSlotProvider()),
        ChangeNotifierProvider(create: (_) => CourtProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => CategoryService()),

        ChangeNotifierProxyProvider<AuthService, CourtService>(
          create: (context) => CourtService(null),
          update: (context, auth, court) => CourtService(null),
        ),

        ChangeNotifierProxyProvider<CourtService, PitchService>(
          create: (context) => PitchService([]),
          update: (context, court, pitch) =>
              PitchService(court.court != null ? court.court!.pitches : []),
        ),

        ChangeNotifierProxyProvider<AuthService, BookingService>(
          create: (context) => BookingService(null),
          update: (context, auth, booking) =>
              BookingService(auth.userLogin!.userId),
        ),

        //Admin
        ChangeNotifierProxyProvider<CategoryService, PitchesFormProvider>(
          create: (context) => PitchesFormProvider([]),
          update: (context, cat, pitch) => PitchesFormProvider(cat.categories),
        ),

        ChangeNotifierProxyProvider<PitchesFormProvider, DynamicPriceProvider>(
          create: (context) => DynamicPriceProvider(null),
          update: (context, form, price) => DynamicPriceProvider(form.pitch),
        ),

        // ChangeNotifierProvider(create: (_) => PitchesFormProvider())
      ],
      child: GetMaterialApp(
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
        getPages: [
          GetPage(name: '/search', page: () => const SearchScreen()),
          GetPage(name: '/dashboard', page: () => const DashboardScreen()),
          GetPage(name: '/home', page: () => const HomeScreen()),
          GetPage(name: '/checking', page: () => const CheckAuthScreen()),
        ],
      ),
    );
  }
}
