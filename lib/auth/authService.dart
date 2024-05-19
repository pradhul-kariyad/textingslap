// import 'package:provider/provider.dart';
// ignore_for_file: use_build_context_synchronously, avoid_print, await_only_futures
// import 'dart:math';
import 'dart:developer';
import '../../pages/notificationSreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:textingslap/main.dart';

class AuthService {
  //instance of auth &firestore:
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future<void> handleBackgroundMessage(RemoteMessage message) async {
  //   print('Title: ${message.notification?.title}');
  //   print('Body : ${message.notification?.body}');
  //   print('Payload: ${message.data}');
  // }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.pushNamed(
      NotificationScreen.route,
      arguments: message,
    );
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  //
  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    log('Title : ${message.notification?.title}');
    log('Body : ${message.notification?.body}');
    log('Playload : ${message.data}');
  }
  //

  //function to initial notifications...
  Future<void> initNotificatoins() async {
    //request permission from user (will prompt user)...
    await _firebaseMessaging.requestPermission();

    //fetch the FCM token for this device...
    final fCMToken = await _firebaseMessaging.getToken();

    //print the token (normally ypu would send this to you server)
    print("Token :$fCMToken");
    // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    //initialize further settings for push notification...
    initPushNotifications();
  }

//function to handle received messages...
//   void handleMessage(RemoteMessage? message) {
// // if the message is null , do nothing...
//     if (message == null) return;
// // navigator to new sreen when message is received and  user taps notification...
//     navigatorKey.currentState
//         ?.pushNamed('/notification_sreen', arguments: message);
//   }

//function to initialize  background settings...

  // Future initPushNotifications() async {
  //   // handle notification if the app was terminated and now opened...
  //   FirebaseMessaging.instance.getInitialMessage().then((handleMessage));

  //   // attach event listeners for when a notification opens the app...
  //   FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  // }

  //get current user:

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Future<UserCredential> signInWithEmailAndPassword(
  //     String email, password, name) async {
  //   try {
  //     //sign In:

  //     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     //save user info if it doesn't already exist:
  //     _firestore.collection("Users").doc(userCredential.user!.uid).set({
  //       "Uid": userCredential.user!.uid,
  //       "E-mail": email,
  //       "Name": name,
  //     });

  //     return userCredential;
  //   } on FirebaseAuthException catch (e) {
  //     throw Exception(e.code);
  //   }
  // }

  Future<User?> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color.fromARGB(255, 12, 148, 146),
          content: Text(
            "Your not a member please Register now...",
            style: TextStyle(fontWeight: FontWeight.bold),
          )));
      print("Some error occured");
    }
    return null;
  }

  Future<UserCredential> signUpWithEmailAndPassword(
      String email, password, name, confirmPassword
      // ansila
      ) async {
    try {
      //create user:

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      //save user info in a separate doc
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        "Uid": userCredential.user!.uid,
        "E-mail": email,
        "Name": name,
        // "Ansila":ansila
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //signOut:
  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    // await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     backgroundColor: Color.fromARGB(255, 12, 148, 146),
    //     content: Text(
    //       "Log out...",
    //       style: TextStyle(fontWeight: FontWeight.bold),
    //     )));
  }
}
