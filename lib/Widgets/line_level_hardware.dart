import 'dart:developer';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';

class LineLevelHardware extends StatelessWidget {
  const LineLevelHardware({Key? key}) : super(key: key);

  final link = "https://www.pharmatrax.pk/pharma-trax-pro-line";
  static const htmldata = """ 

  
  <img src="asset:assets/images/line_level_hardware.png" alt="web-img2" >

  <h3>PHARMA TRAX LINE LEVEL HARDWARE</h3> 
  <br/>
  <h4>PHARMA TRAX</h4> <br/>

  <p>Pharma Trax is a suite of integrated modules which enables Pharmaceutical manufacturing and distribution companies to achieve Item Level Serialization, Traceability of Products and it's Shipping units.</p> <br /><p>This solution is specifically designed to cater to Health care and Pharmaceutical Industry's initiatives for Patient Safety, Obsolesce Management, Recall Effectiveness, Drugs ownership tracking, Brand protection, Supply Chain visibility - EPCIS, Sales and Distribution tracking and Track and Trace in true spirit.</p> <br /><p>Our bespoke solutions cater to regulatory as well as commercial needs of health care and pharmaceutical industry.</p> <br /><p>Pharma Trax line level hardware is designed based on speed requirements and capex budgets. Our solution is based on various integrated modules like:</p>
  
  <br />
  <ul><li>&nbsp;&nbsp;Printing Module that prints GS1 compliant codes</li><li>&nbsp;&nbsp;Verification Module that uses Industrial Imaging Scanners, Vision systems</li><li>
&nbsp;&nbsp;Rejection module uses air blast or pneumatic plungers which 
physically rejects the product to rejection bins</li><li>&nbsp;&nbsp;Mechanical
 Module which interconnects various modules and allows reliable material</li></ul> <br />
<p>Our hardware design can be customized according to budget as well as packaging process and has following variants:
</p> <br /><ul><li>&nbsp;&nbsp;Pre Packaging Offline</li><li>&nbsp;&nbsp;Online Versions</li><li>&nbsp;&nbsp;Post
 packaging Offline</li><li>&nbsp;&nbsp;Online Label Application</li><li>&nbsp;&nbsp;Customized Solutions</li></ul> <br /><p>
</font></p>For more details, please visit: <font color="#4A90CC"> <a href="https://www.pharmatrax.pk/pharma-trax-pro-line/">
Pharma Trax Pro Line</a>
  
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Line Level HardWare"),
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