import 'package:flutter/material.dart';

class ScanHistory extends StatefulWidget {
  const ScanHistory({Key? key}) : super(key: key);

  @override
  State<ScanHistory> createState() => _ScanHistoryState();
}

class _ScanHistoryState extends State<ScanHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: ,
      body: ListTile(
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
    );
  }
}
