import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharma_trax_scanner/screens/home_screen.dart';



void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp( const MyApp(),
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
      routes: {
        // LineEquipment.routeName:(context) =>const LineEquipment()
      },
      
    );
  }
}
