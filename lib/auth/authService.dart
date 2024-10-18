// import 'package:provider/provider.dart';
// ignore_for_file: use_build_context_synchronously, avoid_print, await_only_futures, duplicate_import
import 'dart:developer';
import 'package:sizer/sizer.dart';
import '../../pages/notificationSreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:textingslap/main.dart';

class AuthService {
  // Instance of Firebase services
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to handle notification when app is in background or terminated
  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    log('Title: ${message.notification?.title}');
    log('Body : ${message.notification?.body}');
    log('Payload: ${message.data}');
  }

  // Method to handle messages and navigate to notification screen
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    if (navigatorKey.currentState != null) {
      navigatorKey.currentState?.pushNamed(
        NotificationScreen.route,
        arguments: message,
      );
    } else {
      log("Navigator state is null. Cannot push notification screen.");
    }
  }

  // Function to initialize push notifications
  Future<void> initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  // Function to initialize notifications
  Future<void> initNotificatoins() async {
    // Request permission from the user
    await _firebaseMessaging.requestPermission();

    // Fetch the FCM token for the device
    final fCMToken = await _firebaseMessaging.getToken();
    log("Token: $fCMToken");

    // Initialize further settings for push notifications
    initPushNotifications();
  }

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (credential.user == null) {
        log("User is null after sign-in.");
        return null;
      }

      return credential.user;
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "You're not a member, please register now",
            style: TextStyle(fontSize: 13.sp),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(color: Color.fromARGB(255, 12, 148, 146)),
              ),
            ),
          ],
        ),
      );

      log("Error during sign-in: $e");
    }
    return null;
  }

  // Sign up with email and password
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, password, name, confirmPassword) async {
    try {
      // Create user:
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Save user info in a separate doc
      await _firestore.collection("Users").doc(userCredential.user!.uid).set({
        "Uid": userCredential.user!.uid,
        "E-mail": email,
        "Name": name,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Sign out
  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
  }
}
