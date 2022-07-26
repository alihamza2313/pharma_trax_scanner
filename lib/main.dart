import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pharma_trax_scanner/Widgets/about_pharma.dart';
import 'package:pharma_trax_scanner/providers/auth_provider.dart';
import 'package:pharma_trax_scanner/screens/home_screen.dart';
import 'package:pharma_trax_scanner/Widgets/line_level_hardware.dart';
import 'package:pharma_trax_scanner/Widgets/how_it_works.dart';
import 'package:pharma_trax_scanner/Widgets/line_equipment.dart';
import 'package:pharma_trax_scanner/screens/scan_history.dart';
import 'package:pharma_trax_scanner/screens/signinpage.dart';
import 'package:pharma_trax_scanner/screens/splash_screen.dart';
import 'package:pharma_trax_scanner/screens/update_database.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
      ],
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // home: Signinpage.isAuth ? const HomePage(): const Signinpage(),
          home: const SplashScreenPage(),
          //this is routes
          routes: {
            '/signin_page': (ctx) => const Signinpage(),
            '/home_screen': (ctx) => const HomePage(),
            '/scan_history': (ctx) => const ScanHistory(),
            '/update_database': (ctx) => const UpdateDatabase(),
            '/line_level_hardware': (ctx) => const LineLevelHardware(),
            '/line_equipment': (ctx) => const Line_equipment(),
            '/how_it_works': (ctx) => const How_it_works(),
            '/About-pharma': (context) => About_pharma()
          }),
    );
  }
}
