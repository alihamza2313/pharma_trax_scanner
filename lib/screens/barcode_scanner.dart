import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharma_trax_scanner/screens/home_screen.dart';
import 'package:pharma_trax_scanner/screens/qr_result.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:qr_mobile_vision/qr_mobile_vision.dart';

import 'dart:async';
import 'dart:developer';
import 'dart:io' show Platform;

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BarCodeScanner extends StatefulWidget {
  const BarCodeScanner({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BarCodeScannerState();
}

class _BarCodeScannerState extends State<BarCodeScanner> {
  // bool isLoadingCheck = false;
  // String? qr;
  // bool camState = false;
  var _autoEnableFlash = false;
  @override
  initState() {
    //     WidgetsFlutterBinding.ensureInitialized();
    // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);

    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    // ]);

    // setState(() {
    //   camState = true;
    // });

    super.initState();
      checkResult();
  }


checkResult() async{
      String? getData =    await  _scan();

                               getData.length <1 ?   Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder:
                                                          (context) => 
                                                          HomePage()
                                                         )):  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => QRCodeResultScreen(
                                          getData, 'DATA MATRIX (GS1)', true),
                                    ));
  }


  @override
  dispose() {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   leading: IconButton(
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //       icon: const Icon(
      //         Icons.arrow_back,
      //         color: Colors.white,
      //       )),
      //   elevation: 0,
      //   // backgroundColor: greenColor,
      //   centerTitle: true,
      //   title: Text(
      //     "Scan Qr Code",
      //     style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 16.0),
      //   ),
      // ),
      // body: Center(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Expanded(
      //           child: camState
      //               ? Container(
      //                   color: Colors.black,
      //                   child: Center(
      //                     child: SizedBox(
      //                       width: 300.0,
      //                       height: 150.0,
      //                       child: QrCamera(
      //                         formats: const [BarcodeFormats.CODE_128],
      //                         onError: (context, error) => Text(
      //                           error.toString(),
      //                           style: const TextStyle(color: Colors.red),
      //                         ),
      //                         qrCodeCallback: (code) {
      //                           setState(() {
      //                             qr = code;
      //                             setState(() {
      //                               camState = false;
      //                             });
      //                             //SaveRegistration(qr);
      //                           });
      //                           Navigator.pushReplacement(
      //                               context,
      //                               MaterialPageRoute(
      //                                 builder: (context) => QRCodeResultScreen(
      //                                     qr, 'BAR CODE (128)', true),
      //                               ));
      //                         },
      //                         child: Container(
      //                           decoration: BoxDecoration(
      //                             color: Colors.transparent,
      //                             border: Border.all(
      //                                 color: Colors.orange,
      //                                 width: 5.0,
      //                                 style: BorderStyle.solid),
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 )
      //               : const Center()),
      //     ],
      //   ),
      // ),
    );
  }


   Future<String> _scan() async {
   
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          
          // strings: {
           
          //   'cancel': _cancelController.text,
          //   'flash_on': _flashOnController.text,
          //   'flash_off': _flashOffController.text,
          // },
          restrictFormat:const [BarcodeFormat.code128],
          useCamera: 0,
          autoEnableFlash: _autoEnableFlash,
          android: AndroidOptions(
            aspectTolerance: 0.5,
            useAutoFocus: true,
          ),
        ),
      );
      

      return result.rawContent;
    
}
}
