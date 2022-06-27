import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            home: HomeScreen(),
          );
        });
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(child: Row(
        children: [
          Container(
            color: Colors.red,
            width: MediaQuery.of(context).size.width*0.5.w,
               height: MediaQuery.of(context).size.height.h,

          ),
          Container(
            color: Colors.blue,
            width: MediaQuery.of(context).size.width*0.5.w,
               height: MediaQuery.of(context).size.height.h,

          ),
        ],
      )),
    );
  }
}