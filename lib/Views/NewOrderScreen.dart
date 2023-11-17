import 'package:flutter/material.dart';

import '../HomeScreen.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({super.key});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("NewOrder Screen"),automaticallyImplyLeading: true,),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // decoration: BoxDecoration(image: DecorationImage(image: AssetImage(""))),
        color: Colors.lightGreenAccent.shade200.withOpacity(0.7),
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
