import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pushnotifi/Api/firebase_api.dart';
import 'package:pushnotifi/Pages/homepage.dart';
import 'package:pushnotifi/Pages/notification.dart';


final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      navigatorKey: navigatorKey,
      home: const HomePage(),
      routes: {
        Notifications.route: (context) =>  Notifications()
      },
    );
  }
}

