import 'package:flutter/material.dart';


class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
      body: Container(
        decoration: const BoxDecoration(
          image:  DecorationImage(image: AssetImage('assets/images/dna.png'))
        ),
        height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,),

    );
    
  }
}