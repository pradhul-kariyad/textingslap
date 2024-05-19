// ignore_for_file: unused_import, unnecessary_import, unused_local_variable
import 'dart:developer';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share/share.dart';
import 'package:textingslap/auth/signIn.dart';
import 'package:textingslap/auth/signUp.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:textingslap/auth/authService.dart';
import 'package:textingslap/chat/chatService.dart';
import 'package:textingslap/colors/colorData.dart';
import 'package:textingslap/components/userTile.dart';
import 'package:textingslap/chat/secondChat.dart';
import 'package:textingslap/pages/darkMode.dart';
import 'package:textingslap/widgets/drawerIcon.dart';

class secondHomePage extends StatefulWidget {
  const secondHomePage({super.key});

  @override
  State<secondHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<secondHomePage> {
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  final _searchController = TextEditingController();
  bool search = false;
  int searchfx = 0;
  List _allResults = [];
  List _resultList = [];

  @override
  void initState() {
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  _onSearchChanged() {
    searchResultList();
  }

  searchResultList() {
    var showResults = [];
    if (_searchController.text != "") {
      for (var clientData in _allResults) {
        var name = clientData['Name'].toString().toLowerCase();
        if (name.contains(_searchController.text.toLowerCase())) {
          showResults.add(clientData);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultList = showResults;
    });
  }

  getClientStream() async {
    var data = await FirebaseFirestore.instance
        .collection('Users')
        .orderBy('Name')
        .get();
    setState(() {
      _allResults = data.docs.map((doc) => doc.data()).toList();
    });
    searchResultList();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getClientStream();
    super.didChangeDependencies();
  }

  Future<void> logOut() async {
    await _authService.signOut(context);
  }

  Future<void> _refresh() async {
    await getClientStream();
  }

  @override
  Widget build(BuildContext context) {
    String? _imagePath; // Store the selected image path

    return Scaffold(
      backgroundColor: ColorData.black,
      drawer: Drawer(
        width: 280,
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 2, top: 33, bottom: 30),
                child: Column(children: [
                  Container(
                    width: 147,
                    height: 147,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/mytext.PNG"),
                            fit: BoxFit.cover)),
                  ),
                  Text(
                    "Texting Slap",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
              ),
              Container(
                  decoration: BoxDecoration(
                    color: ColorData.black,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7)),
                  ),
                  width: double.infinity,
                  height: 514,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      DrawerIcon(
                        name: "Create a new Account",
                        icon: Icons.add_card_rounded,
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return SignUp(onTap: () {});
                          }));
                        },
                      ),
                      DrawerIcon(
                          name: "Share App",
                          icon: Icons.share,
                          onTap: () {
                            Share.share(
                              "https://play.google.com/store/apps/details?id=com.example.textingslap",
                            );
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: ColorData.black,
                                content: Text(
                                  "Loading...",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )));
                          }),
                      DrawerIcon(
                          name: "Settings",
                          icon: Icons.settings,
                          onTap: () {
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context) {
                            //   return DarkMode();
                            // }));
                          }),
                      DrawerIcon(
                          name: "Rate Us",
                          icon: Icons.playlist_add_check,
                          onTap: () {}),
                      DrawerIcon(
                          name: "Log Out",
                          icon: Icons.logout,
                          onTap: () async {
                            await Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return SignIn(onTap: () {});
                            }));
                            await logOut();
                          }),
                    ],
                  )),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 116,
        elevation: 0,
        backgroundColor: ColorData.black,
        foregroundColor: Colors.white,
        title: search
            ? Container(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 2),
                width: 250,
                height: 37,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 232, 227, 227)),
                child: TextFormField(
                  decoration: InputDecoration(
                      hoverColor: ColorData.bodyColor,
                      hintText: 'Search user...',
                      hintStyle: TextStyle(fontSize: 15, color: Colors.black),
                      border: InputBorder.none),
                  controller: _searchController,
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 45),
                child: Text(
                  "Messages",
                  style: TextStyle(color: ColorData.white, fontSize: 25),
                ),
              ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  search = !search;
                });
              },
              icon: Icon(Icons.search)),
        ],
      ),
      body: search
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24))),
                    width: double.infinity,
                    height: 609,
                    child: RefreshIndicator(
                      onRefresh: _refresh,
                      color: Colors.black,
                      child: ListView.builder(
                        itemCount: _resultList.length,
                        itemBuilder: (context, index) {
                          return _buildUserListItem(
                              _resultList[index], context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24))),
                      width: double.infinity,
                      height: 609,
                      child: _buildUserList()),
                ],
              ),
            ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.only(left: 134, top: 275),
              child: Text(
                "Error...",
                style: TextStyle(
                    color: ColorData.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: const EdgeInsets.only(left: 134, top: 275),
              child: Text(
                "Loading...",
                style: TextStyle(
                    color: ColorData.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            );
          }
          return RefreshIndicator(
            color: Colors.black,
            onRefresh: _refresh,
            child: ListView(
              children: snapshot.data!
                  .map<Widget>(
                      (userData) => _buildUserListItem(userData, context))
                  .toList(),
            ),
          );
        });
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    final currentUserEmail = _authService.getCurrentUser()?.email;

    if (currentUserEmail != null && userData['Name'] != currentUserEmail) {
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
