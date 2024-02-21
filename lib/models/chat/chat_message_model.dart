// To parse this JSON data, do
//
//     final chatMessageModel = chatMessageModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ChatMessageModel chatMessageModelFromJson(String str) => ChatMessageModel.fromJson(json.decode(str));

String chatMessageModelToJson(ChatMessageModel data) => json.encode(data.toJson());

class ChatMessageModel {
  String? message;
  DateTime? date;
  String? to;
  String? from;

  ChatMessageModel({
    this.message,
    this.date,
    this.to,
    this.from,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) => ChatMessageModel(
    message: json["message"],
    date: (json["date"] as Timestamp).toDate(),
    to: json["to"],
    from: json["from"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "date": date,
    "to": to,
    "from": from,
  };
}
