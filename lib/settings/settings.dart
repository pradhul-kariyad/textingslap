// import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 12, 148, 146),
        foregroundColor: Colors.white,
        // foregroundColor: Colors.white,
      ),
      body: Row(
        children: [
          Text("Dark Mode"),
          CupertinoSwitch(value: true, onChanged: (value) {})
        ],
      ),
      //  body: Row(
      //   children: [
      //     Text("Dark Mode"),
      //     CupertinoSwitch(value: true, onChanged: (value) {})
      //   ],
      // ),
    );
  }
}
