// import 'package:flutter/foundation.dart';
// import 'package:textingslap/pages/chatPage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:textingslap/pages/profileImage.dart';
// import 'package:textingslap/pages/signIn.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';
// import 'package:textingslap/myPhotos.dart';
// import 'package:textingslap/pages/profileImage.dart';
import 'dart:ui';
import 'package:textingslap/pages/signUp.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:textingslap/auth/authService.dart';
import 'package:textingslap/chat/chatService.dart';
import 'package:textingslap/components/userTile.dart';
import 'package:textingslap/pages/searchView.dart';
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
      String? _imagePath; // Store the selected image path

    return Scaffold(
      drawer: Drawer(
        width: 250,
        backgroundColor: Color.fromARGB(255, 12, 148, 146),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //  ProfileImage(),
          //     Stack(
          // children: [
          //   Padding(
          //     padding: const EdgeInsets.only(top: 60),
          //     child: CircleAvatar(
          //       backgroundColor: Color.fromARGB(255, 15, 159, 157),
          //       radius: 60,
          //       backgroundImage: _imagePath != null
          //           ? AssetImage(_imagePath)
          //           : null, // Display the selected image if available
          //     ),
          //   ),
          //   Positioned(
          //     left: 77,
          //     top: 137,
          //     child: IconButton(
          //       onPressed: () {
          //         showPopBAr(context);
          //       },
          //       icon: Icon(
          //         Icons.camera_alt,
          //         size: 32,
          //                 )))
          //       ],
          //     ),
              Padding(
                padding: const EdgeInsets.only(top: 400, left: 135),
                child: Row(
                  children: [
                    Text("Settings"),
                    IconButton(onPressed: () {}, icon: Icon(Icons.settings))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 103),
                child: Row(
                  children: [
                    Text("Create Account"),
                    IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SignUp(onTap: () {});
                          }));
                        },
                        icon: Icon(Icons.credit_card_rounded))
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
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchView();
                }));

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

void showPopBAr(BuildContext context) {
  showModalBottomSheet(
    shape: BeveledRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    context: context,
    builder: (builder) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        height: 170,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                _getImageFromCamera(context);
              },
              icon: Icon(
                Icons.camera,
                size: 60,
              ),
            ),
            IconButton(
              onPressed: () {
                _getImageFromGallery(context);
              },
              icon: Icon(
                Icons.photo_camera_back,
                size: 60,
              ),
            ),
          ],
        ),
      );
    },
  );
}

Future<void> _getImageFromCamera(BuildContext context) async {
  final picker = ImagePicker();
  final XFile? pickedImage = await picker.pickImage(source: ImageSource.camera);
  if (pickedImage != null) {
    String imagePath = pickedImage.path;
    // Now you can use the imagePath to display the image or perform other operations.
  }
}

Future<void> _getImageFromGallery(BuildContext context) async {
  final picker = ImagePicker();
  final XFile? pickedImage =
      await picker.pickImage(source: ImageSource.gallery);
  if (pickedImage != null) {
    String imagePath = pickedImage.path;
    // Now you can use the imagePath to display the image or perform other operations.
  }
}
