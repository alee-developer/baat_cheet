import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthController {
  var auth = FirebaseAuth.instance;

  Future<User?> register(String email, String password) async {
    try {
      var credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        return credential.user;
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
    }

    return null;
  }

  Future<User?> login(String email, String password) async {
    try {
      var credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        return credential.user;
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
    }
    return null;
  }

  Future<void> addUserData(String name,String email,String password,String id)async{
   await FirebaseFirestore.instance.collection("users").doc(id.toString()).set({
      "id":id,
      "email":email,
      "password":jsonEncode(password.toString()),
      "name":name
    });
  }
}
