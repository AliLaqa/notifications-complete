
import 'package:firebase_messaging/firebase_messaging.dart';
///myToken is for Notification Sender (SendingMessageApi)
String myToken = "";

Future <void> thisDeviceToken() async {
    FirebaseMessaging fcm = FirebaseMessaging.instance;
    myToken = (await fcm.getToken())!;
    print("My Token => $myToken");
  }