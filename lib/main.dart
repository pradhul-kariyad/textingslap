// import 'dart:js';
// import 'package:textingslap/auth/loginOrRegister.dart';
// import 'package:textingslap/pages/chatPage.dart';
// import 'package:textingslap/pages/forgotPassword.dart';
// import 'package:textingslap/pages/home.dart';
// import 'package:textingslap/pages/signUp.dart';
// import 'package:text
//
// ingslap/pages/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:textingslap/auth/authGate.dart';
import 'package:textingslap/auth/authService.dart';
import 'package:textingslap/pages/notification.dart';
import 'package:textingslap/themes/themesProvider.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AuthService().initNotificatoins();
  runApp(ChangeNotifierProvider(
    create: (context) {
      return ThemeProvider();
    },
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
      routes: {
        '/notification_sreen': (context) => NotificationPage(),
      },
      // theme: Provider.of<ThemeProvider>(context).themeData,
      navigatorKey: navigatorKey,
    );
  }
}
