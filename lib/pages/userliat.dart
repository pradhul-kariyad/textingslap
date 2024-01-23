import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:textingslap/model/usermodel.dart';

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
                  UsersModel model = UsersModel.getModelFromJson(
                      json: snapshot.data!.docs[index].data());
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                    ),
                    title: Text(model.name),
                    subtitle: Text(model.email),
                  );
                }),
          );
        }
      },
    );
  }
}
