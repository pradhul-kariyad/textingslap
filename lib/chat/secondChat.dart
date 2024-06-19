// ignore_for_file: unused_import
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:textingslap/auth/authService.dart';
import 'package:textingslap/chat/chatService.dart';
import 'package:textingslap/colors/colorData.dart';
import 'package:textingslap/components/chatBubble.dart';

class SecondChat extends StatelessWidget {
  final String receiverEmail;
  final String receiverId;

  SecondChat(
      {super.key, required this.receiverEmail, required this.receiverId});

  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverId, _messageController.text);

      // Clear text controller
      _messageController.clear();
    }
  }

  Future<void> _refreshMessages() async {
    // You can implement any logic to refresh messages here
    // For example, you might call a method to fetch the latest messages
    await _chatService
        .getMessages(receiverId, _authService.getCurrentUser()!.uid)
        .first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: ColorData.black,
        foregroundColor: Colors.white,
        title: Text(receiverEmail),
      ),
      body: Column(
        children: [
          // Display all messages with RefreshIndicator
          Expanded(
            child: RefreshIndicator(
              color: Colors.black,
              onRefresh: _refreshMessages,
              child: _buildMessageList(),
            ),
          ),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(receiverId, senderId),
      builder: (context, snapshot) {
        // Errors
        if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text("Error",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: ColorData.black)),
          );
        }
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              "Loading...",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: ColorData.black),
            ),
          );
        }

        // Return list view
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    // Is current user
    bool isCurrentUser = data['senderId'] == _authService.getCurrentUser()!.uid;

    // Align message to the right if sender is the current user, otherwise left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(isCurrentUser: isCurrentUser, message: data['message'])
        ],
      ),
    );
  }

  Widget _buildUserInput() {
    return Row(
      children: [
        SizedBox(width: 9),
        Container(
          width: 285,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              padding: EdgeInsets.only(left: 18),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: (Colors.black)),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _messageController,
                      decoration: InputDecoration(
                          hintText: "Typing a message",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 5),
        Padding(
          padding: const EdgeInsets.only(right: 11, bottom: 19),
          child: Container(
            width: 49,
            height: 49,
            decoration: BoxDecoration(
              color: ColorData.black,
              borderRadius: BorderRadius.circular(27),
            ),
            child: IconButton(
              onPressed: sendMessage,
              icon: Icon(
                Icons.send,
                size: 24,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
