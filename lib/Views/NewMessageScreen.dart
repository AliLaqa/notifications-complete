import 'package:flutter/material.dart';

import '../HomeScreen.dart';

class NewMessageScreen extends StatefulWidget {
  const NewMessageScreen({super.key});

  @override
  State<NewMessageScreen> createState() => _SecondScreenState();
}


class _SecondScreenState extends State<NewMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("NewMessage Screen"),automaticallyImplyLeading: true,),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // decoration: BoxDecoration(image: DecorationImage(image: AssetImage(""))),
        color: Colors.amber.shade400.withOpacity(0.7),
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
