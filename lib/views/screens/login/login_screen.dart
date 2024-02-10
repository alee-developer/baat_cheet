import 'package:baat_cheet_app/views/utils/extensions/context_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/int_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';

import '../../utils/widgets/background.dart';
import '../register/optional_auth_view.dart';
import '../register/registration_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var view = RegistrationWidgets(context: context);
    return  Scaffold(
      body: AppBackGrounds(context: context).authBackGround(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: context.fullHeight/3,
                width: context.fullWidth/2,
                child: const Text("Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),).center(),
              ),
              Container(
                decoration:  BoxDecoration(
                    color: Colors.white.withOpacity(.9),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 40),
                  children: [
                    view.otpDescription("+91 789053263").center(),
                    50.height,
                    view.otpFieldView(title: "Enter OTP",),
                    view.resentOtpView().align(alignment: Alignment.topRight),
                    40.height,
                    view.getOtpButton(),
                    30.height,
                    const OptionalAuthView()
                  ],
                ),
              ).expanded(),
            ],
          )),
    );
  }
}
