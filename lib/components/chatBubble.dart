import 'package:flutter/material.dart';
import 'package:textingslap/colors/colorData.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubble(
      {super.key, required this.isCurrentUser, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isCurrentUser
                ? ColorData.black
                : Color.fromARGB(255, 196, 195, 195)),
        padding: EdgeInsets.all(13),
        margin: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
        child: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
