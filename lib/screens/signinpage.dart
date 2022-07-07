import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pharma_trax_scanner/Widgets/db_helper.dart';
import 'package:pharma_trax_scanner/screens/home_screen.dart';
import 'package:pharma_trax_scanner/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signinpage extends StatefulWidget {
  const Signinpage({Key? key}) : super(key: key);

  @override
  State<Signinpage> createState() => _SigninpageState();
}

class _SigninpageState extends State<Signinpage> {
  TextEditingController emailcontroller = TextEditingController();
  SharedPreferences? prefs;

  // ignore: non_constant_identifier_names
  Future LoginUserWithEmail(String getemail) async {
    Loader.show(
      context,
      isSafeAreaOverlay: true,
      isBottomBarOverlay: true,
      overlayFromBottom: 80,
      overlayColor: Colors.black26,
      progressIndicator: const CircularProgressIndicator(
        backgroundColor: Colors.white,
      ),
    );

    if (!await InternetConnectionChecker().hasConnection) {
      Fluttertoast.showToast(
        msg: 'No Internet',
      );
      Loader.hide();
    } else {
      Loader.hide();

      var provinceBodyPayment = jsonEncode(<String, String>{
        'Email': getemail,
        'Password': 'P@ssw0rd',
        'ConfirmPassword': 'P@ssw0rd',
      });

      log(provinceBodyPayment);

      try {
        http.Response response = await http.post(
            Uri.parse(
              'http://api.pharmasync.pk/api/account/register',
            ),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: provinceBodyPayment);

        if (response.statusCode == 200) {
          Map getResponseData = jsonDecode(response.body);
          int seconds = getResponseData["expires_in"];
          String getToken = getResponseData['access_token'];

          GetAllDataApiCall(getemail, getToken);

          SavePrefValue(getToken, seconds);

          // print(seconds);
          // log(getResponseData.toString());
        } else {
          log("Response not 200");
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }

  //  SHARED PREFERENCES from API 1( Token & Second )
  // ignore: non_constant_identifier_names
  SavePrefValue(String tioken, int second) async {
    prefs = await SharedPreferences.getInstance();

    prefs!.setString('token', tioken);
    prefs!.setString('seconds', second.toString());

    Fluttertoast.showToast(msg: second.toString());
  }

  // API for Data calling
  // ignore: non_constant_identifier_names
  GetAllDataApiCall(String email, String token) async {
    if (!await InternetConnectionChecker().hasConnection) {
      Fluttertoast.showToast(
        msg: 'No Internet',
      );
      Loader.hide();
    } else {
      Loader.hide();

      // log(email.toString());

      try {
        http.Response response = await http.get(
          Uri.parse('http://api.pharmasync.pk/api/gtin'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          Map getApiData = jsonDecode(response.body);

          log(getApiData['Info'].toString());
          insertDbInfo(getApiData['Info']);
          log(getApiData['Companies'].toString());
          for (int i = 0; i < getApiData['Companies'].length; i++) {
            insertDbData(getApiData['Companies'][i]);
          }
          Navigator.of(context).pushReplacementNamed(HomePage.routeName);
        }
      } catch (e) {
        e.toString();
      }
    }
  }

  final dbhelper = DataBaseHelper.instance;

  void insertDbInfo(Map<String, dynamic> dbInfo) async {
    Map<String, dynamic> row = {
      DataBaseHelper.infoTableColumnVersion: dbInfo['Version'].toString(),
      DataBaseHelper.infoTableColumnUpdateDate: dbInfo['UpdateDate'].toString(),
      DataBaseHelper.infoTableColumnMessage: dbInfo['Message'].toString(),
      DataBaseHelper.infoTableColumnStatus: dbInfo['Status'].toString()
    };
    final id = await dbhelper.insertInfoTable(row);
    print("----------------------------");
    print(id);
    print(row);
    print("----------------------------");
  }

  void insertDbData(Map<String, dynamic> dbData) async {
    Map<String, dynamic> row = {
      DataBaseHelper.table1ColumnId: dbData['Id'].toString(),
      DataBaseHelper.table1ColumnPlain1: dbData['Pline1'].toString(),
      DataBaseHelper.table1ColumnCline3: dbData['Cline3'].toString(),
      DataBaseHelper.table1ColumnSline4: dbData['Sline4'].toString(),
      DataBaseHelper.table1ColumnVersion: dbData['Version'].toString(),
      DataBaseHelper.table1ColumnIsModified: dbData['IsModified'].toString()
    };
    final id = await dbhelper.insertTable1(row);
    print("----------------------------");
    print(id);
    print(row);
    print("----------------------------");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/dna.png'))),
        child: Center(
          child: Container(
            width: 350,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: const Color.fromARGB(255, 247, 248, 248),
                width: 0,
              ),
              borderRadius: BorderRadius.circular(15),
              // ignore: prefer_const_literals_to_create _immutables
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: [
                const BoxShadow(
                  color: Colors.black,
                  offset: Offset(
                    2.0,
                    2.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ),
                const BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ),
              ],
            ),
            child: Column(children: <Widget>[
              Container(
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(width: 0.4, color: Colors.grey),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomRight: Radius.zero,
                      bottomLeft: Radius.zero),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Image.asset(
                          'assets/images/email.png',
                          height: 50,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Provide Your Email',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Text(
                        "Please provide your Email address. We dont share your email address with others.",
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.inter(
                            color: textColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                    ),
                    Container(
                      width: 320,
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
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
                                    BorderRadius.all(Radius.circular(12.0)),
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
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: FlatButton(
                              child: const Text('Login'),
                              onPressed: () {
                                LoginUserWithEmail(emailcontroller.text);

                                // Navigator.of(context)
                                //     .pushReplacementNamed(HomePage.routeName);
                                // Fluttertoast.showToast(
                                //     msg: emailcontroller.text);
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
