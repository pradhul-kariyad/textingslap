import 'package:cloud_firestore/cloud_firestore.dart';

class UsersModel {
  UsersModel({
    required this.profilepic,
    required this.id,
    required this.Name,
    required this.email,
  });

  final String profilepic;
  final String id;
  final String Name;
  final String email;

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      id: json["Id"],
      Name: json["Name"],
      email: json["E-mail"],
      profilepic: json['profilepic'],
    );
  }

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": Name,
        "E-mail": email,
        "profilepic": profilepic,
      };

  factory UsersModel.fromMap(Map<String, dynamic> map) {
    return UsersModel(
      id: map["Id"],
      Name: map["Name"],
      email: map["E-mail"],
      profilepic: map['profilepic'],
    );
  }

  factory UsersModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UsersModel.fromMap(snapshot.data() as Map<String, dynamic>);
  }

  static UsersModel getModelFromJson(Map<String, dynamic> json) {
    return UsersModel(
      id: json['Id'],
      Name: json['Name'],
      email: json["E-mail"],
      profilepic: json['profilepic'],
    );
  }
}
