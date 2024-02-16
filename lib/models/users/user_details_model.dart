import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserDetailsModel userDetailsModelFromJson(String str) =>
    UserDetailsModel.fromJson(json.decode(str));

String userDetailsModelToJson(UserDetailsModel data) =>
    json.encode(data.toJson());

class UserDetailsModel {
  String? userId;
  String? name;
  String? email;
  String? about;
  String? imageUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserDetailsModel({
    this.userId,
    this.name,
    this.email,
    this.about,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) =>
      UserDetailsModel(
        userId: json["userId"],
        name: json["name"],
        email: json["email"],
        about: json["about"],
        imageUrl: json["imageUrl"],
        createdAt: json['createdAt'] == null
            ? null
            : (json["createdAt"] as Timestamp).toDate(),
        updatedAt: json["updatedAt"] == null
            ? null
            : (json["updatedAt"] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "email": email,
        "about": about,
        "imageUrl": imageUrl,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
