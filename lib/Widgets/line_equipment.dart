import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:pharma_trax_scanner/Widgets/app_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class Line_equipment extends StatelessWidget {
  const Line_equipment({Key? key}) : super(key: key);

  static const routeName = '/line_equipment';

  static const htmldata = """ 

  
  <img src="asset:assets/images/line_equipment.png" alt="web-img2" >

  <h3> <u>PHARMA TRAX LINE EQUIPMENT</u></h3> <br /><p>Pharma Trax Line equipment enables initialization and verification of serialization and aggregation data to be used by track and trace eco-system to achieve Healthcare initiatives. Various modules enable Pharmaceutical manufacturing and distribution companies to achieve Item Level Serialization, Traceability of Products and it’s Shipping units.</p> <br /><p>This solution is specifically designed to cater to Health care and Pharmaceutical Industry’s initiatives for Patient Safety, Obsolescence Management, Recall Effectiveness, Drugs ownership tracking, Brand protection, Supply Chain visibility – EPCIS, Sales and Distribution tracking and Track and Trace in true spirit.</p> <br /><h4>PHARMA SYNC</h4> <br /><p>Pharma Sync is a master data management suite to allow to define and distribute Organizations, Locations, Assets and Products master data among various applications and stakeholders. It allows to have a single point of data definition, consolidation and distribution of master data. It allows all stakeholders and trading partners to have right data accessible at all times globally.</p> <br /><h4>PHARMA LINX</h4> <br /><p>Pharma Linx is our Track and Trace platform that enables storage, management and distribution of serialization and aggregation data. It allows to track products at various stages of supply chain. All transactions are verified along supply chain to insure pedigree, integrity and legitimacy. Various stakeholders i-e Manufacturers, Distributors, resellers, Logistics providers, Hospital, Pharmacies and regulators.</p> <br /><h4>PHARMA TRAX CLOUD MODULE</h4> <br /><p>Pharma Trax Cloud provides the back-end data repository and reporting engine. It works with several of our check point modules like printing, verification and apps to provide complete traceability applications.</p> <br /><p>We provide Pharma Trax Cloud as a hosted application (SAAS - Software as a service); we can discuss the possibility of having a licensed private hosting at customer’s site for certain applications.</p> <br /><h4>PHARMA TRAX APPS</h4> <br /><p>Pharma Trax app enables consumers to Identify and Track products using their own smart phones. We have mobile apps for Android, IOS, Windows CE platforms to allow consumers to access traceability information; these platforms are used within the organization for more detailed functions like internal logistics, sales or distribution applications.</p> <br /><p>We can customize the apps to customer’s needs for applications like sales campaigns, data analytics, distribution channel management, Genuine product check.</p> <br /><h4>PHARMA CLOUD</h4> <br /><p>Pharma Trax Cloud provides the back-end data repository and reporting engine. It works with several of our check points and modules like Printing, Verification, Aggregation and allows various apps to provide Track and Trace functionality. We provide the cloud as a hosted application; we can discuss the possibility of having a licensed private hosting at customer’s site for certain applications.</p> <br />
<p>For more details, please visit: <font color="#4A90CC"> <a href="https://www.pharmatrax.pk/pharma-trax-cloud/">
Pharma Trax Modules</a> </font></p>
  
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const AppDrawer(),
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Line Equipment"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: HtmlWidget(
              htmldata,
              onTapUrl: (url) async {
                print(url);
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
