import 'package:baat_cheet_app/views/screens/chats/chats_screen.dart';
import 'package:baat_cheet_app/views/screens/login/email_login_screen.dart';
import 'package:baat_cheet_app/views/screens/splash/splash_widgets.dart';
import 'package:baat_cheet_app/views/utils/extensions/int_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/widget_extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(3.seconds,(){
      checkUserLoginStatus();
    });
  }
  @override
  Widget build(BuildContext context) {
    var view = SplashWidgets(context: context);
    return Scaffold(
      body: view.imageAndTitleView().center(),
    );
  }

  checkUserLoginStatus()async{
    var firebaseAuth = FirebaseAuth.instance.currentUser;
    if(firebaseAuth !=null){
      const ChatsScreen().pushWithRemoveUntil(context: context);
    }else{
      const EmailLoginScreen().pushWithRemoveUntil(context: context);
    }
  }
}
