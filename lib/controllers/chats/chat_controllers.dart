import 'package:baat_cheet_app/models/chat/chat_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

mixin class ChatControllers {
  final firestore = FirebaseFirestore.instance.collection("users");
  final _realtime = FirebaseDatabase.instance.ref("chats");

  sendDataMessage(String chatId,ChatDataModel chat){
    var id = _realtime.push().key;
    _realtime.child(chatId).child("messages").child(id.toString()).set(chat.toJson());
  }

   getSingleMessage(String chatId){
    return _realtime.child(chatId).child("messages").orderByValue();
  }

  Stream<DatabaseEvent> getDate(String chatId){
   return _realtime.child(chatId).child("messages").orderByPriority().onValue;
  }

}
