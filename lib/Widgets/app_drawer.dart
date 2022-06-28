import 'package:flutter/material.dart';

import '../utils/colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                      color: blueColor2,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.all(5),
                    height: 50,
                    width: 50,
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
                      child: Text("ali@gmail.com",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontWeight: FontWeight.normal,
                              fontSize: 12)))
                ],
              )),
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
        ),
        ListTile(
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
        ),
      ]),
    );
  }
}
