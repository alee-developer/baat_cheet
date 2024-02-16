import 'package:baat_cheet_app/views/utils/extensions/int_extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthControllers {
  var firebaseAuth = FirebaseAuth.instance;

  Future<ConfirmationResult> phoneAuth({String? phoneNumber}) async {
    return await firebaseAuth.signInWithPhoneNumber("+91 $phoneNumber");
  }

  Future<UserCredential> otpVerification(
      ConfirmationResult confirmationResult, String otp) {
    return confirmationResult.confirm(otp);
  }

  Future<UserCredential> signInWithCredential(AuthCredential credential) async {
    return await firebaseAuth.signInWithCredential(credential);
  }

  Future<void> phoneVerification(
      {String? phoneNumber,
      required void Function(PhoneAuthCredential) verificationCompleted,
      required void Function(String verificationId, int? resendToken)
          codeSent}) async {
    await firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+91$phoneNumber",
        verificationCompleted: verificationCompleted,
        verificationFailed: (exceptions) {
          Fluttertoast.showToast(msg: "${exceptions.message}");
        },
        timeout: 60.seconds,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: (verificationId) {});
  }

  Future<Map<String, dynamic>> createUserByEmailAndPassword(
      String email, String password) async {
    try {
      var credential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        return {
          "status": true,
          "message": "Registered successful",
          "user": credential.user
        };
      } else {
        return {"status": false, "message": "Registered unsuccessful"};
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: e.code == "invalid-credential"
              ? "Not available user"
              : "${e.message}");
      return {"status": false, "message": e.message};
    }
  }

  Future<Map<String, dynamic>> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      var auth = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return {"status": true, "user": auth, "message": "Login successful"};
    } on FirebaseAuthException catch (e) {
      return {"status": false, "message": "${e.message}"};
    }
  }
}
