import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pharma_trax_scanner/screens/barcode_scanner.dart';
import 'package:pharma_trax_scanner/screens/data_matrix_scanner.dart';
import 'package:pharma_trax_scanner/screens/qr_result.dart';
import 'package:pharma_trax_scanner/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Widgets/app_drawer.dart';

import 'dart:async';
import 'dart:developer';
import 'dart:io' show Platform;

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home_screen';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  SharedPreferences? prefs;

//List list = [];

//List list = [];

  @override
  void initState() {
    getSharePrefenceValue();

    // SaveValueInPrefecnce();
    super.initState();
  }

  getSharePrefenceValue() async {
    prefs = await SharedPreferences.getInstance();
    int? getExpireSecond = prefs!.getInt('isexpireSecond');
    String? getexpiryDate = prefs!.getString('iscurentTime');

    log(getexpiryDate.toString());

    DateTime? now = DateTime.now();
    final getdiffernce = now.difference(DateTime.parse(getexpiryDate!));

    log(getdiffernce.inSeconds.toString());

    if (getdiffernce.inSeconds >= getExpireSecond!) {
      LogoutFunction();
    }
  }

  LogoutFunction() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', false);
    prefs.setString('istoken', '');
    prefs.setString('isexpire', '');
    prefs.setString('iscurentTime', '');
    prefs.setString('email', '');
    prefs.setString('isexpireSecond', '');

    Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed('/signin_page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: const AppDrawer(),
      drawerEnableOpenDragGesture: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorPrimaryLightBlue,
        onPressed: () {},
        child: const Icon(
          Icons.share,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: colorPrimaryLightBlue,
        leading: Builder(
          builder: (context) => // Ensure Scaffold is in context
              IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  }),
        ),
        title: const Text("Pharma Trax Scanner"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/dna.png'))),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35),
                              child:
                                  Image.asset('assets/images/pharmatrax.png'),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Pakistan's first Track and Trace Serialization Solution Complete End to End Turnkey Solution Market Leader in Track and Trace Solutions",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  color: textColor,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const BarCodeScanner()));
                              },
                              child: Container(
                                color: colorPrimaryLightBlue,
                                width: MediaQuery.of(context).size.width * 0.7 -
                                    20,
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      height: 50,
                                      width: 50,
                                      color: colorPrimaryLightDark,
                                      child: Image.asset(
                                          'assets/images/code_128.png'),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "SCAN GS1 128 BARCODE",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => const DataMatrixSacnner()));
                              },
                              child: Container(
                                color: colorPrimaryLightBlue,
                                width: MediaQuery.of(context).size.width * 0.7 -
                                    20,
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      height: 50,
                                      width: 50,
                                      color: colorPrimaryLightDark,
                                      child: Image.asset(
                                          'assets/images/data_matrix.png'),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "SCAN GS1 DATA MATRIX",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                // height: 140.h,
                padding: const EdgeInsets.symmetric(vertical: 10),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "PHARMA TRAX",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        color: textColor,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Contact us:",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              color: textColor,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                  text: "CONTACT@PHARMATRAX.PK",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    color: blueColor1,
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      // ignore: deprecated_member_use
                                      await launch(
                                          "mailto:CONTACT@PHARMATRAX.PK?");
                                    }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "WWW.PHARMATRAX.PK",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          color: blueColor1,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            const url = "https://WWW.PHARMATRAX.PK";
                            // ignore: deprecated_member_use
                            if (!await canLaunch(url)) {
                              // ignore: deprecated_member_use
                              await launch(url);
                            } else {
                              throw "Connot Load Url ";
                            }
                          },
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "WWW.ZAUQ.COM",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          color: blueColor1,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            const url = "https://WWW.ZAUQ.COM";
                            // ignore: deprecated_member_use
                            if (!await canLaunch(url)) {
                              // ignore: deprecated_member_use
                              await launch(url);
                            } else {
                              throw "Connot Load Url ";
                            }
                          },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 130, vertical: 5),
                      // height: 120,
                      // width: 120,
                      child: Image.asset('assets/images/zauq.png'),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
