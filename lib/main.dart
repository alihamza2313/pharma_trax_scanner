import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharma_trax_scanner/screens/home_screen.dart';
import 'package:pharma_trax_scanner/screens/splash_screen.dart';

void main() {
  runApp(DevicePreview(
      builder: (context) => MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
             locale: DevicePreview.locale(context),// Add locale
      builder: DevicePreview.appBuilder, 
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: HomePage(),
          );
        });
  }
}

