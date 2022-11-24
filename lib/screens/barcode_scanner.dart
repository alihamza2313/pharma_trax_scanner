import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:code_scan/code_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharma_trax_scanner/utils/colors.dart';

import 'barcode__resultscreen.dart';


class BarCodeScanner extends StatefulWidget {
  const BarCodeScanner({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BarCodeScannerState();
}

class _BarCodeScannerState extends State<BarCodeScanner>
    with TickerProviderStateMixin {

  @override
  initState() {
    //  Future.delayed(Duration(milliseconds: 200), ()async{

    //     await controller?.resumeCamera();
    // });

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    super.initState();
    // checkResult();
  }
  



  String? code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SCAN GS1 128 BARCODE"),
        centerTitle: true,
        backgroundColor: colorPrimaryLightBlue,
      ),
      body: Stack(
        children: [
           //_buildQrView(context),
          Container(
            child: CodeScanner(
              
               resolution: ResolutionPreset.high,
               loading: Center(child: CircularProgressIndicator(),),
              onScan: (code, details, controller) =>
                  setState(() => this.code = code),
              onScanAll: (codes, controller) {
                if (code!.substring(0, 3) == "]C1") {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => BarCodeResultScreen(
                              "",
                              rawByteCode: code.toString(),
                              "GS1 128 ",
                              true)));
                } else {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => BarCodeResultScreen(
                              "",
                              rawByteCode: code.toString(),
                              "CODE 128",
                              true)));
                }
              },

              // log(
              //     'Codes: ' + codes.map((code) => code.rawValue).toString()),
              formats: const [BarcodeFormat.code128],
              once: false,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  'Place a GS1 128 barcode inside the viewfinder rectangular to scan it.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
     
      
    ]);
   // controller?.dispose();
    super.dispose();
  }
    }


