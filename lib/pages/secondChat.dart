// import 'dart:html';
// import 'dart:js';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:textingslap/auth/authService.dart';
import 'package:textingslap/chat/chatService.dart';
import 'package:textingslap/components/chatBubble.dart';

class SecondChat extends StatelessWidget {
  final String receiverEmail;
  final String receiverId;
  // final String
  SecondChat(
      {super.key, required this.receiverEmail, required this.receiverId});
  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverId, _messageController.text);

      //clear text controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 12, 148, 146),
        foregroundColor: Colors.white,
        title: Text(receiverEmail),
      ),
      body: Column(
        children: [
          //display all messages
          Expanded(child: _buildMessageList()),
          _buildUserInput(),

          //user input
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(receiverId, senderId),
        builder: (context, snaphot) {
          //errors
          if (snaphot.hasError) {
            print("ttttttttttttttttttttttttt");
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text("Error",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 12, 148, 146))),
            );
          }
          //loading
          if (snaphot.connectionState == ConnectionState.waiting) {
            print("99999999999999999999999999999999999");

            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "Loading...",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 12, 148, 146)),
              ),
            );
          }

          print(snaphot.data!.docs);

          //return list view
          return ListView(
              children: snaphot.data!.docs
                  .map((doc) => _buildMesageItem(doc))
                  .toList());
        });
  }

  Widget _buildMesageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    //is current user
    bool isCurrentUser = data['senderId'] == _authService.getCurrentUser()!.uid;

    //align message to the right if sender  is the  current user,otherwise left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // data['message']
            ChatBubble(isCurrentUser: isCurrentUser, message: data['message'])
          ],
        ));
  }

  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              padding: EdgeInsets.only(left: 18),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color.fromARGB(255, 240, 237, 237)),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _messageController,
                      // onSubmitted: (text) {
                      //   text = text;
                      // },
                      decoration: InputDecoration(
                          hintText: "Typing a message",
                          hintStyle: TextStyle(color: Colors.black45),
                          border: InputBorder.none),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 250, 242, 242),
                          borderRadius: BorderRadius.circular(19)),
                      child: IconButton(
                          onPressed: sendMessage,
                          icon: Icon(
                            Icons.send,
                            size: 24,
                            color: Colors.grey[600],
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        // IconButton(onPressed: sendMessage, icon: Icon(Icons.arrow_upward))
      ],
    );
  }
}
