import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:textingslap/pages/signUp.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email = "";
  final _formKey = GlobalKey<FormState>();
  TextEditingController userMailController = new TextEditingController();
  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Password reset Email has been sent",
        style: TextStyle(fontSize: 18),
      )));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user note found") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "No user found for that Email",
          style: TextStyle(fontSize: 18),
        )));
      }
    }
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
              //           colors: [Color.fromARGB(255, 12, 148, 146), Color(0xFF6380fb)],
              //           begin: Alignment.topLeft,
              //           end: Alignment.bottomRight)),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 130),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Password Recovery",
                        style: TextStyle(
                            color: Color.fromARGB(255, 12, 148, 146),
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 2,),
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
                          vertical: 60.0, horizontal: 20.0),
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
                          height: 280,
                          width: MediaQuery.of(context).size.width,
                          child: Form(
                            key: _formKey,
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
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Color.fromARGB(255, 12, 148, 146)),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              email = userMailController.text
                                                  .trim();
                                            });
                                            resetPassword();
                                          }
                                        },
                                        child: Text("Send Email")),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: ()  {
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
                            "Don't have an account? ",
                            style: TextStyle(
                                color: Colors.grey[200],
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
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
                            child: Text(
                              "Sign Up Now !",
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
}
