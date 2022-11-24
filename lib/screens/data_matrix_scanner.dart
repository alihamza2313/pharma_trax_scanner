import 'dart:developer';
import 'package:code_scan/code_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/colors.dart';
import 'qr_result.dart';

class DataMatrixSacnner extends StatefulWidget {

  @override
  State<DataMatrixSacnner> createState() => _DataMatrixSacnnerState();
}

class _DataMatrixSacnnerState extends State<DataMatrixSacnner> {

//  Barcode? result;
//   QRViewController? controller;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//  @override
//   void reassemble() {
//     //controller!.resumeCamera();
//     super.reassemble();
//     if (Platform.isAndroid) {
//       controller!.resumeCamera();
//     }
//     controller!.resumeCamera();
//   }
//   @override
//   void initState() {
//    Timer(Duration(milliseconds: 150), ()async {
//     await controller?.resumeCamera();
//   print(" This line is execute after 5 seconds");
// });
  
    

//     super.initState();
//   }



// String _platformVersion = 'Unknown';

 
//   Future<void> initPlatformState() async {
//     String platformVersion;
  
//     try {
//       platformVersion = await FlutterMobileVision.platformVersion ??
//           'Unknown platform version';
//     } on PlatformException {
//       platformVersion = 'Failed to get platform version.';
//     }

  

//    if (!mounted) return;

//     setState(() {
//       _platformVersion = platformVersion;
//     });
//   }

//   int? _cameraBarcode = FlutterMobileVision.CAMERA_BACK;
//   int? _onlyFormatBarcode = Barcode.DATA_MATRIX;
//   bool _autoFocusBarcode = true;
//   bool _torchBarcode = false;
//   bool _multipleBarcode = false;
//   bool _waitTapBarcode = false;
//   bool _showTextBarcode = true;
//   Size? _previewBarcode =Size.fromMap({
//           "width":160,
//           "height":180

//         });
//   List<Barcode> _barcodes = [];


//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//     FlutterMobileVision.start().then((previewSizes) => setState(() {
//           if (previewSizes[_cameraBarcode] == null) {
//             return;
//           }
//           _previewBarcode = previewSizes[_cameraBarcode]!.first;
       
//         }));
//       //   SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
//          _scan();
//   }



// List<String> getListData=[];




// Future<Null> _scan() async {
//     List<Barcode> barcodes = [];
//     Size _scanpreviewOcr = _previewBarcode ?? FlutterMobileVision.PREVIEW;
//     try {
//       barcodes = await FlutterMobileVision.scan(
//         flash: true,
//         autoFocus: _autoFocusBarcode,
//         formats:   Barcode.DATA_MATRIX,
//         multiple: _multipleBarcode,
//         waitTap: _waitTapBarcode,
//         //OPTIONAL: close camera after tap, even if there are no detection.
//         //Camera would usually stay on, until there is a valid detection
//         forceCloseCameraOnTap: true,
//         //OPTIONAL: path to save image to. leave empty if you do not want to save the image
//         imagePath: '',
//         showText: _showTextBarcode,
//         preview: Size.fromMap({
//           "width":1080,
//           "height":2240

//         }),
//         scanArea: Size(500, 500),
//         camera: _cameraBarcode ?? FlutterMobileVision.CAMERA_BACK,
//         fps: 15.0,
//       );


      

       
       
//     } on Exception {
//       barcodes.add(Barcode('Failed to get barcode.'));
//     }

   

//     if (!mounted) return;
      
      
//     setState(() {
//     _barcodes = barcodes;
//      Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                       builder: (_) => QRCodeResultScreen(
//                           _barcodes[0].rawValue.toString(), rawByteCode: _barcodes[0].rawValue.toString(), "GS1 Data Matrix", true)));
//     log(_barcodes[0].rawValue.toString());
//     });

   
//   }

  

  String? code;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SCAN GS1 DATA MATRIX"),
        centerTitle: true,
        backgroundColor: colorPrimaryLightBlue,
      ),
      body: Stack(
        children: [
       
          CodeScanner(

            resolution: ResolutionPreset.high,
           loading: Center(child: CircularProgressIndicator()),
            formats: const [BarcodeFormat.dataMatrix],
            once: true,
            onScan: (code, details, controller) => 
              setState(() => this.code = code),
             onScanAll: (codes, controller) {
             Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => QRCodeResultScreen(
                          code, rawByteCode: code, "GS1 Data Matrix", true)));
             },

            // log(
            //     'Codes: ' + codes.map((code) => code.rawValue).toString()),
            
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Place a GS1 Data Matrix inside the viewfinder square to scan it.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}


