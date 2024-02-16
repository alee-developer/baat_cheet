import 'package:baat_cheet_app/controllers/auth/auth_controller.dart';
import 'package:baat_cheet_app/views/screens/chats/chats_screen.dart';
import 'package:baat_cheet_app/views/utils/extensions/context_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/int_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/widget_extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/widgets/background.dart';
import 'optional_auth_view.dart';
import '../register/registration_widgets.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  const OTPScreen({super.key, required this.phoneNumber});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String verificationId = "";
  String smsCode = "";
  @override
  void initState() {
    super.initState();
    AuthControllers().phoneVerification(
      phoneNumber: widget.phoneNumber,
        verificationCompleted: (credential) {
          FirebaseAuth.instance.signInWithCredential(credential);
        }, codeSent: (id, code) {
          verificationId = id;
          setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var view = RegistrationWidgets(context: context);
    return Scaffold(
      body: AppBackGrounds(context: context).authBackGround(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: context.fullHeight / 3,
            width: context.fullWidth / 2,
            child: const Text(
              "Login",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white),
            ).center(),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(.9),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
              children: [
                view.otpDescription("+91 789053263").center(),
                50.height,
                view.otpFieldView(
                  onChanged: (text){
                    smsCode = text;
                    setState(() {});
                  },
                  title: "Enter OTP",
                ),
                view.resentOtpView().align(alignment: Alignment.topRight),
                40.height,
                view.submitButton(
                  "Verify",
                    onPressed: ()async{
                  if(verificationId !=""){
                    PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: verificationId,
                      smsCode: smsCode,
                    );
                    await AuthControllers().signInWithCredential(credential).then((value){
                      const ChatsScreen().pushWithRemoveUntil(context: context);
                    });
                  }
                }),
                30.height,
                OptionalAuthView(
                  onEmailTab: () {},
                  onGoogleTab: () {},
                )
              ],
            ),
          ).expanded(),
        ],
      )),
    );
  }
}
