import 'package:flutter/material.dart';
import 'package:textingslap/pages/home.dart';
import 'package:textingslap/pages/signIn.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF553370),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 50),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Home();
                              }));
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Color.fromARGB(255, 187, 183, 183),
                            )),
                        SizedBox(
                          width: 90,
                        ),
                        Text(
                          "Akshay",
                          style: TextStyle(
                              color: Color.fromARGB(255, 187, 183, 183),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 17,
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 40),
                width: MediaQuery.of(context).size.width,
                height: 636,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23)),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.bottomRight,
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 2),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 233, 230, 230),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                      child: Text(
                        "Hello, How was the day?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.bottomRight,
                      margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width / 2.5),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 136, 218, 218),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: Text(
                        "The day was really good.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacer(),
                    Material(
                      borderRadius: BorderRadius.circular(30),
                      elevation: 5,
                      child: Container(
                        padding: EdgeInsets.only(left: 18),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                onSubmitted: (text) {
                                  text = text;
                                },
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
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return SignIn(
                                          onTap: () {},
                                        );
                                      }));
                                    },
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
