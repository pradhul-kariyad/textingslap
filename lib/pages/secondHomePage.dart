import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:textingslap/auth/authService.dart';
import 'package:textingslap/chat/chatService.dart';
import 'package:textingslap/components/userTile.dart';
import 'package:textingslap/myPhotos.dart';
import 'package:textingslap/pages/chatPage.dart';
import 'package:textingslap/pages/secondChat.dart';

class secondHomePage extends StatefulWidget {
  const secondHomePage({super.key});

  @override
  State<secondHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<secondHomePage> {
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void logOut() {
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: 250,
        backgroundColor: Color.fromARGB(255, 12, 148, 146),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(photo1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 400, left: 140),
              child: Row(
                children: [
                  Text("Settings"),
                  IconButton(onPressed: () {}, icon: Icon(Icons.settings))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 140),
              child: Row(
                children: [
                  Text("Log Out"),
                  IconButton(
                      onPressed: () {
                        logOut();
                      },
                      icon: Icon(Icons.logout))
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 12, 148, 146),
        foregroundColor: Colors.white,
        title: Center(
            child: Text(
          "Home First Page",
          style: TextStyle(fontSize: 18),
        )),
        actions: [
          IconButton(
              onPressed: () {
                // logOut();
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: _buildUserList(),
      // body: Column(
      //   children: [

      //     // Text("Home First Page"),
      //   ],
      // ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(
              "Error...",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Text(
              "Loading...",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ));
          }
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData['Name'] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["Name"],
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SecondChat(
              receiverEmail: userData['Name'],
              receiverId: userData['Uid'],
            );
          }));
        },
      );
    } else {
      return Container();
    }
  }
}
