import 'package:flutter/material.dart';

import '../HomeScreen.dart';

class OtherScreen extends StatefulWidget {
  const OtherScreen({super.key});

  @override
  State<OtherScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<OtherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Other Screen"),automaticallyImplyLeading: true,),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // decoration: BoxDecoration(image: DecorationImage(image: AssetImage(""))),
        color: Colors.pink.shade400.withOpacity(0.7),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
              }, child: const Text("Back to HomeScreen", style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold))),
            ],
          ),
        ),
      ),
    );
  }
}
