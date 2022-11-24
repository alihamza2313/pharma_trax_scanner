import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharma_trax_scanner/Widgets/db_helper.dart';
import 'package:pharma_trax_scanner/screens/barcode_scanner.dart';
import 'package:pharma_trax_scanner/screens/data_matrix_scanner.dart';
import 'package:pharma_trax_scanner/screens/signinpage.dart';
import 'package:pharma_trax_scanner/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Widgets/app_drawer.dart';
import 'dart:developer';

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

  SaveValueInPrefecnce() async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setBool('isLogin', true);
  }

  final dbhelper = DataBaseHelper.instance;

  getSharePrefenceValue() async {
    prefs = await SharedPreferences.getInstance();
    String? getExpireSecond = prefs!.getString('isexpireSecond');
    String? getexpiryDate = prefs!.getString('iscurentTime');

    log(getexpiryDate.toString());

    DateTime? now = DateTime.now();
    final getdiffernce = now.difference(DateTime.parse(getexpiryDate!));

    log(getdiffernce.inSeconds.toString());

    if (getdiffernce.inSeconds >= double.parse(getExpireSecond!)) {
      LogoutFunction();
    }
  }

  LogoutFunction() async {
    final prefs = await SharedPreferences.getInstance();
    await dbhelper.deleteTable1();
    await dbhelper.deleteTable2();
    prefs.setBool('isLogin', false);
    prefs.setString('istoken', '');
    // prefs.setString('isexpire','');
    prefs.setString('iscurentTime', '');
    prefs.setString('email', '');
    prefs.setString('isexpireSecond', '');

    // ignore: use_build_context_synchronously
    //Navigator.of(context).pop();
    // ignore: use_build_context_synchronously
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => Signinpage()));
  }

  @override
  Widget build(BuildContext context) {
   double? pixelRatio = MediaQuery.of(context).devicePixelRatio;

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _key,
      drawer: const AppDrawer(),
      drawerEnableOpenDragGesture: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorPrimaryLightBlue,
        onPressed: () {
          final box = context.findRenderObject() as RenderBox?;
          Share.share(
              "https://play.google.com/store/apps/details?id=pk.pharmatrax.pharmatraxscanner",
              sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
              );
        },
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
        height: height,
        width: width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: height * 0.06),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Image.asset('assets/images/pharmatrax.png'),
                    ),
                    Text(
                      "Pakistan's first Track and Trace Serialization Solution",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: textColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Complete End to End Turnkey Solution",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: textColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Market Leader in Track and Trace Solutions",
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
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const BarCodeScanner()));
                    },
                    child: Container(
                      color: colorPrimaryLightBlue,
                      width: MediaQuery.of(context).size.width * 0.7 - 20,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            height: 50,
                            width: 50,
                            color: colorPrimaryLightDark,
                            child: Image.asset('assets/images/code_128.png'),
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
                          builder: (_) =>  DataMatrixSacnner()));
                    },
                    child: Container(
                      color: colorPrimaryLightBlue,
                      width: MediaQuery.of(context).size.width * 0.7 - 20,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            height: 50,
                            width: 50,
                            color: colorPrimaryLightDark,
                            child: Image.asset('assets/images/data_matrix.png'),
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
                ],
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                // height: 140.h,
                padding: const EdgeInsets.symmetric(vertical: 10),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    RichText(
                      text: TextSpan(
                        text: "Contact us: ",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          color: textColor,
                          fontSize: 14,
                        ),
                        children: <TextSpan>[
                          TextSpan(
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
                                  await launch("mailto:CONTACT@PHARMATRAX.PK?");
                                }),
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
                    
                    Container(
                      height: MediaQuery.of(context).size.height*0.2-60,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 110, vertical: 5),
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
