import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:pharma_trax_scanner/Widgets/app_drawer.dart';
import 'package:pharma_trax_scanner/Widgets/db_helper.dart';
import 'package:pharma_trax_scanner/providers/auth_provider.dart';
import 'package:pharma_trax_scanner/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateDatabase extends StatefulWidget {
  const UpdateDatabase({Key? key}) : super(key: key);

  static const routeName = '/update_database';

  @override
  State<UpdateDatabase> createState() => _UpdateDatabaseState();
}

class _UpdateDatabaseState extends State<UpdateDatabase> {
  final dbhelper = DataBaseHelper.instance;
  List<Map<String, dynamic>>? data = [];
  String? version;
  DateTime? updatedDate;
  String? formattedDate;



  @override
  void initState() {
    fatchData();
    super.initState();
  }

     fatchData() async {
    data=[];
    data = await dbhelper.fatchInfoTable();
 
       version =  data![0]['version'];
    updatedDate =  DateTime.parse(data![0]['update_date']);
    formattedDate = DateFormat('yyyy-MM-dd hh:mm').format(updatedDate!);
  log(data.toString());
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final auth = Provider.of<AuthProvider>(context);

    showLoading({String title = "Updating Database.."}) {
      Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(

            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 25),
            child: Row(
              children: [
                
                CircularProgressIndicator(
                
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

    updateDatabase() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? geEmail = prefs.getString('email');
      String? gettoken = prefs.getString('istoken');

      showLoading();

      if (!await InternetConnectionChecker().hasConnection) {
        Fluttertoast.showToast(
          msg: 'No Internet',
        );
        hideLoading();
      } else {
         log(data.toString());
          await auth.getUpdateApiCall(geEmail!, gettoken!);
          
          hideLoading();
         Timer(Duration(seconds: 1),
          ()async{
            fatchData();
            //    //data =[];
            // List<Map<String,dynamic>> data2 = await dbhelper.fatchInfoTable();
            // log(data2.toString());

          });
            

        // setState(() {
        //   fatchData();
        // });
          
 
          
        
      }
    }

    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: colorPrimaryLightBlue,
        title: const Text(
          "Update Database",
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/dna.png'))),
        width: _width,
        height: _height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Database Information',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                    const SizedBox(height: 20),
                    Text.rich(
                      TextSpan(
                        text: 'Database Version: ',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                        children: <InlineSpan>[
                        version == null ? TextSpan():  TextSpan(
                            text: version,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: colorPrimaryLightBlue),
                          )
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: 'Updated At: ',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                        children: <InlineSpan>[
                          TextSpan(
                            text: formattedDate.toString(),
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: colorPrimaryLightBlue),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                width: _width * 0.8,
                height: 60,
                child: MaterialButton(
                  color: colorPrimaryLightBlue,
                  onPressed: updateDatabase,
                  // style: ButtonStyle(
                  //   backgroundColor: Co
                  // ),
                  child: const Text(
                    'UPDATE DATABASE',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}

mixin Auth {}
