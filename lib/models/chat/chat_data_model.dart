// To parse this JSON data, do
//
//     final chatDataModel = chatDataModelFromJson(jsonString);

import 'dart:convert';

ChatDataModel chatDataModelFromJson(String str) => ChatDataModel.fromJson(json.decode(str));

String chatDataModelToJson(ChatDataModel data) => json.encode(data.toJson());

class ChatDataModel {
  String? senderId;
  String? text;
  String? date;
  String? time;

  ChatDataModel({
    this.senderId,
    this.text,
    this.date,
    this.time
  });

  factory ChatDataModel.fromJson(Map<dynamic, dynamic> json) => ChatDataModel(
    senderId: json["senderId"],
    text: json["text"],
    date: json['date'],
    time: json['time']
  );

  Map<String, dynamic> toJson() => {
    "senderId": senderId,
    "text": text,
    "date": date,
    'time':time
  };
}
