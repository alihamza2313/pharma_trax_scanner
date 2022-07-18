import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharma_trax_scanner/screens/barcode_scanner.dart';
import 'package:pharma_trax_scanner/screens/data_matrix_scanner.dart';
import 'package:pharma_trax_scanner/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Widgets/app_drawer.dart';

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


@override
  void initState() {

   // list = [1,2,3]; 
  SaveValueInPrefecnce();
    super.initState();
  }
  SaveValueInPrefecnce()async{
    
 prefs = await SharedPreferences.getInstance();
 prefs!.setBool('isLogin', true);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: const AppDrawer(),
      drawerEnableOpenDragGesture: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.share,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: blueColor1,
        leading: Builder(
          builder: (context) => // Ensure Scaffold is in context
              IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer()),
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
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child:
                                  Image.asset('assets/images/pharmatrax.png'),
                            ),
                            Text(
                              "Pakistan's first Track and Trace Serialization Solution Complete End to End Turnkey Solution Market Leader in Track and Trace Solutions",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                color: textColor,
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),



          // Row(children: list.map((item)  {

            
          //         if (item == 1) {
          //           return Text(
          //             item.toString(),
          //             style: TextStyle(
          //               fontWeight: FontWeight.bold,
          //             ),
          //           );
          //         }else{
          //           return Text(item.toString());
          //         }
          //         // if (item < 100) {
          //         //   return Padding(
          //         //     padding: const EdgeInsets.all(8.0),
          //         //     child: Text(
          //         //       item.toString(),
          //         //       style: const TextStyle(
          //         //         fontWeight: FontWeight.bold,
          //         //         color: Colors.red,
          //         //       ),
          //         //     ),
          //         //   );
          //         // }
          //         // if (item == 100) {
          //         //   return Padding(
          //         //     padding: const EdgeInsets.all(8.0),
          //         //     child: Text(
          //         //       item.toString(),
          //         //       style: TextStyle(
          //         //         fontWeight: FontWeight.bold,
          //         //         color: Colors.green,
          //         //       ),
          //         //     ),
          //         //   );
          //         // }
                  
          //       }).toList()),



                        

 

                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => const BarCodeScanner()));
                              },
                              child: Container(
                                color: blueColor1,
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      height: 50,
                                      width: 50,
                                      color: blueColor2,
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
                                          fontSize: 16,
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
                                color: blueColor1,
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      height: 50,
                                      width: 50,
                                      color: blueColor2,
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
                                          fontSize: 16,
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
                        fontSize: 16,
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
                              fontSize: 16,
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
                                    fontSize: 16,
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
                          fontSize: 16,
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
                          fontSize: 16,
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
                          horizontal: 100, vertical: 5),
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
