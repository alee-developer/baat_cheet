// To parse this JSON data, do
//
//     final addUserModel = addUserModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

AddUserModel addUserModelFromJson(String str) => AddUserModel.fromJson(json.decode(str));

String addUserModelToJson(AddUserModel data) => json.encode(data.toJson());

class AddUserModel {
  String? userId;
  String? name;
  String? email;
  DateTime ? createdAt;
  DateTime ? updatedAt;

  AddUserModel({
    this.userId,
    this.name,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  factory AddUserModel.fromJson(Map<String, dynamic> json) => AddUserModel(
    userId: json["userId"],
    name: json["name"],
    email: json["email"],
    createdAt: (json["createdAt"] as Timestamp).toDate(),
    updatedAt: (json["updatedAt"] as Timestamp).toDate(),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "name": name,
    "email": email,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}
