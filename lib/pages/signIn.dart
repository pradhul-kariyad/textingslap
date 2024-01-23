// import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:textingslap/auth/authService.dart';
import 'package:textingslap/pages/forgotPassword.dart';
import 'package:textingslap/pages/home.dart';
import 'package:textingslap/pages/signUp.dart';
import 'package:textingslap/service/dataBase.dart';

class SignIn extends StatefulWidget {
  final void Function()? onTap;
  const SignIn({super.key, required this.onTap});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = "", password = "", name = "", pic = "", userName = "", id = "";

  final AuthService _authService = AuthService();

  TextEditingController userMailController = TextEditingController();
  // TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

//
// First one
//

  // void login(BuildContext context) async {
  //   final authService = AuthService();
  //   try {
  //     print("77777777777777777777777777777777777777777777");

  //     await authService.signInWithEmailAndPassword(
  //         userName, userMailController.text, userPasswordController.text);
  //   } catch (e) {
  //     print("${e}8888888888888888888888888888888888");
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(title: Text(e.toString()));
  //         });
  //   }
  // }
//
// SecondOne
//

  // userLogin() async {
  //   try {
  // var kk=    await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password);

  //     QuerySnapshot querySnapshot =
  //         await DataBaseMethods().getUserByEmail(email);
  //     name = "${querySnapshot.docs[0]["Name"]}";
  //     userName = "${querySnapshot.docs[0]["User Name"]}";
  //     pic = "${querySnapshot.docs[0]["Photo"]}";
  //     id = querySnapshot.docs[0].id;

  //     // await SharedPreferenceHelper().saveUserDisplayName(name);
  //     // await SharedPreferenceHelper().saveUserName(userName);
  //     // await SharedPreferenceHelper().saveUserId(id);
  //     // await SharedPreferenceHelper().saveUserPic(pic);

  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
  //       return Home();
  //     }));
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == "user note found") {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           backgroundColor: Colors.orangeAccent,
  //           content: Text(
  //             "No user found that Email",
  //             style: TextStyle(fontSize: 18),
  //           )));
  //     } else if (e.code == "wrong password") {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           backgroundColor: Colors.orangeAccent,
  //           content: Text(
  //             "Wrong password provided by user",
  //             style: TextStyle(fontSize: 18),
  //           )));
  //     }
  //   }
  // }
  //
// 3rd
  //

  @override
  void dispose() {
    userMailController.dispose();
    userPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              // Container(
              //   height: MediaQuery.of(context).size.height / 4.0,
              //   width: MediaQuery.of(context).size.width,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.vertical(
              //           bottom: Radius.elliptical(
              //               MediaQuery.of(context).size.width, 100)),
              //       gradient: LinearGradient(
              //           colors: [Color(0xFF7f30fe), Color(0xFF6380fb)],
              //           begin: Alignment.topLeft,
              //           end: Alignment.bottomRight)),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 110),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            color: Color.fromARGB(255, 12, 148, 146),
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Login your account",
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 26, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          height: 382,
                          width: MediaQuery.of(context).size.width,
                          child: Form(
                            key: _formkey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Text(
                                    " Email",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black38,
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: userMailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter Email";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.email_outlined,
                                          color: Color.fromARGB(255, 12, 148, 146),
                                          size: 22,
                                        ),
                                        border: InputBorder.none),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 10),
                                  child: Text(
                                    " Password",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black38,
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: userPasswordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter Password";
                                      }
                                      return null;
                                    },
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.password,
                                          color: Color.fromARGB(255, 12, 148, 146),
                                          size: 22,
                                        ),
                                        border: InputBorder.none),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 7),
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return ForgotPassword();
                                      }));
                                    },
                                    child: Text(
                                      " Forgot Password? ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Color.fromARGB(255, 12, 148, 146)),
                                        onPressed: () {
                                          if (_formkey.currentState!
                                              .validate()) {
                                            setState(() {
                                              email = userMailController.text
                                                  .trim();
                                              password = userPasswordController
                                                  .text
                                                  .trim();
                                            });
                                            print(
                                                "00000000000000000000000000000");
                                            _signIn();
                                          }
                                        },
                                        child: Text("Sign In")),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SignUp(
                            onTap: () {},
                          );
                        }));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Not a member? ",
                            style: TextStyle(
                                color: Color.fromARGB(255, 193, 190, 190),
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: Text(
                              "Register now",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 12, 148, 146),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                          ),
                        ],
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

  void _signIn() async {
    String email = userMailController.text.trim();
    String password = userPasswordController.text.trim();

    User? user =
        await _authService.signInWithEmailAndPassword(context, email, password);
    if (user == null) {
      print("User is successfully signed in ");
      Navigator.pushNamed(context, "/home");
    } else {
      print("Some error happend");
    }
  }
}

void showSnackBar(BuildContext context) {}
