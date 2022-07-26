import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pharma_trax_scanner/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signinpage extends StatefulWidget {
  const Signinpage({Key? key}) : super(key: key);

  static const routeName = '/signin_page';

  @override
  State<Signinpage> createState() => _SigninpageState();
}

class _SigninpageState extends State<Signinpage> {
  TextEditingController emailcontroller = TextEditingController();
  SharedPreferences? prefs;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    showLoading(
        {String title =
            "Please wait while we are initializing \nsettings for you..."}) {
      Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 25),
            child: Row(
              children: [
                
                CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.blue,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  title,
                ),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );
    }

    hideLoading() {
      Get.back();
    }

    Future loginProcess() async {
      showLoading();

      if (!await InternetConnectionChecker().hasConnection) {
        Fluttertoast.showToast(
          msg: 'Internet Error',
        );
        Loader.hide();
      } else {
        await auth.login(emailcontroller.text);

        try {
          await auth.login(emailcontroller.text);
          Navigator.of(context).pushReplacementNamed('/home_screen');
          Loader.hide();
        } catch (e) {
          Loader.hide();
          Fluttertoast.showToast(msg: 'Something went wrong');
        }
      }
    }

    void loginUserWithEmail() async {
      await loginProcess();
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/dna.png'),
              ),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              height: MediaQuery.of(context).size.width - 80,
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color: const Color.fromARGB(255, 247, 248, 248)),
                borderRadius: BorderRadius.circular(15),
                // ignore: prefer_const_literals_to_create _immutables
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  const BoxShadow(
                      color: Colors.black,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 10.0,
                      spreadRadius: 2.0),
                  const BoxShadow(color: Colors.white)
                ],
              ),
              child: Stack(
                children: [
                  Column(
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF4A90CC),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Image.asset('assets/images/email.png',
                                  height: 50),
                            ),
                            const SizedBox(height: 10),
                            const Center(
                              child: Text('Provide Your Email',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: 320,
                        padding: const EdgeInsets.only(
                            top: 5, left: 10.0, right: 10.0),
                        child: Column(
                          children: [
                            Text(
                              "Please provide your Email address. We dont share your email address with others.",
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.inter(
                                  color: textColor,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              autocorrect: true,
                              controller: emailcontroller,
                              decoration: const InputDecoration(
                                hintText: 'Enter Your Email Here...',
                                prefixIcon: Icon(Icons.email),
                                hintStyle: TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.white70,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 2),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextButton(
                              style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(
                                      Color(0xFF4A90CC))),
                              onPressed: () {
                                loginUserWithEmail();
                              },
                              child: const Text('Login'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
