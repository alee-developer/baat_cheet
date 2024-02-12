import 'package:baat_cheet_app/views/screens/login/email_login_screen.dart';
import 'package:baat_cheet_app/views/screens/register/registration_widgets.dart';
import 'package:baat_cheet_app/views/utils/extensions/context_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/int_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/widget_extensions.dart';
import 'package:baat_cheet_app/views/utils/widgets/background.dart';
import 'package:flutter/material.dart';

import '../login/optional_auth_view.dart';

class EmailRegistrationScreen extends StatefulWidget {
  const EmailRegistrationScreen({super.key});

  @override
  State<EmailRegistrationScreen> createState() =>
      _EmailRegistrationScreenState();
}

class _EmailRegistrationScreenState extends State<EmailRegistrationScreen> {
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
            height: context.fullHeight / 3.3,
            width: context.fullWidth / 2,
            child: const Text(
              "Registration",
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
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
              children: [
                view.fieldView(
                    title: 'Name', controller: TextEditingController()),
                10.height,
                view.fieldView(
                    title: 'Email', controller: TextEditingController()),
                10.height,
                view.fieldView(
                    title: 'Password', controller: TextEditingController()),
                30.height,
                view.getOtpButton(onPressed: (){}),
                20.height,
                const Text("Already Have Account").center(),
                20.height,
                OptionalAuthView(
                  onEmailTab: () {
                    const EmailLoginScreen().pushWithWidget(context: context);
                  },
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
