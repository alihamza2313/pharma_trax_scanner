import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharma_trax_scanner/Widgets/about_pharma.dart';
import 'package:pharma_trax_scanner/screens/home_screen.dart';
import 'package:pharma_trax_scanner/Widgets/line_level_hardware.dart';
import 'package:pharma_trax_scanner/Widgets/how_it_works.dart';
import 'package:pharma_trax_scanner/Widgets/line_equipment.dart';
import 'package:pharma_trax_scanner/screens/scan_history.dart';
import 'package:pharma_trax_scanner/screens/signinpage.dart';
import 'package:pharma_trax_scanner/screens/splash_screen.dart';

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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
        //this is routes
        routes: {
          HomePage.routeName: (ctx) => const HomePage(),
          ScanHistory.routeName: (ctx) => const ScanHistory(),
          '/line_level_hardware': (ctx) => const LineLevelHardware(),
          '/line_equipment': (ctx) => const Line_equipment(),
          '/how_it_works': (ctx) => const How_it_works(),
          '/About-pharma': (context) => const About_pharma()
        });
  }
}
