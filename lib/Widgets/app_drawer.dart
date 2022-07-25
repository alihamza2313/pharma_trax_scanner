import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/auth_provider.dart';
import '../utils/colors.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {

SharedPreferences? prefs;

@override
  void initState() {
   
  
    super.initState();
    getSharePrefenceValue();
  }


String? auth2;

  getSharePrefenceValue() async{
 prefs = await SharedPreferences.getInstance();
 String?  getEmail = prefs!.getString('email').toString();
 log(getEmail.toString());

 setState(() {
   auth2=getEmail;
 });
  }

// log(getdiffernce.inSeconds.toString());





  
  @override
  Widget build(BuildContext context) {


    final auth = Provider.of<AuthProvider>(context);
     //final auth2 = Provider.of<AuthProvider>(context).getemail;
    

    // SharedPreferences? prefs;

    // final auth2 = auth3!.getString('email');
    


    return SafeArea(
      child: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
          SizedBox(
            // height: 150,
            child: DrawerHeader(
              decoration: const BoxDecoration(color: blueColor1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: colorPrimaryDarkes,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.all(5),
                    height:60,
                    width: 70,
                    child: Image.asset("assets/images/splash_logo.png"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Title(
                      color: Colors.white,
                      child: const Text(
                        "PHARMA TRAX",
                        style: TextStyle(color: Colors.white),
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  Title(
                      color: Colors.white,
                      child:auth2!=null? Text("$auth2",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontWeight: FontWeight.normal,
                              fontSize: 12)):Text(''))
                ],
              ),
            ),
          ),
          ListTile(
            leading: SizedBox(
              height: 25,
              width: 25,
              child: Image.asset(
                "assets/images/barcode_scanner.png",
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            title: const Text("Scan GS1 Barcode"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/home_screen');
            },
          ),
          ListTile(
            leading: SizedBox(
              height: 25,
              width: 25,
              child: Image.asset(
                "assets/images/history.png",
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            title: const Text("Scan History"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/scan_history');
            },
          ),
          ListTile(
            onTap: () async {
            
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/update_database');
            },
            leading: SizedBox(
              height: 25,
              width: 25,
              child: Image.asset(
                "assets/images/update.png",
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            title: const Text("Update Database"),
          ),
          ListTile(
            onTap: () async {
              auth.logout();
              
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/signin_page');
            },
            leading: SizedBox(
              height: 25,
              width: 25,
              child: Image.asset(
                "assets/images/sign_out.png",
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            title: const Text("Sign Out"),
          ),
          const Divider(),
          const ListTile(
            leading: Text("Pharma Trax Product Line"),
          ),
          ListTile(
            leading: SizedBox(
              height: 25,
              width: 25,
              child: Image.asset(
                "assets/images/hardware.png",
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            title: const Text("Line Level Hardware"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/line_level_hardware');
            },
          ),
          ListTile(
            leading: SizedBox(
              height: 25,
              width: 25,
              child: Image.asset(
                "assets/images/equipment.png",
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            title: const Text("Line Equipment"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/line_equipment');
            },
          ),
          ListTile(
            leading: SizedBox(
              height: 25,
              width: 25,
              child: Image.asset(
                "assets/images/gears.png",
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            title: const Text("How it Works"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/how_it_works');
              print('How_it_works');
            },
          ),
          ListTile(
            leading: SizedBox(
              height: 25,
              width: 25,
              child: Image.asset(
                "assets/images/about.png",
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            title: const Text("About Pharma Trax"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/About-pharma');
            },
          ),
        ]),
      ),
    );
  }
}
