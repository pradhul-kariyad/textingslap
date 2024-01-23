import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  //instance of auth &firestore:

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get current user:

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Future<UserCredential> signInWithEmailAndPassword(
  //     String email, password, name) async {
  //   try {
  //     //sign In:

  //     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     //save user info if it doesn't already exist:
  //     _firestore.collection("Users").doc(userCredential.user!.uid).set({
  //       "Uid": userCredential.user!.uid,
  //       "E-mail": email,
  //       "Name": name,
  //     });

  //     return userCredential;
  //   } on FirebaseAuthException catch (e) {
  //     throw Exception(e.code);
  //   }
  // }

  Future<User?> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(title: Text(e.toString()));
          });
      print("Some error occured");
    }
    return null;
  }

  Future<UserCredential> signUpWithEmailAndPassword(
    String email,
    password,
    name,
    // ansila
  ) async {
    try {
      //create user:

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      //save user info in a separate doc
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        "Uid": userCredential.user!.uid,
        "E-mail": email,
        "Name": name,
        // "Ansila":ansila
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //signOut:
  Future<void> signOut() async {
    return await _auth.signOut();
  }
}
