import 'package:flutter/material.dart';
import 'package:notification_complete/Helpers/NotificationReceiver.dart';
import 'package:notification_complete/Views/NewMessageScreen.dart';
import 'package:notification_complete/Views/NewOrderScreen.dart';
import 'package:notification_complete/Views/OtherScreen.dart';

import 'Helpers/NotificationPostApi.dart';
import 'Helpers/ThisDeviceToken.dart';
import 'main.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationServices().onMessageOpenedApp(context, navigatorKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeScreen"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            // image: DecorationImage(image: AssetImage("assets/home.jpg")),
              color: Colors.blueAccent.shade400.withOpacity(0.7)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ///TODO: Sending Notification Buttons Section Start-------------------->

                ///New Order Notification navigating to HomeScreen.
                ElevatedButton(
                    onPressed: () {
                      String token = myToken;
                      String title = "newOrder";
                      String type = "order";
                      String bodye = "Hello, this is a New Order notification";
                      SendNotificationApi().sendMessage(token, bodye, title, type);
                    },
                    child: const Text("NewOrder")),

                ///NewMessage Notification navigating to SecondScreen
                ElevatedButton(
                    onPressed: () {
                      String token = myToken;
                      String title = "newMessage";
                      String type = "message";
                      String bodye = "Hello, this is a test NewMessage notification";
                      SendNotificationApi().sendMessage(token, bodye, title, type);
                    },
                    child: const Text("New Message Notification")),

                ///Others Notification navigating to SecondScreen
                ElevatedButton(
                    onPressed: () {
                      String token = myToken;
                      String title = "other";
                      String type = "other";
                      String bodye = "Hello, this is a test Others notification";
                      SendNotificationApi().sendMessage(token, bodye, title, type);
                    },
                    child: const Text("other Notification")),

                ///Todo: Navigation Buttons Section Start------------------------------>
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 5),
                  child: Text(
                    "Navigation Buttons Below",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.black),
                  ),
                ),

                ///NewOrder Navigation Button
                OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewOrderScreen()));
                    },
                    child: const Text(
                      "Go to NewOrder",
                      style: TextStyle(color: Colors.black),
                    )),

                ///NewMessage Navigation Button
                OutlinedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => NewMessageScreen()));
                    },
                    child: const Text(
                      "Go to NewMessage",
                      style: TextStyle(color: Colors.black),
                    )),

                ///OtherScreen Navigation Button
                OutlinedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => OtherScreen()));
                    },
                    child: const Text(
                      "Go to OthersScreen",
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
