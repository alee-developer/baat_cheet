import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:baat_cheet_app/models/users/add_user_model.dart';
import 'package:baat_cheet_app/models/users/user_details_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UsersController {
  var userRef = FirebaseFirestore.instance.collection("users");
  var storage = FirebaseStorage.instance.ref("users");
  var firebaseAuth = FirebaseAuth.instance;

  Future<void> addNewUser(AddUserModel data) async {
    await userRef.doc(data.userId).set(data.toJson());
  }

  String? get getUserId => FirebaseAuth.instance.currentUser?.uid;

  Future<UserDetailsModel> getUserDetails()async{
    var user = await userRef.doc(getUserId).get();
    var data = user.data();
    return UserDetailsModel.fromJson(data??<String,dynamic>{});
  }

  Future<void> updateUser(UserDetailsModel data) async {
    await userRef.doc(data.userId).update(data.toJson());
  }

  Future<String> uploadProfilePicture(XFile imagePath) async {
    var ext = imagePath.path.split(".").last;
    var name = imagePath.path.split("/").last;
    var meta = SettableMetadata(contentType: "image/$ext");
    var uploadTask =
        await storage.child(name).putFile(File(imagePath.path), meta);
    var imageUrl = await (uploadTask).ref.getDownloadURL();
    return imageUrl;
  }

  Future<UserCredential>signInWithGoogle()async{
    var user = await GoogleSignIn().signIn();
    var auth = await user?.authentication;

    var credential = GoogleAuthProvider.credential(
      accessToken: auth?.accessToken,
      idToken: auth?.idToken
    );
    return await firebaseAuth.signInWithCredential(credential);
  }

  Future<void> userLogout()async{
    await firebaseAuth.signOut();
  }
}
