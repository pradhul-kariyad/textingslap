// import 'package:flutter/foundation.dart';
// import 'package:textingslap/pages/signUp.dart';
// import 'package:textingslap/pages/chatPage.dart';
// import 'package:textingslap/pages/home.dart';
// import 'package:textingslap/pages/secondChat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:textingslap/pages/secondHomePage.dart';
import 'package:flutter/material.dart';
import 'package:textingslap/auth/loginOrRegister.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return secondHomePage();
            } else {
              return LoginOrRegister();
            }
          }),
    );
  }
}
