import 'package:flutter/material.dart';
import 'package:pharma_trax_scanner/Widgets/app_drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';



class About_pharma extends StatelessWidget {
  const About_pharma({Key? key}) : super(key: key);
  // final link="https://www.pharmatrax.pk/pharma-trax-cloud/";
  static const routeName="/About-pharma";
  static const htmlData="""
<img src="asset:assets/images/about_pharma_trax.png" alt="web-img2" >
<h3> <u>ABOUT PHARMA TRAX</u></h3> <br /><p>Pharma Trax is a project of <strong>Zauq Group</strong> which has significant presence in Pakistan and Middle East through its subsidiaries and cater to innovative solutions for Oil and Gas, FMCG, Pharmaceutical, Food, Dairy, Garments and Textile industries.</p> <br /><p>Pharma Trax team is backed by decades of experience in Variable Data Printing, Industrial automation, RFID and System integration.</p> <br /><p>We, at Pharma Trax have integrated Variable data printing, RFID, Vision systems, Scanners, Cameras, Mobile computing and Cloud platforms with an aim to develop a dynamic solution that covers all steps of manufacturing and supply chain.</p> <br /><p>Our solutions are modular and customizable and can address problems like recall management, product uniqueness, genuine product assurance, sales territory management, sales campaigns, product usage tracking.</p> <br /><p>For more details, please visit: <font color="#4A90CC"> <a href="https://www.pharmatrax.pk/about-us/">Pharma Trax</a> </font></p>
   

 "how_it_works_info"

<h3> <u>HOW IT WORKS</u></h3> <br /><h4>PHARMA TRAX PRINT MODULE</h4> <br /><p>We print Variable Data directly on Products, Packaging and Labels in Human Readable (Alphanumeric format) as well as Machine Readable (Linear, 2 D Barcodes, Data Matrix, QR Code, RFID) which provide identification and traceability information to stakeholders and we can effortlessly and reliably capture Machine readable data using smart phones, hand held devices, industrial scanners and vision cameras. We can print using all popular technologies like CIJ, Thermal Ink Jet, Thermal transfer, Laser marking etc.</p> <br /><h4>PHARMA TRAX VERIFICATION MODULE</h4> <br /><p>We use industrial Imagers, scanners and vision systems to read machine readable information in production, warehousing and distribution environment. It is used for Print Verification, Product movement at check points and product visibility in warehousing and distribution channels. We can integrate any imaging, scanning and camera system according to application.</p> <br /><p>We use RFID technologies for high speed, non-line of sight data identification and traceability; we use a combination of RFID standards Like Low frequency (LF), High Frequency (HF) and Ultra High Frequency (UHF) depending upon the application.</p> <br /><p>We also use Near field Communication (NFC) a consumer RFID standard that allows to communicate using consumer smart phones for Pharma Trax applications. RFID technology and Tag selection is done with customer’s needs in mind to deliver a robust and functional solution.</p> <br /><h4>PHARMA TRAX CLOUD MODULE</h4> <br /><p>Pharma Trax Cloud provides the back-end data repository and reporting engine. It works with several of our check point modules like printing, verification and apps to provide complete traceability applications.</p> <br /><p>We provide Pharma Trax Cloud as a hosted application (SAAS - Software as a service); we can discuss the possibility of having a licensed private hosting at customer’s site for certain applications.</p> <br /><h4>PHARMA TRAX APPS</h4> <br /><p>
Pharma Trax app enables consumers to Identify and Track products using their own smart phones. We have mobile apps for Android, 
IOS, Windows CE platforms to allow consumers to access traceability information; these platforms are used within the organization 
for more detailed functions like internal logistics, sales or distribution applications.</p> <br /><p>We can customize the apps to
 customer’s needs for applications like sales campaigns, data analytics, distribution channel management, Genuine product check.

</p> <br /><p>For more details, please visit: <font color="#4A90CC">
 <a href="https://www.pharmatrax.pk/services/implementation-services/">Implementation Services </a> </font></p>
  

  "line_equipment_info"
<h3> <u>PHARMA TRAX LINE EQUIPMENT</u></h3> <br /><p>Pharma Trax Line equipment enables initialization and verification of serialization and aggregation data to be used by track and trace eco-system to achieve Healthcare initiatives. Various modules enable Pharmaceutical manufacturing and distribution companies to achieve Item Level Serialization, Traceability of Products and it’s Shipping units.</p> <br /><p>This solution is specifically designed to cater to Health care and Pharmaceutical Industry’s initiatives for Patient Safety, Obsolescence Management, Recall Effectiveness, Drugs ownership tracking, Brand protection, Supply Chain visibility – EPCIS, Sales and Distribution tracking and Track and Trace in true spirit.</p> <br /><h4>PHARMA SYNC</h4> <br /><p>Pharma Sync is a master data management suite to allow to define and distribute Organizations, Locations, Assets and Products master data among various applications and stakeholders. It allows to have a single point of data definition, consolidation and distribution of master data. It allows all stakeholders and trading partners to have right data accessible at all times globally.</p> <br /><h4>PHARMA LINX</h4> <br /><p>Pharma Linx is our Track and Trace platform that enables storage, management and distribution of serialization and aggregation data. It allows to track products at various stages of supply chain. All transactions are verified along supply chain to insure pedigree, integrity and legitimacy. Various stakeholders i-e Manufacturers, Distributors, resellers, Logistics providers, Hospital, Pharmacies and regulators.</p> <br /><h4>PHARMA TRAX CLOUD MODULE</h4> <br /><p>Pharma Trax Cloud provides the back-end data repository and reporting engine. It works with several of our check point modules like printing, verification and apps to provide complete traceability applications.</p> <br /><p>We provide Pharma Trax Cloud as a hosted application (SAAS - Software as a service); we can discuss the possibility of having a licensed private hosting at customer’s site for certain applications.</p> <br /><h4>PHARMA TRAX APPS</h4> <br /><p>Pharma Trax app enables consumers to Identify and Track products using their own smart phones. We have mobile apps for Android, IOS, Windows CE platforms to allow consumers to access traceability information; these platforms are used within the organization for more detailed functions like internal logistics, sales or distribution applications.</p> <br /><p>We can customize the apps to customer’s needs for applications like sales campaigns, data analytics, distribution channel management, Genuine product check.</p> <br /><h4>PHARMA CLOUD</h4> <br /><p>Pharma Trax Cloud provides the back-end data repository and reporting engine. It works with several of our check points and modules like Printing, Verification, Aggregation and allows various apps to provide Track and Trace functionality. We provide the cloud as a hosted application; we can discuss the possibility of having a licensed private hosting at customer’s site for certain applications.</p> <br />
<p>For more details, please visit: <font color="#4A90CC"> <a href="https://www.pharmatrax.pk/pharma-trax-cloud/">
Pharma Trax Modules</a> </font></p>
    """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("About Pharma Trax"),
      ),
      drawer:const AppDrawer(),
      body: SingleChildScrollView(
        child: Stack(children:[
          Image.asset("assets/images/dna.png"),
          Column(
            children: [
              Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: HtmlWidget(
              htmlData,
              onTapUrl: (url) async {
                print(url);
                var filePath = Uri.parse(url);
               //final Uri uri = Uri.file(filePath);

                await launchUrl(filePath);
                return true;
              },
            ),
          ),
            ],

          )
          ]
        ),
      ),

    );
  }
}
