

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class QRCodeResultScreen extends StatefulWidget {

  String? qrCode;
  String? typeText;
   QRCodeResultScreen(this.qrCode,this.typeText,{Key? key}) : super(key: key);

  @override
  State<QRCodeResultScreen> createState() => _QRCodeResultScreenState();
}



class _QRCodeResultScreenState extends State<QRCodeResultScreen> {


void handleClick(int item) {
  switch (item) {
    case 0:
      break;
    case 1:
      break;
  }
}
String result1='';
int count=0;
@override
  void initState() {

  String? ch = widget.qrCode.toString();
     // print(' ASCII value of ${_scanBarcode}');
//  print(' ASCII value of ${ch[0]} is ${ch.codeUnitAt(0)}');
 

//  String? getvalue =  ch.codeUnitAt(0).toString();
 result1 = ch.replaceAll(RegExp('[^A-Za-z0-9]'), 'NFC');
//log(result1);







 //log(ch);

//  int? getcode= ch.codeUnitAt(0);

// List<int> getlistcode =[];
 

//  for(int i=0;i<ch.length;i++){

// //log(ch.codeUnitAt(i).toString());
// getlistcode.add(ch.codeUnitAt(i));
//  }

//  for(int j =0 ; j <getlistcode.length;j++){

//   if(getlistcode[j]==ch.codeUnitAt(0))
//   {

//     log(ch[j]);
//      ch.replaceFirst( ch[j],"NFC");
//    // log("The String match j index $j");
    
// log(ch);
//   }
//  }
 
// log(ch);





    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: IconButton(onPressed: (){
        //    Navigator.pop(context);
        // }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
          elevation: 0,
         // backgroundColor: greenColor,
          centerTitle: false,
          title: Text(
             "Scan Result",
            style:
                GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 16.0),
          ),
          actions: [
            IconButton(onPressed: (){
               Navigator.pop(context);
            }, icon: Image.asset("assets/images/back.png")),
            // IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_sharp,color: Colors.white,))
            PopupMenuButton<int>(
          onSelected: (item) => handleClick(item),
          itemBuilder: (context) => [
            const PopupMenuItem<int>(value: 0, child: Text('Copy to Clipboard')),
            const PopupMenuItem<int>(value: 1, child: Text('Share Result')),
               const PopupMenuItem<int>(value: 0, child: Text('Share Screenshot')),
          ],
        ),
          ],
        ),
        

      body: Column(children: [

        Container(
          
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
          color: Colors.grey,
          child: Column(children: [
            Text('${widget.typeText}',style: GoogleFonts.roboto(
              color: Colors.black.withOpacity(0.5),
              fontSize: 24,
              fontWeight: FontWeight.bold
              
            ),),
            const SizedBox(height: 8,),
            Text(result1,style: GoogleFonts.roboto(
              color: Colors.black.withOpacity(0.5),
              fontSize: 18,
              fontWeight: FontWeight.w300
              
            ),)
          ],),
          
        ),

      ],)

    );
    
  }
}