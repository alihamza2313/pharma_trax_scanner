import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:pharma_trax_scanner/utils/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:clipboard/clipboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pharma_trax_scanner/Widgets/db_helper.dart';

// ignore: must_be_immutable
class QRCodeResultScreen extends StatefulWidget {
  String? qrCode;
  String? typeText;
  bool? isScanFile;
  QRCodeResultScreen(this.qrCode, this.typeText, this.isScanFile, {Key? key})
      : super(key: key);

  @override
  State<QRCodeResultScreen> createState() => _QRCodeResultScreenState();
}

class _QRCodeResultScreenState extends State<QRCodeResultScreen> {
  List<Map<String, dynamic>> map = [
    {'identifer': "00", 'title': "SSCC", 'length': 18},
    {'identifer': "01", 'title': "GTIN", 'length': 14},
    {'identifer': "02", 'title': "CONTENT", 'length': 14},
    {
      'identifer': "10",
      'title': "BATCH/LOT",
      "minimumLength": 1,
      "maximumLength": 20
    },
    {'identifer': "11", 'title': "PROD DATE", 'length': 6},
    {'identifer': "12", 'title': "DUE DATE", 'length': 6},
    {'identifer': "13", 'title': "PACK DATE", 'length': 6},
    {'identifer': "15", 'title': "BEST BY", 'length': 6},
    {'identifer': "16", 'title': "SELL BY", 'length': 6},
    {'identifer': "17", 'title': "EXPIRY", 'length': 6},
    {'identifer': "20", 'title': "VARIANT", 'length': 2},
    {
      'identifer': "21",
      'title': "SERIAL",
      "minimumLength": 1,
      "maximumLength": 20
    },
    {
      'identifer': "22",
      'title': "CPV",
      "minimumLength": 1,
      "maximumLength": 20
    },
    {
      'identifer': "240",
      'title': "ADDITIONAL ID",
      "minimumLength": 1,
      "maximumLength": 30
    },
    {
      'identifer': "241",
      'title': "CUST. PART NO.",
      "minimumLength": 1,
      "maximumLength": 30
    },
    {
      'identifer': "242",
      'title': "MTO VARIANT",
      "minimumLength": 1,
      "maximumLength": 30
    },
    {
      'identifer': "243",
      'title': "PCN",
      "minimumLength": 1,
      "maximumLength": 30
    },
    {
      'identifer': "250",
      'title': "SECONDARY SERIAL",
      "minimumLength": 1,
      "maximumLength": 30
    },
    {
      'identifer': "251",
      'title': "REF. TO SOURCE",
      "minimumLength": 1,
      "maximumLength": 30
    },
    {
      'identifer': "253",
      'title': "GDTI",
      "minimumLength": 13,
      "maximumLength": 30
    },
    {
      'identifer': "254",
      'title': "GLN EXTENSION COMPONENT",
      "minimumLength": 1,
      "maximumLength": 20
    },
    {
      'identifer': "255",
      'title': "GCN",
      "minimumLength": 13,
      "maximumLength": 25
    },
    {
      'identifer': "30",
      'title': "VAR. COUNT",
      "minimumLength": 1,
      "maximumLength": 8
    },
    {'identifer': "310n", 'title': "NET WEIGHT (kg)", 'length': 6},
    {'identifer': "311n", 'title': "LENGTH (m)", 'length': 6},
    {'identifer': "312n", 'title': "WIDTH (m)", 'length': 6},
    {'identifer': "313n", 'title': "HEIGHT (m)", 'length': 6},
    {'identifer': "314n", 'title': "AREA (m2)", 'length': 6},
    {'identifer': "315n", 'title': "NET VOLUME (l)", 'length': 6},
    {'identifer': "316n", 'title': "NET VOLUME (m3)", 'length': 6},
    {'identifer': "320n", 'title': "NET WEIGHT (lb)", 'length': 6},
    {'identifer': "321n", 'title': "LENGTH (i)", 'length': 6},
    {'identifer': "322n", 'title': "LENGTH (f)", 'length': 6},
    {'identifer': "323n", 'title': "LENGTH (y)", 'length': 6},
    {'identifer': "324n", 'title': "WIDTH (i)", 'length': 6},
    {'identifer': "325n", 'title': "WIDTH (f)", 'length': 6},
    {'identifer': "326n", 'title': "WIDTH (y)", 'length': 6},
    {'identifer': "327n", 'title': "HEIGHT (i)", 'length': 6},
    {'identifer': "328n", 'title': "HEIGHT (f)", 'length': 6},
    {'identifer': "329n", 'title': "HEIGHT (y)", 'length': 6},
    {'identifer': "330n", 'title': " GROSS WEIGHT (kg)", 'length': 6},
    {'identifer': "331n", 'title': "LENGTH (m), log", 'length': 6},
    {'identifer': "332n", 'title': "WIDTH (m), log", 'length': 6},
    {'identifer': "333n", 'title': "HEIGHT (m), log", 'length': 6},
    {'identifer': "334n", 'title': "AREA (m2), log", 'length': 6},
    {'identifer': "335n", 'title': "VOLUME (l), log", 'length': 6},
    {'identifer': "336n", 'title': "VOLUME (m3), log", 'length': 6},
    {'identifer': "337n", 'title': "KG PER m²", 'length': 6},
    {'identifer': "340n", 'title': "GROSS WEIGHT (lb)", 'length': 6},
    {'identifer': "341n", 'title': "LENGTH (i), log", 'length': 6},
    {'identifer': "342n", 'title': "LENGTH (f), log", 'length': 6},
    {'identifer': "343n", 'title': "LENGTH (y), log", 'length': 6},
    {'identifer': "344n", 'title': "WIDTH (i), log", 'length': 6},
    {'identifer': "345n", 'title': "WIDTH (f), log", 'length': 6},
    {'identifer': "346n", 'title': "WIDTH (y), log", 'length': 6},
    {'identifer': "347n", 'title': "HEIGHT (i), log", 'length': 6},
    {'identifer': "348n", 'title': "HEIGHT (f), log", 'length': 6},
    {'identifer': "349n", 'title': "HEIGHT (y), log", 'length': 6},
    {'identifer': "350n", 'title': "AREA (i2)", 'length': 6},
    {'identifer': "351n", 'title': "AREA (f2)", 'length': 6},
    {'identifer': "352n", 'title': "AREA (y2)", 'length': 6},
    {'identifer': "353n", 'title': "AREA (i2), log", 'length': 6},
    {'identifer': "354n", 'title': "AREA (f2), log", 'length': 6},
    {'identifer': "355n", 'title': "AREA (y2), log", 'length': 6},
    {'identifer': "356n", 'title': "NET WEIGHT (t)", 'length': 6},
    {'identifer': "357n", 'title': "NET VOLUME (oz)", 'length': 6},
    {'identifer': "360n", 'title': "NET VOLUME (q)", 'length': 6},
    {'identifer': "361n", 'title': "NET VOLUME (g)", 'length': 6},
    {'identifer': "362n", 'title': "VOLUME (q), log", 'length': 6},
    {'identifer': "363n", 'title': "VOLUME (g), log", 'length': 6},
    {'identifer': "364n", 'title': "VOLUME (i3)", 'length': 6},
    {'identifer': "365n", 'title': "VOLUME (f3)", 'length': 6},
    {'identifer': "366n", 'title': "VOLUME (y3)", 'length': 6},
    {'identifer': "367n", 'title': "VOLUME (i3), log", 'length': 6},
    {'identifer': "368n", 'title': "VOLUME (f3), log", 'length': 6},
    {'identifer': "369n", 'title': "VOLUME (y3), log", 'length': 6},
    {
      'identifer': "37",
      'title': "COUNT",
      "minimumLength": 1,
      "maximumLength": 8
    },
    {
      'identifer': "390n",
      'title': "AMOUNT",
      "minimumLength": 1,
      "maximumLength": 15
    },
    {
      'identifer': "391n",
      'title': "AMOUNT",
      "minimumLength": 3,
      "maximumLength": 18
    },
    {
      'identifer': "392n",
      'title': "PRICE",
      "minimumLength": 1,
      "maximumLength": 15
    },
    {
      'identifer': "393n",
      'title': "PRICE",
      "minimumLength": 3,
      "maximumLength": 18
    },
    {
      'identifer': "394n",
      'title': "PRCNT OFF",
      'length': 4,
      "requiredFNC1": true
    },
    {
      'identifer': "400",
      'title': "ORDER NUMBER",
      "minimumLength": 1,
      "maximumLength": 30
    },
    {
      'identifer': "401",
      'title': "GINC",
      "minimumLength": 1,
      "maximumLength": 30
    },
    {'identifer': "402", 'title': "GSIN", 'length': 17, "requiredFNC1": true},
    {
      'identifer': "403",
      'title': "ROUTE",
      "minimumLength": 1,
      "maximumLength": 30
    },
    {'identifer': "410", 'title': "SHIP TO LOC", 'length': 13},
    {'identifer': "411", 'title': "BILL TO", 'length': 13},
    {'identifer': "412", 'title': "PURCHASE FROM", 'length': 13},
    {'identifer': "413", 'title': "SHIP FOR LOC", 'length': 13},
    {'identifer': "414", 'title': "LOC No", 'length': 13},
    {'identifer': "415", 'title': "PAY TO", 'length': 13},
    {'identifer': "416", 'title': "PROD/SERV LOC", 'length': 13},
    {
      'identifer': "420",
      'title': "SHIP TO POST",
      "minimumLength": 1,
      "maximumLength": 20
    },
    {
      'identifer': "421",
      'title': "SHIP TO POST",
      "minimumLength": 3,
      "maximumLength": 12
    },
    {'identifer': "422", 'title': "ORIGIN", 'length': 3, "requiredFNC1": true},
    {
      'identifer': "423",
      'title': "COUNTRY - INITIAL PROCESS.",
      "minimumLength": 3,
      "maximumLength": 15
    },
    {
      'identifer': "424",
      'title': "COUNTRY - PROCESS.",
      'length': 3,
      "requiredFNC1": true
    },
    {
      'identifer': "425",
      'title': "COUNTRY - DISASSEMBLY",
      "minimumLength": 3,
      "maximumLength": 15
    },
    {
      'identifer': "426",
      'title': "COUNTRY – FULL PROCESS",
      'length': 3,
      "requiredFNC1": true
    },
    {
      'identifer': "427",
      'title': "ORIGIN SUBDIVISION",
      "minimumLength": 1,
      "maximumLength": 3
    },
    {'identifer': "7001", 'title': "NSN", 'length': 13, "requiredFNC1": true},
    {
      'identifer': "7002",
      'title': "MEAT CUT",
      "minimumLength": 1,
      "maximumLength": 30
    },
    {
      'identifer': "7003",
      'title': "EXPIRY TIME",
      'length': 10,
      "requiredFNC1": true
    },
    {
      'identifer': "7004",
      'title': "ACTIVE POTENCY",
      "minimumLength": 1,
      "maximumLength": 4
    },
    {
      'identifer': "7005",
      'title': "CATCH AREA",
      "minimumLength": 1,
      "maximumLength": 12
    },
    {
      'identifer': "7006",
      'title': "FIRST FREEZE DATE",
      'length': 6,
      "requiredFNC1": true
    },
    {
      'identifer': "7007",
      'title': "HARVEST DATE",
      "minimumLength": 6,
      "maximumLength": 12
    },
    {
      'identifer': "7008",
      'title': "AQUATIC SPECIES",
      "minimumLength": 1,
      "maximumLength": 3
    },
    {
      'identifer': "7009",
      'title': "FISHING GEAR TYPE",
      "minimumLength": 1,
      "maximumLength": 10
    },
    {
      'identifer': "7010",
      'title': "PROD METHOD",
      "minimumLength": 1,
      "maximumLength": 2
    },
    {
      'identifer': "7020",
      'title': "REFURB LOT",
      "minimumLength": 1,
      "maximumLength": 20
    },
    {
      'identifer': "7021",
      'title': "FUNC STAT",
      "minimumLength": 1,
      "maximumLength": 20
    },
    {
      'identifer': "7022",
      'title': "REV STAT",
      "minimumLength": 1,
      "maximumLength": 20
    },
    {
      'identifer': "7023",
      'title': "GIAI – ASSEMBLY",
      "minimumLength": 1,
      "maximumLength": 30
    },
    {
      'identifer': "703s",
      'title': "PROCESSOR # s",
      "minimumLength": 3,
      "maximumLength": 30
    },
    {
      'identifer': "710",
      'title': "NHRN PZN",
      "minimumLength": 1,
      "maximumLength": 20
    },
    {
      'identifer': "711",
      'title': "NHRN CIP",
      "minimumLength": 1,
      "maximumLength": 20
    },
    {
      'identifer': "712",
      'title': "NHRN CN",
      "minimumLength": 1,
      "maximumLength": 20
    },
    {
      'identifer': "713",
      'title': "NHRN DRN",
      "minimumLength": 1,
      "maximumLength": 20
    },
    {
      'identifer': "714",
      'title': "NHRN AIM",
      "minimumLength": 1,
      "maximumLength": 20
    },
    {
      'identifer': "...",
      'title': "NHRN xxx",
      "minimumLength": 1,
      "maximumLength": 20
    },
    {
      'identifer': "8001",
      'title': "DIMENSIONS",
      'length': 14,
      "requiredFNC1": true
    },
    {
      'identifer': "8002",
      'title': "CMT No",
      "minimumLength": 1,
      "maximumLength": 20
    },
    {
      'identifer': "8003",
      'title': "GRAI",
      "minimumLength": 14,
      "maximumLength": 30
    },
    {
      'identifer': "8004",
      'title': "GIAI",
      "minimumLength": 1,
      "maximumLength": 30
    },
    {
      'identifer': "8005",
      'title': "PRICE PER UNIT",
      'length': 6,
      "requiredFNC1": true
    },
    {
      'identifer': "8006",
      'title': "ITIP or GCTIN",
      'length': 18,
      "requiredFNC1": true
    },
    {
      'identifer': "8007",
      'title': "IBAN",
      "minimumLength": 1,
      "maximumLength": 34
    },
    {
      'identifer': "8008",
      'title': "PROD TIME",
      "minimumLength": 8,
      "maximumLength": 12
    },
    {
      'identifer': "8010",
      'title': "CPID",
      "minimumLength": 1,
      "maximumLength": 30
    },
    {
      'identifer': "8011",
      'title': "CPID SERIAL",
      "minimumLength": 1,
      "maximumLength": 12
    },
    {
      'identifer': "8012",
      'title': "VERSION",
      "minimumLength": 1,
      "maximumLength": 20
    },
    {
      'identifer': "8013",
      'title': "GMN or BUDI-DI",
      "minimumLength": 1,
      "maximumLength": 30
    },
    {
      'identifer': "8017",
      'title': "GSRN - PROVIDER",
      'length': 18,
      "requiredFNC1": true
    },
    {
      'identifer': "8018",
      'title': "GSRN - RECIPIENT",
      'length': 18,
      "requiredFNC1": true
    },
    {
      'identifer': "8019",
      'title': "SRIN",
      "minimumLength": 1,
      "maximumLength": 10
    },
    {
      'identifer': "8020",
      'title': "REF No",
      "minimumLength": 1,
      "maximumLength": 25
    },
    {
      'identifer': "8110",
      'title': "-",
      "minimumLength": 1,
      "maximumLength": 70
    },
    {'identifer': "8111", 'title': "POINTS", 'length': 4, "requiredFNC1": true},
    {
      'identifer': "8112",
      'title': "-",
      "minimumLength": 1,
      "maximumLength": 70
    },
    {
      'identifer': "8200",
      'title': "PRODUCT URL",
      "minimumLength": 1,
      "maximumLength": 70
    },
    {
      'identifer': "90",
      'title': "INTERNAL",
      "minimumLength": 1,
      "maximumLength": 30
    },
    {
      'identifer': "91",
      'title': "INTERNAL",
      "minimumLength": 1,
      "maximumLength": 90
    },
    {
      'identifer': "92",
      'title': "INTERNAL",
      "minimumLength": 1,
      "maximumLength": 90
    },
    {
      'identifer': "93",
      'title': "INTERNAL",
      "minimumLength": 1,
      "maximumLength": 90
    },
    {
      'identifer': "94",
      'title': "INTERNAL",
      "minimumLength": 1,
      "maximumLength": 90
    },
    {
      'identifer': "95",
      'title': "INTERNAL",
      "minimumLength": 1,
      "maximumLength": 90
    },
    {
      'identifer': "96",
      'title': "INTERNAL",
      "minimumLength": 1,
      "maximumLength": 90
    },
    {
      'identifer': "97",
      'title': "INTERNAL",
      "minimumLength": 1,
      "maximumLength": 90
    },
    {
      'identifer': "98",
      'title': "INTERNAL",
      "minimumLength": 1,
      "maximumLength": 90
    },
    {
      'identifer': "99",
      'title': "INTERNAL",
      "minimumLength": 1,
      "maximumLength": 90
    },
  ];

  List<Map<String, dynamic>> resultMap = [];

  List getLocalstoreData = [];

  List qrResultConvertList = [];

  String? getSpecialCharacter;
  String? afterAlldataNewstringg;
  String? getSpecialcharcatershape;

  String? productName;
  String? CompanyName;

  bool isGTINExistValue = false;

  String? replaceAllspecialcharacter;

  @override
  void initState() {
//fatchData();

    if (widget.isScanFile!) {
      insertScanData(widget.qrCode.toString(), widget.typeText.toString());
      widget.isScanFile = false;
    }
    String? getqrcoderesult = widget.qrCode.toString();

    replaceAllspecialcharacter =
        getqrcoderesult.replaceAll(RegExp('[^A-Za-z0-9]'), 'NFC');
    log(getqrcoderesult);
    getSpecialcharcatershape = getqrcoderesult[0];

    getSpecialCharacter = getqrcoderesult.codeUnitAt(0).toString();

    if (getSpecialCharacter == "29") {
      for (int i = 0; i < widget.qrCode!.length; i++) {
        qrResultConvertList.add(widget.qrCode![i].toString());
      }

      log(qrResultConvertList.toString());

      CheckValueForTest(widget.qrCode.toString());
    } else {
      log("inValid Data Matrix");
    }

    log(resultMap.toString());

    CheckValueExitInDb();

    super.initState();
  }

  final dbhelper = DataBaseHelper.instance;

  void insertScanData(String qrData, String qrType) async {
    Map<String, dynamic> row = {
      DataBaseHelper.table2ColumnId: qrData,
      DataBaseHelper.table2ColumnBarcodeType: qrType,
      DataBaseHelper.table2ColumnDate:
          DateFormat('dd:MM:yy').add_jm().format(DateTime.now()).toString()
    };
    final id = await dbhelper.insertTable2(row);
    print("----------------------------");
    print(id);
    print("----------------------------");
  }

  CheckValueForTest(String? newStringafterSpecialCharcter) {
    if (newStringafterSpecialCharcter!.codeUnitAt(0).toString() == "29") {
      String? newStringDeleteFirstIndex = newStringafterSpecialCharcter
          .substring(1, newStringafterSpecialCharcter.length);

      log(newStringDeleteFirstIndex.toString());
      String? getFirsttwoIndex = newStringDeleteFirstIndex.substring(0, 2);
      String? getFirstthreeIndex = newStringDeleteFirstIndex.substring(0, 3);
      String? getFirstfourIndex = newStringDeleteFirstIndex.substring(0, 4);

      for (var key in map) {
        if (key['identifer'] == getFirsttwoIndex) {
// delete First 2 Character match Map Key Value

          String? getLengthafterCode = newStringDeleteFirstIndex.substring(
              2, newStringDeleteFirstIndex.length);
          log(getLengthafterCode);

// get Length of Map key Value so that get number of string which define map

          int? getLength = key["length"] ?? key["maximumLength"];
          log(getLength.toString());

          // get Length of String and Save Other Map toi display

          if (getLength! > getLengthafterCode.length) {
            log(getLengthafterCode);

            String? getFirstVIIStringg = getLengthafterCode;

            if (getFirstVIIStringg.contains(getSpecialcharcatershape!)) {
              int? getIndex =
                  getFirstVIIStringg.indexOf(getSpecialcharcatershape!);

              log(getIndex.toString());

              getFirstVIIStringg = getLengthafterCode.substring(0, getIndex);
              log(getFirstVIIStringg);

              afterAlldataNewstringg = getLengthafterCode.substring(
                  getIndex, getLengthafterCode.length);

              resultMap.add({
                'identifer': key["identifer"],
                'title': key["title"],
                'value': getFirstVIIStringg
              });

              setState(() {
                CheckValueForTest(afterAlldataNewstringg);
              });
            } else {
              afterAlldataNewstringg = getLengthafterCode;

              log(getFirstVIIStringg);
              log(afterAlldataNewstringg!);

              resultMap.add({
                'identifer': key["identifer"],
                'title': key["title"],
                'value': getFirstVIIStringg
              });
              setState(() {
                CheckValueForTest(afterAlldataNewstringg);
              });
            }
          } else {
            String? getFirstVIIStringg =
                getLengthafterCode.substring(0, getLength);

            if (getFirstVIIStringg.contains(getSpecialcharcatershape!)) {
              int? getIndex =
                  getFirstVIIStringg.indexOf(getSpecialcharcatershape!);

              log(getIndex.toString());

              getFirstVIIStringg = getLengthafterCode.substring(0, getIndex);
              log(getFirstVIIStringg);

              afterAlldataNewstringg = getLengthafterCode.substring(
                  getIndex, getLengthafterCode.length);
              resultMap.add({
                'identifer': key["identifer"],
                'title': key["title"],
                'value': getFirstVIIStringg
              });
              setState(() {
                CheckValueForTest(afterAlldataNewstringg);
              });
            } else {
              afterAlldataNewstringg = getLengthafterCode.substring(
                  getLength, getLengthafterCode.length);

              log(getFirstVIIStringg);
              log(afterAlldataNewstringg!);

              resultMap.add({
                'identifer': key["identifer"],
                'title': key["title"],
                'value': getFirstVIIStringg
              });

              setState(() {
                CheckValueForTest(afterAlldataNewstringg);
              });
            }
          }
        } else if (key['identifer'] == getFirstthreeIndex) {
          String? getLengthafterCode = newStringDeleteFirstIndex.substring(
              3, newStringDeleteFirstIndex.length);
          log(getLengthafterCode);

// get Length of Map key Value so that get number of string which define map

          int? getLength = key["length"] ?? key["maximumLength"];
          log(getLength.toString());

          // get Length of String and Save Other Map toi display

          if (getLength! > getLengthafterCode.length) {
            log(getLengthafterCode);

            String? getFirstVIIStringg = getLengthafterCode;

            if (getFirstVIIStringg.contains(getSpecialcharcatershape!)) {
              int? getIndex =
                  getFirstVIIStringg.indexOf(getSpecialcharcatershape!);

              log(getIndex.toString());

              getFirstVIIStringg = getLengthafterCode.substring(0, getIndex);
              log(getFirstVIIStringg);

              afterAlldataNewstringg = getLengthafterCode.substring(
                  getIndex, getLengthafterCode.length);

              resultMap.add({
                'identifer': key["identifer"],
                'title': key["title"],
                'value': getFirstVIIStringg
              });

              setState(() {
                CheckValueForTest(afterAlldataNewstringg);
              });
            } else {
              afterAlldataNewstringg = getLengthafterCode;

              log(getFirstVIIStringg);
              log(afterAlldataNewstringg!);

              resultMap.add({
                'identifer': key["identifer"],
                'title': key["title"],
                'value': getFirstVIIStringg
              });
              setState(() {
                CheckValueForTest(afterAlldataNewstringg);
              });
            }
          } else {
            String? getFirstVIIStringg =
                getLengthafterCode.substring(0, getLength);

            if (getFirstVIIStringg.contains(getSpecialcharcatershape!)) {
              int? getIndex =
                  getFirstVIIStringg.indexOf(getSpecialcharcatershape!);

              log(getIndex.toString());

              getFirstVIIStringg = getLengthafterCode.substring(0, getIndex);
              log(getFirstVIIStringg);

              afterAlldataNewstringg = getLengthafterCode.substring(
                  getIndex, getLengthafterCode.length);
              resultMap.add({
                'identifer': key["identifer"],
                'title': key["title"],
                'value': getFirstVIIStringg
              });
              setState(() {
                CheckValueForTest(afterAlldataNewstringg);
              });
            } else {
              afterAlldataNewstringg = getLengthafterCode.substring(
                  getLength, getLengthafterCode.length);

              log(getFirstVIIStringg);
              log(afterAlldataNewstringg!);

              resultMap.add({
                'identifer': key["identifer"],
                'title': key["title"],
                'value': getFirstVIIStringg
              });

              setState(() {
                CheckValueForTest(afterAlldataNewstringg);
              });
            }
          }
        } else if (key['identifer'] == getFirstfourIndex) {
          String? getLengthafterCode = newStringDeleteFirstIndex.substring(
              4, newStringDeleteFirstIndex.length);
          log(getLengthafterCode);

// get Length of Map key Value so that get number of string which define map

          int? getLength = key["length"] ?? key["maximumLength"];
          log(getLength.toString());

          // get Length of String and Save Other Map toi display

          if (getLength! > getLengthafterCode.length) {
            log(getLengthafterCode);

            String? getFirstVIIStringg = getLengthafterCode;

            if (getFirstVIIStringg.contains(getSpecialcharcatershape!)) {
              int? getIndex =
                  getFirstVIIStringg.indexOf(getSpecialcharcatershape!);

              log(getIndex.toString());

              getFirstVIIStringg = getLengthafterCode.substring(0, getIndex);
              log(getFirstVIIStringg);

              afterAlldataNewstringg = getLengthafterCode.substring(
                  getIndex, getLengthafterCode.length);

              resultMap.add({
                'identifer': key["identifer"],
                'title': key["title"],
                'value': getFirstVIIStringg
              });

              setState(() {
                CheckValueForTest(afterAlldataNewstringg);
              });
            } else {
              afterAlldataNewstringg = getLengthafterCode;

              log(getFirstVIIStringg);
              log(afterAlldataNewstringg!);

              resultMap.add({
                'identifer': key["identifer"],
                'title': key["title"],
                'value': getFirstVIIStringg
              });
              setState(() {
                CheckValueForTest(afterAlldataNewstringg);
              });
            }
          } else {
            String? getFirstVIIStringg =
                getLengthafterCode.substring(0, getLength);

            if (getFirstVIIStringg.contains(getSpecialcharcatershape!)) {
              int? getIndex =
                  getFirstVIIStringg.indexOf(getSpecialcharcatershape!);

              log(getIndex.toString());

              getFirstVIIStringg = getLengthafterCode.substring(0, getIndex);
              log(getFirstVIIStringg);

              afterAlldataNewstringg = getLengthafterCode.substring(
                  getIndex, getLengthafterCode.length);
              resultMap.add({
                'identifer': key["identifer"],
                'title': key["title"],
                'value': getFirstVIIStringg
              });
              setState(() {
                CheckValueForTest(afterAlldataNewstringg);
              });
            } else {
              afterAlldataNewstringg = getLengthafterCode.substring(
                  getLength, getLengthafterCode.length);

              log(getFirstVIIStringg);
              log(afterAlldataNewstringg!);

              resultMap.add({
                'identifer': key["identifer"],
                'title': key["title"],
                'value': getFirstVIIStringg
              });

              setState(() {
                CheckValueForTest(afterAlldataNewstringg);
              });
            }
          }
        }
      }
    } else {
      log(newStringafterSpecialCharcter.toString());
      String? getFirsttwoIndex = newStringafterSpecialCharcter.substring(0, 2);
      String? getFirstthreeIndex =
          newStringafterSpecialCharcter.substring(0, 3);
      String? getFirstfourIndex = newStringafterSpecialCharcter.substring(0, 4);

      for (var key in map) {
        if (key['identifer'] == getFirsttwoIndex) {
          String? getLengthafterCode = newStringafterSpecialCharcter.substring(
              2, newStringafterSpecialCharcter.length);
          log(getLengthafterCode);
          // if (fetchmap.containsKey("length")) {
          int? getLength = key["length"] ?? key["maximumLength"];
          log(getLength.toString());

          if (getLength! > getLengthafterCode.length) {
            log(getLengthafterCode);

            String? getFirstVIIStringg = getLengthafterCode;

            if (getFirstVIIStringg.contains(getSpecialcharcatershape!)) {
              int? getIndex =
                  getFirstVIIStringg.indexOf(getSpecialcharcatershape!);

              log(getIndex.toString());

              getFirstVIIStringg = getLengthafterCode.substring(0, getIndex);
              log(getFirstVIIStringg);

              afterAlldataNewstringg = getLengthafterCode.substring(
                  getIndex, getLengthafterCode.length);

              resultMap.add({
                'identifer': key["identifer"],
                'title': key["title"],
                'value': getFirstVIIStringg
              });

              setState(() {
                CheckValueForTest(afterAlldataNewstringg);
              });
            } else {
              afterAlldataNewstringg = getLengthafterCode;

              log(getFirstVIIStringg);
              log(afterAlldataNewstringg!);

              resultMap.add({
                'identifer': key["identifer"],
                'title': key["title"],
                'value': getFirstVIIStringg
              });

              setState(() {
                CheckValueForTest(afterAlldataNewstringg);
              });
            }
          } else {
            String? getFirstVIIStringg =
                getLengthafterCode.substring(0, getLength);

            if (getFirstVIIStringg.contains(getSpecialcharcatershape!)) {
              int? getIndex =
                  getFirstVIIStringg.indexOf(getSpecialcharcatershape!);

              log(getIndex.toString());

              getFirstVIIStringg = getLengthafterCode.substring(0, getIndex);
              log(getFirstVIIStringg);

              afterAlldataNewstringg = getLengthafterCode.substring(
                  getIndex, getLengthafterCode.length);
              resultMap.add({
                'identifer': key["identifer"],
                'title': key["title"],
                'value': getFirstVIIStringg
              });
              setState(() {
                CheckValueForTest(afterAlldataNewstringg);
              });
            } else {
              afterAlldataNewstringg = getLengthafterCode.substring(
                  getLength, getLengthafterCode.length);

              log(getFirstVIIStringg);
              log(afterAlldataNewstringg!);
              resultMap.add({
                'identifer': key["identifer"],
                'title': key["title"],
                'value': getFirstVIIStringg
              });
              setState(() {
                CheckValueForTest(afterAlldataNewstringg);
              });
            }
          }
        } else if (key['identifer'] == getFirstthreeIndex) {
        } else if (key['identifer'] == getFirstfourIndex) {
          log(key['identifer']);
        }
      }
    }
  }

  CheckValueExitInDb() async {
    getLocalstoreData = await dbhelper.fatchTable1();

    // log("this funcation Call");
    //   log(getLocalstoreData[0].toString());
    // log(getLocalstoreData.length.toString());

    for (int j = 0; j < resultMap.length; j++) {
      if (resultMap[j]['title'] == "GTIN") {
        setState(() {
          isGTINExistValue = true;
        });

        // log(resultMap[j].toString());

        String? getData = resultMap[j]['value'];
//log(getData.toString());

        for (int i = 0; i < getLocalstoreData.length; i++) {
          if (getData == getLocalstoreData[i]['id']) {
            productName = getLocalstoreData[i]['plain1'];
            CompanyName = getLocalstoreData[i]['cline3'];

            // log(getLocalstoreData[i]['plain1']);
            //   log(getLocalstoreData[i]['cline3']);

          }
        }
      }
    }

//   for(int i=0;i<data.length;i++){
//  if(getData ==data[i]['id'] ){

//     log(data[i]['plain1']);
//       log(data[i]['cline3']);

//   }

// }

//}

//}
  }

  void handleClick(int item) {
    switch (item) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
    }
  }

  final _screenShotController = ScreenshotController();
  Future shareScreenshot(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File("${directory.path}/flutter.png"); //for share ScreenShot
    image.writeAsBytesSync(bytes);
    await Share.shareFiles([image.path]);
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: _screenShotController,
      child: Scaffold(
        floatingActionButton: SpeedDial(
          
          childMargin:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
          // icon: Icons.add,
          animatedIcon: AnimatedIcons.menu_close,
          backgroundColor: colorPrimaryLightBlue,
          childPadding: EdgeInsets.symmetric(vertical: 8),
          animationDuration:const Duration(milliseconds: 350),
          

          children: [
            SpeedDialChild(
                child: const ImageIcon(AssetImage("assets/images/copy.png"),color:Colors.white),
                label: "Copy Result",
                labelStyle: const TextStyle(color: Colors.white),
                backgroundColor: copybuttonColor,
                labelBackgroundColor: Colors.black,
                onTap: () async {
                  await FlutterClipboard.copy(replaceAllspecialcharacter!);
                  Fluttertoast.showToast(
                    
                      msg: "Result Copied!",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 2,
                      gravity: ToastGravity.CENTER,
                      backgroundColor: Colors.black);
                }),
            SpeedDialChild(
                child: const ImageIcon(AssetImage("assets/images/share.png"),color:Colors.white),
                label: "Share Result",
                labelStyle: const TextStyle(color: Colors.white),
                labelBackgroundColor: Colors.black,
                backgroundColor: sharebuttonColor,
                onTap: () async {
                  await Share.share(replaceAllspecialcharacter!);
                }),
            SpeedDialChild(
                child: const ImageIcon(
                  
                    AssetImage("assets/images/screenshot.png"),color:Colors.white),
                label: "Share ScreenShot",
                
                labelStyle: const TextStyle(color: Colors.white),
                labelBackgroundColor: Colors.black,
                backgroundColor: screenshotbuttonColor,
                onTap: () async {
                  final shareShotImage =
                      await _screenShotController.capture();
                  shareScreenshot(shareShotImage!);
                }),
          ],
        ),
        
        appBar: AppBar(
        
          backgroundColor: colorPrimaryLightBlue,
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: false,
          title: Text(
            "Scan Result",
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w500, fontSize: 16.0),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset("assets/images/back.png")),
            // IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_sharp,color: Colors.white,))
            PopupMenuButton<int>(
              onSelected: (item) => handleClick(item),
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: const Text('Copy to Clipboard'),
                  onTap: () async {
                    await FlutterClipboard.copy(replaceAllspecialcharacter!);
                    Fluttertoast.showToast(
                        msg: "Result Copied!",
                        timeInSecForIosWeb: 2,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.black);
                  },
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: const Text('Share Result'),
                  onTap: () async {
                    await Share.share(replaceAllspecialcharacter!);
                  },
                ),
                PopupMenuItem<int>(
                  value: 2,
                  child: const Text('Share Screenshot'),
                  onTap: () async {
                    final shareShotImage =
                        await _screenShotController.capture();
                    shareScreenshot(shareShotImage!);
                  },
                ),
              ],
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                color: resultbackgroundColor,
                child: Column(
                  children: [
                    Text(
                      '${widget.typeText}',
                      style: GoogleFonts.roboto(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
        
                    Wrap(
                        children: qrResultConvertList.map((item) {
                      if (item == widget.qrCode![0]) {
                        return const Text(
                          'NFC',
                          style: TextStyle(
                            color: colorPrimaryLightBlue,
                            fontWeight: FontWeight.normal,
                          ),
                        );
                      } else {
                        return Text(item.toString(),style: TextStyle(
                          color: Colors.black54,
                          
                          fontSize: 16
                        ),);
                      }
                      // if (item < 100) {
                      //   return Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Text(
                      //       item.toString(),
                      //       style: const TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //         color: Colors.red,
                      //       ),
                      //     ),
                      //   );
                      // }
                      // if (item == 100) {
                      //   return Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Text(
                      //       item.toString(),
                      //       style: TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //         color: Colors.green,
                      //       ),
                      //     ),
                      //   );
                      // }
                    }).toList()),
                    // Text(
                    //   "${widget.qrCode}",
                    //   style: GoogleFonts.roboto(
                    //       color: Colors.black.withOpacity(0.5),
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.w300),
                    // )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "SCANNED INFORMATION",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < resultMap.length; i++)
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${resultMap[i]['title']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: colorPrimaryLightBlue),
                                    ),
                                    Text(
                                      '(${resultMap[i]['identifer']}): ',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: colorPrimaryLightBlue),
                                    ),
                                  ],
                                )),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      '${resultMap[i]['value']}',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color:Colors.black54
                                      ),
                                    )),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: isGTINExistValue,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "MASTER DATA",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(
                            child: Text(
                              'PRODUCT: ',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: colorPrimaryLightBlue),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '$productName',
                               style: TextStyle(
                                        color:Colors.black54
                                      ),
                              // style: const TextStyle(
                              //     fontWeight: FontWeight.bold,
                              //     color: blueColor1),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(
                            child: Text(
                              'COMPANY: ',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: colorPrimaryLightBlue),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '$CompanyName',
                               style: TextStyle(
                                        color:Colors.black54
                                      ),
                              //  style: const TextStyle(
                              //      fontWeight: FontWeight.bold,
                              //      color: blueColor1),
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
        ),
      ),
    );
  }
}
