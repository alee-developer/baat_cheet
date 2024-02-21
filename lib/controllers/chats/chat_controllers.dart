import 'package:baat_cheet_app/controllers/users/users_controller.dart';
import 'package:baat_cheet_app/models/chat/chat_data_model.dart';
import 'package:baat_cheet_app/models/chat/chat_message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

mixin class ChatControllers {
  final firestore = FirebaseFirestore.instance.collection("users");
  final _realtime = FirebaseDatabase.instance.ref("chats");
  final _chatCollection = "chats";

  Future<void> startChatting(ChatMessageModel chatMessageModel) {
    return _realtime.set(chatMessageModel.toJson());
  }

  sendMessage(ChatDataModel chat) {
    _realtime.child(UsersController().getUserId.toString()).set(chat.toJson());
  }

  // sendNextMessage(String message) {
  //   _realtime
  //       .child(UsersController().getUserId.toString())
  //       .set(ChatDataModel(messages: [MessageData(text: message, date: DateTime.now().toString())]).toJson());
  // }

  sendDataMessage(String chatId,ChatDataModel chat){
    var id = _realtime.push().key;
    _realtime.child(chatId).child("message").child(id.toString()).set(chat.toJson());
  }

  Stream<DatabaseEvent> getSingleMessage(String chatId){
    return _realtime.child(chatId).child("message").onValue;
  }

  Stream<DatabaseEvent> getMessage() {
    return _realtime.child(UsersController().getUserId.toString()).onValue;
  }

  Future<void> addNewChat(ChatMessageModel chat) async {
    firestore
        .doc(UsersController().getUserId)
        .collection(_chatCollection)
        .add(chat.toJson());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUserChats(String sendId) {
    return firestore
        .doc(UsersController().getUserId)
        .collection(_chatCollection)
        .where("from", isEqualTo: sendId)
        .where("to", isEqualTo: UsersController().getUserId)
        .snapshots();
  }
}
