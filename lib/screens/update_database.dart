import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pharma_trax_scanner/Widgets/app_drawer.dart';
import 'package:pharma_trax_scanner/Widgets/db_helper.dart';
import 'package:pharma_trax_scanner/providers/auth_provider.dart';
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
  List<Map<String, dynamic>> data = [];
  String version = '';
  String updatedDate = '';

  Future<void> fatchData() async {
    data = await dbhelper.fatchInfoTable();
    version = data[0]['version'];
    updatedDate = data[0]['update_date'];
    setState(() {});
  }

  @override
  void initState() {
    fatchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final auth = Provider.of<AuthProvider>(context);

    updateDatabase() async {
      data = await dbhelper.fatchInfoTable();
      bool _check = double.parse(version) < double.parse(data[0]['version']);
      print("----------------------------");
      print(_check);
      print("----------------------------");
      if (_check) {
        if (!await InternetConnectionChecker().hasConnection) {
          Fluttertoast.showToast(
            msg: 'No Internet',
          );
          Loader.hide();
        } else {
          Loader.hide();

          final prefs = await SharedPreferences.getInstance();
          if (!prefs.containsKey('userData')) {
            return false;
          }
          final extractedUserData =
              json.decode(prefs.getString('userData').toString())
                  as Map<String, dynamic>;
          await auth.apiResponse(extractedUserData['provinceBodyPayment'],
              extractedUserData['userId']);
          fatchData();
        }
      } else {
        Fluttertoast.showToast(msg: 'Already Updated to latest version');
      }
    }

    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Update Database"),
      ),
      body: SizedBox(
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
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45),
                        children: <InlineSpan>[
                          TextSpan(
                            text: version,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: 'Updated At: ',
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45),
                        children: <InlineSpan>[
                          TextSpan(
                            text: updatedDate,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: _width * 0.8,
                child: ElevatedButton(
                  onPressed: updateDatabase,
                  // style: ButtonStyle(
                  //   backgroundColor: Co
                  // ),
                  child: const Text('UPDATE DATABASE'),
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
