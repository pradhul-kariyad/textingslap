import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  static const route = '/notification-screen';

  @override
  Widget build(BuildContext context) {
    // Extract the message from the arguments safely
    final RemoteMessage? message =
        ModalRoute.of(context)!.settings.arguments as RemoteMessage?;

    // Check if message is null
    if (message == null) {
      // Return a placeholder or handle the null case according to your app logic
      return Scaffold(
        appBar: AppBar(
          title: Text("Notification"),
        ),
        body: Center(
          child: Text("No message received"),
        ),
      );
    }

    // Build UI using message data
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Title: ${message.notification?.title ?? 'No Title'}"),
          Text("Body: ${message.notification?.body ?? 'No Body'}"),
          Text("Data: ${message.data}"),
        ],
      ),
    );
  }
}
