// ignore_for_file: unnecessary_cast, avoid_unnecessary_containers, unused_import

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:textingslap/models/usermodel.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Users").snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return Scaffold(
            body: Center(
                child: Container(
                    child: Column(
              children: [
                Image.asset("assets/images/emptycart.jpg"),
                Text('Your Cart is empty'),
              ],
            ))),
          );
        } else {
          return Scaffold(
              backgroundColor: Color(0xFFF5F6F9),
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                //   backgroundColor: AppColors.white,
                leading: BackButton(),

                title: Column(
                  children: [
                    Text(
                      "Your Cart",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              body: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    // Access the data from Firestore document and convert it to Map<String, dynamic>
                    Map<String, dynamic> userData = snapshot.data!.docs[index]
                        .data() as Map<String, dynamic>;

                    // Create a UsersModel object using the data
                    UsersModel model = UsersModel.getModelFromJson(userData);

                    return ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        // You might want to set a profile picture here based on model.profilepic
                      ),
                      title: Text(model.Name),
                      subtitle: Text(model.email),
                    );
                  })

              //  ListView.builder(
              //     itemCount: snapshot.data!.docs.length,
              //     itemBuilder: (context, index) {
              //       UsersModel model = UsersModel.getModelFromJson(
              //           json: snapshot.data!.docs[index].data());
              //       return ListTile(
              //         leading: CircleAvatar(
              //           radius: 20,
              //         ),
              //         title: Text(model.name),
              //         subtitle: Text(model.email),
              //       );
              //     }),
              );
        }
      },
    );
  }
}
