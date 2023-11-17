


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notification_complete/HomeScreen.dart';
import 'package:notification_complete/Views/NewOrderScreen.dart';
import 'Helpers/NotificationReceiver.dart';
import 'Helpers/ThisDeviceToken.dart';
import 'Views/NewMessageScreen.dart';
import 'Views/OtherScreen.dart';
import 'firebase_options.dart';


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  ///TODO: Here we are selecting the type of notification which we made in CustomNotification.dart
  ///We  have made three types of notifications in CustomNotification.dart file.
  if (message.notification!.title!.startsWith("newOrder")) {
    NotificationReceiver.NewOrder(message);
  } else if (message.notification!.title!.startsWith("newMessage")) {
    NotificationReceiver.NewMessage(message);
  } else if (message.notification!.title!.startsWith("other")) {
    NotificationReceiver.Others(message);
  } else{
    print("Notification Received but title is is not matching, title => ${message.notification!.title!}");
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await FirebaseMessaging.instance.getInitialMessage();
  } catch (e) {print("Error on main Firebase function => $e");}
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ///To interact with notification when app in background
    notificationServices.onMessage(context, navigatorKey);
    ///To interact with notification when app in active
    notificationServices.onMessageOpenedApp(context, navigatorKey);
    ///To Get device token
    thisDeviceToken();
  }



  @override
  Widget build(BuildContext context) {
    ///To initialize Notifications
    NotificationReceiver.init();
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/newOrder': (context) => const NewOrderScreen(),
        '/newMessage': (context) => const NewMessageScreen(),
        '/other': (context) => const OtherScreen(),
      },
    );
  }
}

