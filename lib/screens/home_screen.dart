import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu)),
        title: Text("Pharma Trax Scanner"),
      ),
       body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/dna.png'))
        ),
        height: MediaQuery.of(context).size.height.h,width: MediaQuery.of(context).size.width.h,),

    );
    
  }
}