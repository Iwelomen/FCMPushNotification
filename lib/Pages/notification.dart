import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pushnotifi/Api/firebase_api.dart';


class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);
  static const route = "/notifications";



  @override
  Widget build(BuildContext context) {
    FirebaseApi firebaseApi = FirebaseApi();
    final message = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Text('${message}'),
        ],
      )),
    );
  }
}
