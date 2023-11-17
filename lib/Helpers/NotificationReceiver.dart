

import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_complete/Views/NewMessageScreen.dart';
import 'package:notification_complete/Views/NewOrderScreen.dart';
import 'package:notification_complete/Views/OtherScreen.dart';

import '../main.dart';

///TODO: Processing Received Notifications------------------------------------->

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  //Instance of Flutter Notification Plugin.
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();


  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
    const AndroidInitializationSettings("@mipmap/ic_launcher");

    var iosInitializationSettings = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
          // Extract data from the payload
          String type = message.data['type'] ?? '';
          String payloadMessage = message.data['message'] ?? '';

          // Handle the received payload
          handlePayload(context, type, payloadMessage);
        });
  }

// Handle the message when the app is in the foreground
  void onMessage(BuildContext context, GlobalKey<NavigatorState> navigatorKey) {
    ///TODO: onMessage listener
    FirebaseMessaging.onMessage.listen((message) {
      initLocalNotifications(context, message);
      if (message.notification!.title!.startsWith("newOrder")) {
        NotificationReceiver.NewMessage(message);
      } else if (message.notification!.title!.startsWith("newMessage")) {
        NotificationReceiver.NewMessage(message);
      } else if (message.notification!.title!.startsWith("other")) {
        NotificationReceiver.Others(message);
      } else{
        print("Notification Received but title is is not matching, title => ${message.notification!.title!}");
      }

      ///Seeing data received from notification for payload
      print("Notification Data Received------------------------------------->");
      print('Got a message whilst in the foreground! OnMessage Called');
      print('Message data: ${message.data}');

      // Extract data from the payload
      String type = message.data['type'] ?? '';
      String payloadMessage = message.data['message'] ?? '';

      // // Handle the received payload
      // handlePayload(context, type, payloadMessage);

    });
  }

// Handle the message when the app is opened by tapping on the notification
  Future<void> onMessageOpenedApp(BuildContext context, GlobalKey<NavigatorState> navigatorKey) async {
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      void handleNotification(RemoteMessage message) {
        if (message.notification!.title!.startsWith("newOrder")) {
          NotificationReceiver.NewMessage(message);
        } else if (message.notification!.title!.startsWith("newMessage")) {
          NotificationReceiver.NewMessage(message);
        } else if (message.notification!.title!.startsWith("other")) {
          NotificationReceiver.Others(message);
        } else{
          print("Notification Received but title is is not matching, title => ${message.notification!.title!}");
        }

        // Extract data from the payload
        String type = message.data['type'] ?? '';
        String payloadMessage = message.data['message'] ?? '';

        // Handle the received payload
        handlePayload(context, type, payloadMessage);

      }
      handleNotification(message);
      RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        // Extract data from the payload
        String type = message.data['type'] ?? '';
        String payloadMessage = message.data['message'] ?? '';

        // Handle the received payload
        handlePayload(context ,type, payloadMessage);
      }
      handleNotification(initialMessage!);
    });


  }

  // Future<String> getDeviceToken() async {
  //   String? token = await messaging.getToken();
  //   return token!;
  // }

  void handlePayload( BuildContext context, String type, String message, ) {
    print('Handle message hit with =>');
    print("Message =>$message");
    print("Type =>$type");

    ///TODO:  Please Check for Navigation  with notification payload by uncommenting the below code and changing the Page route.

    try{
      if(type == "order") {
        navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => NewOrderScreen()));
      } else if (type == "message") {
        navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => NewMessageScreen()));
      } else if (type == "other") {
        navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => OtherScreen()));
      } else {
        print("But type is not matching, type received is => $type");
      }

    }catch(e) { print("Error while navigating with payload => $e");}
  }
}


///TODO: Showing Received Notifications---------------------------------------->
class NotificationReceiver {
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future init({bool scheduled = false}) async {
    var initAndroidSetting = const AndroidInitializationSettings("@mipmap/ic_launcher");
    var ios = const DarwinInitializationSettings();
    final setting = InitializationSettings(android: initAndroidSetting, iOS: ios);
    await _notification.initialize(setting);
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()!.requestNotificationsPermission();
  }


  static void NewOrder(RemoteMessage message) async {
    print("NewOrder Notification is hit");
    print("Received title: ${message.notification!.title!}");
    print("Received body: ${message.notification!.body!.toString()}");
    try {
      Random random = Random();
      int id = random.nextInt(10000);
      NotificationDetails notificationDetails =
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "pushnotificationapp3",
          "high_importance_channel",
          importance: Importance.max,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound("alert"),
        ),
      );
      await _notification.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['type'],
      );
    } on Exception catch (e) {
      print('Error showing NewOrder Notification>>>$e');
    }
  }
  static void NewMessage(RemoteMessage message) async {
    print("NewMessage Notification is hit");
    print("Received title: ${message.notification!.title!}");
    print("Received body: ${message.notification!.body!.toString()}");
    try {
      Random random = Random();
      int id = random.nextInt(10000);
      const NotificationDetails notificationDetails =
      NotificationDetails(
        android: AndroidNotificationDetails(
          "pushnotificationapp3",
          "high_importance_channel",
          importance: Importance.max,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound("newmessage"),
        ),
      );
      await _notification.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['type'],
      );
    } on Exception catch (e) {
      print('Error showing NewMessage Notification>>>$e');
    }
  }

  static void Others(RemoteMessage message) async {
    print("Other Notification is hit");
    print("Received title: ${message.notification!.title!}");
    print("Received body: ${message.notification!.body!.toString()}");
    try {
      Random random = Random();
      int id = random.nextInt(10000);
      const NotificationDetails notificationDetails =
      NotificationDetails(
        android: AndroidNotificationDetails(
          "pushnotificationapp3",
          "high_importance_channel",
          importance: Importance.max,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound("other"),
        ),
      );
      await _notification.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['type'],
      );
    } on Exception catch (e) {
      print('Error showing Notification>>>$e');
    }
  }
}

