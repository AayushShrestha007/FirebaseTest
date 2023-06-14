import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UsersModel usersModelFromJson(String str) => UsersModel.fromJson(json.decode(str));

String usersModelToJson(UsersModel data) => json.encode(data.toJson());

class UsersModel {
  String? name;
  String? email;

  UsersModel({
    this.name,
    this.email,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
  };



  factory UsersModel.fromFirebaseSnapshot(DocumentSnapshot doc){
    final data= doc.data() as Map<String, dynamic>;
        data["id"]=doc.id;
    return UsersModel.fromJson(data);
  }
}
