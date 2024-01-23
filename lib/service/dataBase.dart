import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataBaseMethods {
  Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(id)
        .set(userInfoMap);
  }

  Future<QuerySnapshot> getUserByEmail(String email) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .where("E-mail", isEqualTo: email)
        .get();
  }

  // Future<QuerySnapshot> Search(String userName) async {
  //   return await FirebaseFirestore.instance
  //       .collection("user")
  //       .where("SearchKey", isEqualTo: userName.substring(0, 1).toUpperCase())
  //       .get();
  // }

  // Future<QuerySnapshot> Search(String userName) async {
  //   return await FirebaseFirestore.instance
  //       .collection("users")
  //       .where("SearchKey", isEqualTo: userName.substring(0, 1).toUpperCase())
  //       .get();
  // }
}
