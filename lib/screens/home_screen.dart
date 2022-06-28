import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharma_trax_scanner/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       key: _key, 

 drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
              SizedBox(
                // height: 150,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: blueColor1),
                  
                     child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center ,
                      children: [
                        
                    Container(
                      decoration: BoxDecoration(
   color: blueColor2,
   borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.all(5),
                   
                      height: 50,
                      width: 50,
                      child: Image.asset("assets/images/splash_logo.png"),),
                      SizedBox(height: 10,),
                      Title(color: Colors.white, child: Text("PHARMA TRAX",style: TextStyle(color: Colors.white),)),
                            SizedBox(height: 5,),
                      Title(color: Colors.white, child: Text("ali@gmail.com",style: TextStyle(color: Colors.white.withOpacity(0.6),fontWeight: FontWeight.normal,fontSize: 12)))
              
                     ],)),
              ),

              ListTile(
                leading: Container(
                  height: 25,
                  width: 25,
                  child: Image.asset("assets/images/barcode_scanner.png",color: Colors.black.withOpacity(0.6),),
                  
                ),
                title: Text("Scan GS1 Barcode"),
              ),

               ListTile(
                leading: Container(
                  height: 25,
                  width: 25,
                  child: Image.asset("assets/images/history.png",color: Colors.black.withOpacity(0.6),),
                  
                ),
                title: Text("Scan History"),
              ),

               ListTile(
                leading: Container(
                  height: 25,
                  width: 25,
                  child: Image.asset("assets/images/update.png",color: Colors.black.withOpacity(0.6),),
                  
                ),
                title: Text("Update Database"),
              ),

               ListTile(
                leading: Container(
                  height: 25,
                  width: 25,
                  child: Image.asset("assets/images/sign_out.png",color: Colors.black.withOpacity(0.6),),
                  
                ),
                title: Text("Sign Out"),
              ),

              Divider(),

              ListTile(
                leading: Text("Pharma Trax Product Line"),
              ),


               ListTile(
                leading: Container(
                  height: 25,
                  width: 25,
                  child: Image.asset("assets/images/hardware.png",color: Colors.black.withOpacity(0.6),),
                  
                ),
                title: Text("Line Level Hardware"),
              ),


               ListTile(
                leading: Container(
                  height: 25,
                  width: 25,
                  child: Image.asset("assets/images/equipment.png",color: Colors.black.withOpacity(0.6),),
                  
                ),
                title: Text("Line Equipment"),
              ),

                ListTile(
                leading: Container(
                  height: 25,
                  width: 25,
                  child: Image.asset("assets/images/gears.png",color: Colors.black.withOpacity(0.6),),
                  
                ),
                title: Text("How it Works"),
              ),


               ListTile(
                leading: Container(
                  height: 25,
                  width: 25,
             
                  child: Image.asset("assets/images/about.png",color: Colors.black.withOpacity(0.6),),
                  
                ),
                title: Text("About Pharma Trax"),
              ),
            
        ]),
  ), 


 drawerEnableOpenDragGesture: false,
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: (){},child: Icon(Icons.share,color: Colors.white,),),
    
      appBar: AppBar(
        leading: Builder(builder: (context) => // Ensure Scaffold is in context
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer()
            ),
          ),
        title: Text("Pharma Trax Scanner"),
      ),
      body: SingleChildScrollView(
        child: Container(
         padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/dna.png'))),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        
          child: Column(
           
            children: [
          Expanded(
            child: Container(
            
      
              child: Center(
                child: SingleChildScrollView(
                  child: Column
                  
                  (
                    
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                   
                   Column(
      
                    
                    children: [
                     Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Image.asset('assets/images/pharmatrax.png'),
                          ),
                          Text(
                            "Pakistan\'s first Track and Trace Serialization Solution Complete End to End Turnkey Solution Market Leader in Track and Trace Solutions",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              color: textColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 20,
                            ),
                          ),
                   ],),
                
                
                
                SizedBox(height: 20,),
                
                
                          Column(
                        children: [
                          Container(
                    color: Colors.blue,
                    width: MediaQuery.of(context).size.width*0.8,
                    
                    child: Row(children: [
                    
                           Container(
                                  padding: EdgeInsets.all(10),
                                  height: 60,
                                  width: 60,
                                  color: blueColor2,
                                  child: Image.asset('assets/images/code_128.png'),
                                ),
                                Expanded(
                                  child: Text(
                                  "SCAN GS1 128 BARCODE",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                  ),
                                ),
                    
                          
                    ],),
                    
                    ),
                    
                     SizedBox(height: 10,),
                        
                    
                    Container(
                    color: Colors.blue,
                    width: MediaQuery.of(context).size.width*0.8,
                    
                    child: Row(children: [
                    
                       Container(
                              padding: EdgeInsets.all(10),
                              height: 60,
                              width: 60,
                              color: blueColor2,
                              child: Image.asset('assets/images/data_matrix.png'),
                            ),
                            Expanded(
                              child: Text(
                              "SCAN GS1 DATA MATRIX",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              ),
                            ),
                    
                      
                    ],),
                    
                    ),
                     SizedBox(height: 20,),
                        ],
                      ),
                      
                  ],),
                ),
              ),
          
            ),
          ),
          
              
            
                   
            Container(
      
              // height: 140.h,
              padding: EdgeInsets.symmetric(vertical: 10),
      
              child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "PHARMA TRAX",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          color: textColor,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 5,),
              
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
            
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Contact us:",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                color: textColor,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 5,),
                            Expanded(
                              child: Text(
                                "CONTACT@PHARMATRAX.PK",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  color: blueColor1,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                                "WWW.PHARMATRAX.PK",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  color: blueColor1,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                               Text(
                                "WWW.ZAUQ.COM",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  color: blueColor1,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
              
          
              
                      SizedBox(height: 10,),
              
              
              
                     
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 100,vertical: 5),
                          // height: 120,
                          // width: 120,
                          child: Image.asset('assets/images/zauq.png')),
                       
                    ],
                  ),
            ),
              
          ]),
          
        ),
      ),
    );
  }
}
