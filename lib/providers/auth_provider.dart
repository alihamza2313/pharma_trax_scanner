import 'dart:convert';
import 'dart:async';
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:pharma_trax_scanner/Widgets/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  SharedPreferences? prefs;

  String? message;

  String? _token = '';
  DateTime? _expiryDate;
  int? _expirySecond;
  String? _userId = '';
  Timer? _authTimer;

  bool get isAuth {
    token != null;
    return true;
  }

  // hideLoading() {
  //   Get.back();
  // }

  dynamic get token {
    if (_expiryDate != 0 && _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId!;
  }

  Future<void> login(String userId) async {
    var provinceBodyPayment = jsonEncode(<String, String>{
      'Email': userId.toString(),
      'Password': 'P@ssw0rd',
      'ConfirmPassword':'P@ssw0rd',
    });
    print(provinceBodyPayment);
    try {
      await apiResponse(provinceBodyPayment, userId);
    } catch (e) {
      Fluttertoast.showToast(msg:'Something went wrong');
      print(e.toString());
    }
  }

  Future<void> apiResponse(String provinceBodyPayment, String getemail) async {
    if (!await InternetConnectionChecker().hasConnection) {
      Fluttertoast.showToast(
        msg: 'Internet Error',
      );
    } else {
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

          log(getResponseData.toString());
          _expiryDate = getResponseData["expires"];
          _expirySecond = getResponseData['expires_in'];
          _token = getResponseData['access_token'];

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLogin', true);
          await prefs.setString('istoken', _token!);
          //  prefs.setString('isexpire',_expiryDate!.toIso8601String());
          await prefs.setString('isexpireSecond', _expirySecond.toString());
          await prefs.setString(
              'iscurentTime', DateTime.now().toIso8601String());
          await prefs.setString('email', getemail);

          log(_expiryDate.toString());
          log(DateTime.now().millisecondsSinceEpoch.toInt().toString());

          getAllDataApiCall(getemail, _token!);

        } else {
          Fluttertoast.showToast(msg: 'Something went wrong');
          print("Response not 200");
        }
      } catch (e) {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    }
  }

  getAllDataApiCall(String email, String token) async {
    try {
      http.Response response = await http.get(
        Uri.parse('http://api.pharmasync.pk/api/gtin'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${token}',
        },
      );

      if (response.statusCode == 200) {
        Map getApiData = jsonDecode(response.body);

        log(getApiData.toString());

        await dbhelper.deleteTable1();

        insertDbInfo(getApiData['Info']);
        for (int i = 0; i < getApiData['Companies'].length; i++) {
          insertDbData(getApiData['Companies'][i]);
        }

        List<Map<String, dynamic>> data = await dbhelper.fatchTable1();
        log(data.toString());

        // Navigator.of(context).pushReplacementNamed(HomePage.routeName);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Something went wrong');
      e.toString();
    }
  }

  getUpdateApiCall(String email, String token) async {
    if (!await InternetConnectionChecker().hasConnection) {
      Fluttertoast.showToast(
        msg: 'No Internet',
      );
    } else {
      // log(email.toString());

      try {
        http.Response response = await http.get(
          Uri.parse('http://api.pharmasync.pk/api/gtin'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${token}',
          },
        );

        if (response.statusCode == 200) {
          Map getApiData = jsonDecode(response.body);

          //   log(getApiData.toString());

          final dbhelper = DataBaseHelper.instance;
          List<Map<String, dynamic>> data = [];
          String version = '';
          String updatedDate = '';

          data = await dbhelper.fatchInfoTable();
          version = data[0]['version'];
          updatedDate = data[0]['update_date'];

          if (data != null) {
            insertDbInfo(getApiData['Info']);

            if (double.parse(version) < getApiData['Info']['Version']) {
              await dbhelper.deleteTable1();

              // insertDbInfo(getApiData['Info']);
              for (int i = 0; i < getApiData['Companies'].length; i++) {
                insertDbData(getApiData['Companies'][i]);
              }
              List<Map<String, dynamic>> data = await dbhelper.fatchTable1();
              log(data.toString());

              Fluttertoast.showToast(msg: '${getApiData['Info']['Message']}');
            } else {
              Fluttertoast.showToast(
                  msg: 'Database Already Updated to Latest Version');
            }
          } else {
            await dbhelper.deleteTable1();
            insertDbInfo(getApiData['Info']);
            for (int i = 0; i < getApiData['Companies'].length; i++) {
              insertDbData(getApiData['Companies'][i]);
            }
            // List<Map<String, dynamic>> data = await dbhelper.fatchTable1();
            // log(data.toString());
          }

          // Navigator.of(context).pushReplacementNamed(HomePage.routeName);
        } else {
          Fluttertoast.showToast(msg: 'Something went wrong');
        }
      } catch (e) {
        Fluttertoast.showToast(msg: 'Something went wrong');
        e.toString();
      }
    }
  }

  // Insert Data in Database
  final dbhelper = DataBaseHelper.instance;
  void insertDbInfo(Map<String, dynamic> dbInfo) async {
    Map<String, dynamic> row = {
      DataBaseHelper.infoTableColumnVersion: dbInfo['Version'].toString(),
      DataBaseHelper.infoTableColumnUpdateDate:
          DateTime.now().toIso8601String(),
      DataBaseHelper.infoTableColumnMessage: dbInfo['Message'].toString(),
      DataBaseHelper.infoTableColumnStatus: dbInfo['Status'].toString()
    };
    final id = await dbhelper.insertInfoTable(row);
    // print("----------------------------");
    // print(id);
    // print(row);
    // print("----------------------------");
  }

  void insertDbData(Map<String, dynamic> dbData) async {
    Map<String, dynamic> row = {
      DataBaseHelper.table1ColumnId: dbData['Id'],
      DataBaseHelper.table1ColumnPlain1: dbData['Pline1'],
      DataBaseHelper.table1ColumnCline3: dbData['Cline3'],
      DataBaseHelper.table1ColumnSline4: dbData['Sline4'],
      DataBaseHelper.table1ColumnVersion: dbData['Version'],
      DataBaseHelper.table1ColumnIsModified: dbData['IsModified']
    };
    final id = await dbhelper.insertTable1(row);
    // print("----------------------------");
    // // print(id);
    // // print(row);
    // print("----------------------------");
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await dbhelper.deleteTable1();
    await dbhelper.deleteTable2();
    prefs.setBool('isLogin', false);
    prefs.setString('istoken', '');
    // prefs.setString('isexpire','');
    prefs.setString('iscurentTime', '');
    prefs.setString('email', '');
    prefs.setString('isexpireSecond', '');
  }
}
