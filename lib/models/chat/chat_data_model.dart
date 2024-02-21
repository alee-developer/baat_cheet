// To parse this JSON data, do
//
//     final chatDataModel = chatDataModelFromJson(jsonString);

import 'dart:convert';

ChatDataModel chatDataModelFromJson(String str) => ChatDataModel.fromJson(json.decode(str));

String chatDataModelToJson(ChatDataModel data) => json.encode(data.toJson());

class ChatDataModel {
  String? senderId;
  String? text;
  num? timestamp;

  ChatDataModel({
    this.senderId,
    this.text,
    this.timestamp,
  });

  factory ChatDataModel.fromJson(Map<String, dynamic> json) => ChatDataModel(
    senderId: json["senderId"],
    text: json["text"],
    timestamp: json["timestamp"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "senderId": senderId,
    "text": text,
    "timestamp": timestamp,
  };
}
