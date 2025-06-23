// lib/tugas_15/model/User_Model_model.dart (After renaming the file)

import 'dart:convert';

// Change User_Model1FromJson to userFromJson
User_Model userModelFromJson(String str) =>  User_Model.fromJson(json.decode(str));
// Change User1ToJson to userToJson
String userModelToJson(User_Model data) => json.encode(data.toJson());

// Change class User1 to class User
class User_Model {
  int? id;
  String name;
  String email;
  String? emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  User_Model({
    this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  // Change factory User_Model1.fromJson to factory User_Model.fromJson
  factory User_Model.fromJson(Map<String, dynamic> json) => User_Model(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
