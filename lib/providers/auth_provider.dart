import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:pharma_trax_scanner/Widgets/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String _token = 'null';
  DateTime? _startdate;
  int _expiryDate = 0;
  String _userId = 'null';
  Timer? _authTimer;

  bool get isAuth {
    return token != 'null';
  }

  String get token {
    if (_expiryDate != 0 && _token != 'null') {
      return _token;
    }
    return 'null';
  }

  String get userId {
    return _userId;
  }

  Future<void> login(String userId) async {
    var provinceBodyPayment = jsonEncode(<String, String>{
      'Email': userId,
      'Password': 'P@ssw0rd',
      'ConfirmPassword': 'P@ssw0rd',
    });
    print(provinceBodyPayment);
    try {
      await apiResponse(provinceBodyPayment, userId);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> apiResponse(String provinceBodyPayment, String getemail) async {
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
      _expiryDate = getResponseData["expires_in"];
      _token = getResponseData['access_token'];
      _autoLogout();
      getAllDataApiCall(getemail, _token);
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('userData')) {
        savePrefValue(provinceBodyPayment, getemail, _token, _expiryDate);
      }
    } else {
      print("Response not 200");
    }
  }

  //  SHARED PREFERENCES from API 1( Token & Second )
  savePrefValue(String provinceBodyPayment, String getemail, String token,
      int second) async {
    print("----------------------------");
    print('Before Data Save in SharedPreferences...');
    print("----------------------------");
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'provinceBodyPayment': provinceBodyPayment,
      'userId': getemail,
      'startDate': DateTime.now().toIso8601String(),
      'token': token,
      'seconds': second,
    });
    print("----------------------------");
    print('Data Save in SharedPreferences...');
    print(userData);
    print("----------------------------");
    prefs.setString('userData', userData);
    Fluttertoast.showToast(msg: second.toString());
  }

  // API for Data calling
  getAllDataApiCall(String email, String token) async {
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
            'Authorization': 'Bearer ${token}',
          },
        );

        if (response.statusCode == 200) {
          Map getApiData = jsonDecode(response.body);

          insertDbInfo(getApiData['Info']);
          for (int i = 0; i < getApiData['Companies'].length; i++) {
            insertDbData(getApiData['Companies'][i]);
          }
          // Navigator.of(context).pushReplacementNamed(HomePage.routeName);
        }
      } catch (e) {
        e.toString();
      }
    }
  }

  // Insert Data in Database
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

  Future<bool> tryAutoLogin() async {
    // final prefs = await SharedPreferences.getInstance();
    // if (!prefs.containsKey('userData')) {
    //   return false;
    // }
    // final extractedUserData = json.decode(prefs.getString('userData')) as Map<String, Object>;
    // final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    // if (expiryDate.isBefore(DateTime.now())) {
    //   return false;
    // }
    // _token = extractedUserData['token'];
    // _userId = extractedUserData['userId'];
    // _expiryDate = expiryDate;
    // notifyListeners();
    // _autoLogout();
    // return true;

    // final prefs = await SharedPreferences.getInstance();
    // if (!prefs.containsKey('userData')) {
    //   return false;
    // }
    // // 'provinceBodyPayment': provinceBodyPayment,
    // //   'userId': getemail,
    // //   'startDate': DateTime.now(),
    // //   'token': tioken,
    // //   'seconds': second.toString(),
    // //   'isLogin': true,
    // final extractedUserData = json
    //     .decode(prefs.getString('userData').toString()) as Map<String, dynamic>;
    // _userId = extractedUserData['userId'];
    // DateTime _start = extractedUserData['startDate'];
    // _token = extractedUserData['token'];
    // _expiryDate = extractedUserData['expiryDate'];

    // // _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = 'null';
    _userId = 'null';
    _startdate = 'null' as DateTime;
    _expiryDate = 0;
    if (_authTimer != 'null' as Timer) {
      _authTimer!.cancel();
      _authTimer = 'null' as Timer;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }

  void _autoLogout() {
    // if (_authTimer != null) {
    //   _authTimer.cancel();
    // }
    // final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    // _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
