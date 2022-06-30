// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:pharma_trax_scanner/Widgets/app_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: camel_case_types
class How_it_works extends StatelessWidget {
  const How_it_works({Key? key}) : super(key: key);

  static const routeName = '/how_it_works';

  static const htmldata = """ 
  <img src="asset:assets/images/how_it_works.png" alt="web-img2" >
<h3> <u>HOW IT WORKS</u></h3> <br /><h4>PHARMA TRAX PRINT MODULE</h4> <br /><p>We print Variable Data directly on Products, Packaging and Labels in Human Readable (Alphanumeric format) as well as Machine Readable (Linear, 2 D Barcodes, Data Matrix, QR Code, RFID) which provide identification and traceability information to stakeholders and we can effortlessly and reliably capture Machine readable data using smart phones, hand held devices, industrial scanners and vision cameras. We can print using all popular technologies like CIJ, Thermal Ink Jet, Thermal transfer, Laser marking etc.</p> <br /><h4>PHARMA TRAX VERIFICATION MODULE</h4> <br /><p>We use industrial Imagers, scanners and vision systems to read machine readable information in production, warehousing and distribution environment. It is used for Print Verification, Product movement at check points and product visibility in warehousing and distribution channels. We can integrate any imaging, scanning and camera system according to application.</p> <br /><p>We use RFID technologies for high speed, non-line of sight data identification and traceability; we use a combination of RFID standards Like Low frequency (LF), High Frequency (HF) and Ultra High Frequency (UHF) depending upon the application.</p> <br /><p>We also use Near field Communication (NFC) a consumer RFID standard that allows to communicate using consumer smart phones for Pharma Trax applications. RFID technology and Tag selection is done with customer’s needs in mind to deliver a robust and functional solution.</p> <br /><h4>PHARMA TRAX CLOUD MODULE</h4> <br /><p>Pharma Trax Cloud provides the back-end data repository and reporting engine. It works with several of our check point modules like printing, verification and apps to provide complete traceability applications.</p> <br /><p>We provide Pharma Trax Cloud as a hosted application (SAAS - Software as a service); we can discuss the possibility of having a licensed private hosting at customer’s site for certain applications.</p> <br /><h4>PHARMA TRAX APPS</h4> <br /><p>
Pharma Trax app enables consumers to Identify and Track products using their own smart phones. We have mobile apps for Android, 
IOS, Windows CE platforms to allow consumers to access traceability information; these platforms are used within the organization 
for more detailed functions like internal logistics, sales or distribution applications.</p> <br /><p>We can customize the apps to
 customer’s needs for applications like sales campaigns, data analytics, distribution channel management, Genuine product check.
</p> <br /><p>For more details, please visit: <font color="#4A90CC">
 <a href="https://www.pharmatrax.pk/services/implementation-services/">Implementation Services </a> </font></p>
  
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const AppDrawer(),
        // ignore: prefer_const_constructors
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("How it Works"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: HtmlWidget(
              htmldata,
              onTapUrl: (url) async {
                // print(url);
                var filePath = Uri.parse(url);
                //final Uri uri = Uri.file(filePath);
                 await launchUrl(filePath);
                return true;
              },
            ),
          ),
        ));
  }
}
