import 'package:flutter/material.dart';
import 'package:pharma_trax_scanner/Widgets/app_drawer.dart';
import 'package:pharma_trax_scanner/Widgets/db_helper.dart';
import 'package:pharma_trax_scanner/screens/qr_result.dart';
import 'package:pharma_trax_scanner/utils/colors.dart';

class ScanHistory extends StatefulWidget {
  const ScanHistory({Key? key}) : super(key: key);

  static const routeName = '/scan_history';

  @override
  State<ScanHistory> createState() => _ScanHistoryState();
}

class _ScanHistoryState extends State<ScanHistory> {
  final dbhelper = DataBaseHelper.instance;

  bool _isShown = true;
  List<Map<String, dynamic>> data = [];

  Future<void> fatchData() async {
    data = await dbhelper.fatchTable2();
    data = data.reversed.toList();
    setState(() {});
  }

  Future<void>? deleteData() {
    _delete(context);
  }

  void _delete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Row(
            children: [
              Container(
                height: 30,
                width: 30,
                padding: const EdgeInsets.only(right: 5),
                child: Image.asset(
                  "assets/images/trash.png",
                  color: blueColor2,
                ),
              ),
              const Text('Clear History'),
            ],
          ),
          content: const Text('Do you really want to clear scan history?'),
          actions: [
            TextButton(
                child: Text(
                  'CANCEL',
                  style: TextStyle(
                    color: Colors.red.shade700,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.red.shade700,
                  ),
                ),
                onPressed: () async {
                  await dbhelper.deleteTable2();
                  setState(() {
                    _isShown = false;
                    data = [];
                    Navigator.of(context).pop();
                  });
                })
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    fatchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Scan History"),
        actions: [
          IconButton(
            icon: const ImageIcon(
              AssetImage("assets/images/trash.png"),
              color: Colors.white,
            ),
            onPressed: deleteData,
          ),
          // add more IconButton
        ],
      ),
      body: Column(children: [
        Container(
          height: 30,
          width: MediaQuery.of(context).size.width,
          color: Colors.black12,
          child: const Padding(
            padding: EdgeInsets.all(5.0),
            child: Text('Scan History'),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QRCodeResultScreen(
                            data[index]['id'],
                            data[index]['barcode_type'],
                            false),
                      ),
                    );
                  },
                  child: ListTile(
                    leading:
                        '${data[index]['barcode_type']}' == 'DATA MATRIX (GS1)'
                            ? const CircleAvatar(
                                backgroundColor: blueColor1,
                                child: ImageIcon(
                                  AssetImage("assets/images/data_matrix.png"),
                                  color: Colors.white,
                                ),
                              )
                            : const CircleAvatar(
                                backgroundColor: blueColor1,
                                child: ImageIcon(
                                  AssetImage("assets/images/code_128.png"),
                                  color: Colors.white,
                                ),
                              ),
                    title: Text(
                        "${data[index]['id'].substring(1, data[index]['id'].length)}",
                        overflow: TextOverflow.ellipsis),
                    subtitle: Text(
                      "Type: ${data[index]['barcode_type']}\nScanned At: ${data[index]['date']}",
                    ),
                  ),
                ),
                const Divider(),
              ]);
            },
          ),
        ),
      ]),
    );
  }
}
