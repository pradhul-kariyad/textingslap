
class UsersModel {
  UsersModel({
    required this.id,
    required this.name,
    required this.email,
   
  });

  final String id;
  final String name;
  final String email;
 

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
      id: json["Id"],
      name: json["Name"],
      email: json["E-mail"],
    
      
      
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "E-mail": email,
      
      };
  factory UsersModel.getModelFromJson({required Map<String, dynamic> json}) {
    return UsersModel(
        id: json["Id"],
        name: json["Name"],
        email: json["E-mail"],
    );
  }
}

