import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pharma_trax_scanner/screens/home_screen.dart';
import 'package:pharma_trax_scanner/screens/signinpage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {



SharedPreferences? prefs;

bool? isLoginvalid=false;


@override
  void initState() {
 
 getSharePrefenceValue();


 Timer(Duration(seconds: 5),
          (){

            if(isLoginvalid==true){
               Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder:
                                                          (context) => 
                                                          HomePage()
                                                         ));


            }else{

              Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder:
                                                          (context) => 
                                                          Signinpage()
                                                         ));
            }

          }
                                       
         );


    super.initState();
  }
  getSharePrefenceValue()async{
    
 prefs = await SharedPreferences.getInstance();

 isLoginvalid = prefs!.getBool('isLogin');
  }


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