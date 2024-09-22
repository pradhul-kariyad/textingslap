// ignore_for_file: avoid_print, use_build_context_synchronously, unnecessary_null_comparison, unused_import, unused_field
import 'dart:developer';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:textingslap/auth/signIn.dart';
import 'package:textingslap/chat/chatPage.dart';
import 'package:textingslap/colors/colorData.dart';
import 'package:textingslap/home/secondHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:textingslap/auth/authService.dart';
import 'package:textingslap/service/dataBase.dart';
import 'package:textingslap/service/shared_pref.dart';

class SignUp extends StatefulWidget {
  final void Function()? onTap;
  const SignUp({super.key, required this.onTap});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  final _authService = AuthService();
  late String _email;
  bool passwordIcon = true;
  bool confirmIcon = true;

  @override
  void dispose() {
    mailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> signUp(BuildContext context) async {
    String name = nameController.text.trim();
    String email = mailController.text.trim();
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    try {
      // If sign up is successful, navigate to the next page
      if (passwordController.text == confirmPasswordController.text) {
        UserCredential user = await _authService.signUpWithEmailAndPassword(
            email, password, name, confirmPassword);
        if (user != null) {
          log("User is successfully created");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: ColorData.black,
              content: Text(
                "Let's start...",
                style: TextStyle(fontWeight: FontWeight.bold),
              )));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => secondHomePage()),
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "Please confirm your password",
              style: TextStyle(fontSize: 13.sp),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: Color.fromARGB(255, 12, 148, 146)),
                ),
              ),
            ],
          ),
        );

        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     backgroundColor: Color.fromARGB(255, 12, 148, 146),
        //     content: Text(
        //       "Please confirm your password",
        //       style: TextStyle(fontWeight: FontWeight.bold),
        //     ),
        //   ),
        // );
      }
    } catch (e) {
      // Handle different authentication exceptions
      var errorMessage = "Email already in use";

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            errorMessage,
            style: TextStyle(fontSize: 13.sp),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(color: Color.fromARGB(255, 12, 148, 146)),
              ),
            ),
          ],
        ),
      );

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     backgroundColor: Color.fromARGB(255, 12, 148, 146),
      //     content: Text(
      //       errorMessage,
      //       style: TextStyle(fontWeight: FontWeight.bold),
      //     ),
      //   ),
      // );
    }
  }

  // void register(BuildContext context) {
  //   final _auth = AuthService();

  //   if (passwordController.text == confirmPasswordController.text) {
  //     try {
  //       _auth.signUpWithEmailAndPassword(
  //         mailController.text,
  //         passwordController.text,
  //         nameController.text,
  //         // ansilaController.text
  //       );
  //     } catch (e) {
  //       showDialog(
  //           context: context,
  //           builder: (context) {
  //             return AlertDialog(title: Text(e.toString()));
  //           });
  //     }
  //   } else {
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(title: Text("Password don't match!"));
  //         });
  //   }
  // }

  // registraction() async {
  //   if (password != null && password == confirmPassword) {
  //     try {
  //       UserCredential userCredential = await FirebaseAuth.instance
  //           .createUserWithEmailAndPassword(email: email, password: password);

  //       String id = randomAlphaNumeric(10);

  //       String user = mailController.text.replaceAll("@gmail.com", "");
  //       String updateUserName =
  //           user.replaceFirst(user[0], user[0].toUpperCase());
  //       String firstLetter = user.substring(0, 1).toUpperCase();

  //       // String user = mailController.text.replaceAll("@gmail.com", "");
  //       // String updateUserName =
  //       //     user.replaceFirst(user[0], user[0].toUpperCase());
  //       // String firstLetter = user.substring(0, 1).toUpperCase();

  //       Map<String, dynamic> userInfoMap = {
  //         "Name": nameController.text,
  //         "E-mail": mailController.text,
  //         "User Name": updateUserName.toUpperCase(),
  //         "SearchKey": firstLetter,
  //         "Photo":
  //             "data:image/jpeg;base64,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",
  //         "Id": id,

  //         // "Password": passwordController.text,
  //         // "Confirm Password": confirmPasswordController.text
  //       };
  //       await DataBaseMethods().addUserDetails(userInfoMap, id);
  //       await SharedPreferenceHelper().saveUserId(id);
  //       await SharedPreferenceHelper().saveUserDisplayName(nameController.text);
  //       await SharedPreferenceHelper().saveUserEmail(mailController.text);
  //       await SharedPreferenceHelper().saveUserPic(
  //           "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAJAAgAMBIgACEQEDEQH/xAAcAAABBAMBAAAAAAAAAAAAAAACAAEDBAUGBwj/xAA9EAACAQMCAwQHBQYGAwAAAAABAgMABBEFIRIxQQYHE1EUIjJhcYGhQpGxssEjM2RywtEVYnSSs/AWQ1L/xAAaAQACAwEBAAAAAAAAAAAAAAAAAQIDBAUG/8QAIhEAAgICAgICAwAAAAAAAAAAAAECEQMhBBIiQVGBBRMx/9oADAMBAAIRAxEAPwDnlPSpVMQqcUqVACpzTU9ACpUMkixoXc4UdaQuhEVKBXU9c4PypMaVkqR8W5IVf/o8qsmzHBxCQMDyK7iq/pYlBDtlenEMEfGo7TU0gnMchzCRufLf9Kg5FigFMjwqGcAqxIDKc0w3AI60Ul9E1vKrhSY5OIHzGKl05YLuDDRiJsbMknL4impIi4b0Q0qA8UU5hkIY9GHWjqREVLpSJpjTAjpxTU4oEPSpqVAwhSJoc0xNAEN44WHB3yQKKwjnuXEVrEZJG5ADNDMokUA9Dmt67tbKFPEunC8ZfgBJ5VXkdFuJWynYd3upXKcd1MkRI2Xhzw1fHdXD4B8S7YzHckDaulxLlRg00zrEuXYKPNjWVyfya1CL9HG9S7uruyjd4pvGXHIg1g7eafTZDGI0SRemMGu2XF7bS/sxNG58gQa5N3iW6RaiWiBBZcn31KEm3RGcIpWiCcrd27eKojdPXUqOXU/LrVCKXiTcgnqRVTTr6QRMD6xRSBnqP+/jUloCIFz13rVAyTdu0ZGyUy3kESxpK0sixqjkgMWOACRvzNZFYbs6yukJp1nFeGcQcJhMmGzj7ZbaoeykXj9p9Jj/AIyJv9rBv0rcdR1KyntV7ZQsg1KJWtHi5H0jkJPgU4j86mQOdA0s0ANPmgA6VDmlQAVCTSpjQADYbY1vPZ6G0ttEtnvLK5umlLMkUOcY+8D7zWlWyLLdwROSEeVVYjoCcV3Ds1ZxR6PbW7hSYo1Q58wKzZ5ejTx1bsxGgiFZY57SC8tONgGhmJIx58zVvXoEuJmkltfSmQgIjchWWm8CCZB6qgH69Ki9KiF5ICyOAQrYOSD76xtI3KzW7d5p3Rbrs/FEp+1E6tw/hWC7x7Jf8MWZl9eNwBnng101vBNtxLggitG7SxjU7iK0cBkaVSynqBuR9KkmlKyMo3Gjkgikt42coyrKOFWKnB+dX4xhQB0FdA7zfRoOzCK0aied40jUclIOTgcgMbVz2LIRQeYAzWzDPvG6MGeHSVFm3nmtpBLbyvFIvJ42KkfAihZizFmJLHmScmmHKnAq4pIM0QNR8VEDTESZpZoRT0DHzSpqVAAPnGxwa7DoV+11ZwzW0gZZVGSOQbG/w3rjxraOw+uCxkaxnbEcjZjJ6N1FZuRByjo08aajPZut7e2FxJ4N/bTSyxNkAwnYjqP71GL7T7N/FgsJS5/9nhbn5nnWU8JL7gkABcDmNjTy2IXEkgBIHM74rHo6acaKyS3EloJfCeHxWwI35j37Vg7i/srLWxLfThIYVLE+8A1ktT1RYUZi+yf2rlvaqeS5ngdsgSsWA93KjFDvKmVZp9I2T9qtb/8AI9UjmijaOztgVhV/abJ3Y+WcD7qoLUaDbAqUV0oxUVSOVKTk7YQNHmgFPTIlbNEOdReInFw8a8XlnepUjkaN5Vjdo4z67hSVX4npTAMU9Rg0YNABUjTUqABNTaXaT6hqVvZ2ycc0r+qOm25J9wAJqrLIF51vPcikc/bCYSorE2ThSenrKDj5UUFmbsGvLLHhMWRvst0qa+u9WuUKJGEB+0zcqyD2RiLQketGSp+W1QSPKsRTw8nzrkNtOjtJKkzWn01pGzO5cDnmtO7UsG1uGIDaNMfU/wBq6RcqYLUsc8TdTWn9u9NFpoWj6mi/tJbmdGbzGFx+DVfxtz2Z+VqBri86kFQxOHUMOtTA1vOaFT0Ip6BnQrm4W0mk04RotjExi9GZPUK+8dc+fPeh1q5Gh3/odnO6Q2yAJGhOI1xnBzzONyepNT6zCLiKK9jHrqyxzgdc+y36fdVntXYIO1lncSoDbNB403liLJOfjhR86h+Pm5uT+Tvc94oKHik0mn9Gt6v2NJvrp7e7tbfibijtipwmQMqW5LvnoQK1KA28d8kV/I8cIk4ZmiXjZQDg4HU1FqmsXer3Us9zNIVkYsI+I8IB91Vgu2wrTPpfiedXb2XtQltFunGmNcPajHA1yqiQ+eQu1U3d25sflSxSI2qOiQAG9b73Jnh7b4z7VnJj71rRBW79zTY7wLUH7VtMv0B/SosDqnau3Nrqq3Cj9ldDf3OOf0x9aw78THGa3fXoYL2za1kP7QEOhX7DDkf0+dYeHRRxoxlLIOalOEmsGTBKUridDDyEoVL0abqccs1xFbQqXlc4VQOZql3xWi2fZrTLI7tbyKM+bcLcX410pLBIZC1vEiOebqNz8+daH3zIX7NRzSDLrcKCffvWnBhWO7KM+X9lV/DilpM0fqndTvislFIrj1TmsSgOcip1HUEg+YqwzmUWlVOO5Zdnyw8+tWElST2Tv5HnTA7eltbPLxmNog20i8J4WHw6GqHeje2cfZi4eO5iNyy+EgRwWIYrkc9h6o+6uLOTJ+8Jb+Y5qGRUXGEUddhVPFxPBHqnZbnyyzVYyeVTI2RUC86OPZmHzq4qJ80jQZosgimIVbJ3aytF260nhcpxtIhI8jG1ayTWb7DyeH200R/K7UffkfrQB6TUKq4AFDO4SIMBkZ3AHOpGAA2oQnFGRnrT0htsEsFO2+1aB31yqvZBY2I4pbuNQPgGb8Aa32VuFhxLkedcs79ZV/w7SYFO7zvIQf8AKuP6qk1oLOPxbg5qSPkKCMVYhhJUFjgfWq0AJ3ohATuTw++pwqp7IpiaYiIb1E+70YNR/aJqIxhzpwcSj3im60j7YoANm3pwdqjzvR9KYBNWQ7NSeF2k0l/K9h/OBVBqs6PtrWm/6yH/AJFosD1NLSibZqGU70MGSWxVlaAefkuffXFu/O4Da1ptsp3jtmkYfzNgflNdnKFY4w7cTAbmvP3e9dek9uLoKciCKOH7hxf1Um/ERqEFXEbaqsOy5qZDvURkvOgbakp6eVO3KkBWBoVNLO1MvsmkAutCc+KDnbBoutCf3g+FAB5FFnC1GOdH0oAcsSKuaEC+u6YvneQ/nWqZ2FZTsknH2n0kfxkf5qAPTUvMmih9l6hDZXB5Ucb+o2Oe1XegYp3wUHuI/CvMXa+79O7Vavc5yHvJQPgGKj6AV6R1a4S2tZZXb91E0hPlgE/pXlmWRppTK3tOeI/E71CQEyDYVIKBedSCogMx9bPnRcxQS+znyp4z50gP/9k=");
  //       await SharedPreferenceHelper()
  //           .saveUserName(mailController.text.replaceAll("@gamil.com", ""));

  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           content: Text(
  //         "Registered Successfully",
  //         style: TextStyle(fontSize: 20),
  //       )));
  //       Navigator.pushReplacement(context,
  //           MaterialPageRoute(builder: (context) {
  //         return secondHomePage();
  //       }));
  //     } on FirebaseAuthException catch (e) {
  //       if (e.code == "Weak-password") {
  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //             backgroundColor: Colors.orange,
  //             content: Text(
  //               "Password Provided is too weak",
  //               style: TextStyle(fontSize: 18),
  //             )));
  //       } else if (e.code == "email-already-in-use") {
  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //             backgroundColor: Colors.orange,
  //             content: Text(
  //               "Account Already Exits",
  //               style: TextStyle(fontSize: 18),
  //             )));
  //       }
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SizedBox(
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
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Color.fromARGB(255, 12, 148, 146),
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Create a new account",
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
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
                          height: 584,
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
                                    " Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                // Container(
                                //   padding: EdgeInsets.only(right: 10),
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(10),
                                //     border: Border.all(
                                //       width: 1,
                                //       color: Colors.black38,
                                //     ),
                                //   ),
                                //   child:
                                TextFormField(
                                  controller: nameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your name";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 12, 148, 146))),
                                      // prefixIcon: Icon(
                                      //   Icons.person_outline,
                                      //   color:
                                      //       Color.fromARGB(255, 12, 148, 146),
                                      //   size: 22,
                                      // ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(13))),
                                ),
                                // ),
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
                                //     Padding(
                                //   padding: const EdgeInsets.only(
                                //       top: 10, bottom: 10),
                                //   child: Text(
                                //     " Email",
                                //     style: TextStyle(
                                //         fontWeight: FontWeight.bold,
                                //         fontSize: 15),
                                //   ),
                                // ),
                                // Container(
                                //   padding: EdgeInsets.only(right: 10),
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(10),
                                //     border: Border.all(
                                //       width: 1,
                                //       color: Colors.black38,
                                //     ),
                                //   ),
                                //   child:
                                TextFormField(
                                  controller: mailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    String pattern =
                                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                                    RegExp regExp = RegExp(pattern);
                                    if (!regExp.hasMatch(value!)) {
                                      return 'Enter a valid email';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _email = value!;
                                  },
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 12, 148, 146))),
                                      // prefixIcon: Icon(
                                      //   Icons.email_outlined,
                                      //   color:
                                      //       Color.fromARGB(255, 12, 148, 146),
                                      //   size: 22,
                                      // ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(13))),
                                ),
                                // ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20, bottom: 10),
                                  child: Text(
                                    " Password",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                // Container(
                                //   padding: EdgeInsets.only(right: 10),
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(10),
                                //     border: Border.all(
                                //       width: 1,
                                //       color: Colors.black38,
                                //     ),
                                //   ),
                                //   child:
                                TextFormField(
                                  controller: passwordController,
                                  validator: (value) {
                                    return value!.length < 6
                                        ? 'Must be at least 6 characters'
                                        : null;
                                    // if (value == null || value.isEmpty) {
                                    //   return "Please Enter Password";
                                    // }
                                    // return null;
                                  },
                                  obscureText: passwordIcon ? true : false,
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 12, 148, 146))),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            passwordIcon = !passwordIcon;
                                          });
                                        },
                                        icon: Icon(
                                          passwordIcon
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color:
                                              Color.fromARGB(255, 12, 148, 146),
                                          size: 22,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(13))),
                                ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 10),
                                  child: Text(
                                    "Confirm Password",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                // Container(
                                //   padding: EdgeInsets.only(right: 10),
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(10),
                                //     border: Border.all(
                                //       width: 1,
                                //       color: Colors.black38,
                                //     ),
                                //   ),
                                //   child:

                                TextFormField(
                                  controller: confirmPasswordController,
                                  validator: (value) {
                                    return value!.length < 6
                                        ? 'Must be at least 6 characters'
                                        : null;
                                    // if (value == null || value.isEmpty) {
                                    //   return "Please Enter Password";
                                    // }
                                    // return null;
                                  },
                                  obscureText: confirmIcon ? true : false,
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 12, 148, 146))),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            confirmIcon = !confirmIcon;
                                          });
                                        },
                                        icon: Icon(
                                          confirmIcon
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color:
                                              Color.fromARGB(255, 12, 148, 146),
                                          size: 22,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(13))),
                                ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return SignIn(onTap: () {});
                                      }));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Already have an account? ",
                                          style: TextStyle(
                                              // decoration:
                                              //     TextDecoration.underline,
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ),
                                        Text(
                                          "Login now",
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Color.fromARGB(
                                                  255, 12, 148, 146),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 317,
                        height: 52,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 12, 148, 146)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(11)))),
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              await signUp(context);
                            }
                            // registraction();
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    )
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
