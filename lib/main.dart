import 'package:bus_stop/views/pages/cargo/home_cargo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:bus_stop/config/collections/index.dart';
import 'package:bus_stop/contollers/authController.dart';
import 'package:bus_stop/contollers/lcoProvider.dart';
import 'package:bus_stop/contollers/locController.dart';
import 'package:bus_stop/views/welcome/initial.dart';
import 'package:bus_stop/services/notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A BusStop background message showed up :  ${message.messageId}');
}

void initializeNotifications() async {
  try {
    NotificationService notifyHelper = NotificationService();
    ;
    await notifyHelper.initializeNotifications();
    notifyHelper.requestIOSPermissions();
    notifyHelper.requestAndroidPermissions();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        print("RemoteMessage : " + message.toString());
        print("Remote title : " + notification.title.toString());
        print("Remote body : " + notification.body!
          ..toString());

        await notifyHelper.displayNotification(
          notification.title!,
          notification.body!,
        );
      }
    });
  }catch(e) {
    print("Notification Display Error : " + e.toString());
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Get.put(LocationController());
  AppCollections();
  runApp(const BusStopApp());
}

class BusStopApp extends StatefulWidget {
  const BusStopApp({super.key});

  @override
  State<BusStopApp> createState() => _BusStopAppState();
}

class _BusStopAppState extends State<BusStopApp> {

  @override
  void initState() {
    super.initState();
    initializeNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocationsProvider>.value(
            value: LocationsProvider()),
        ChangeNotifierProvider<UserProvider>.value(value: UserProvider()),
      ],
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Bus Stop",
          theme: ThemeData(primaryColor: Colors.red, primarySwatch: Colors.red),
          home: HomeCargoView(),
          // home: const Initial(),
      ),
    );
  }
}
