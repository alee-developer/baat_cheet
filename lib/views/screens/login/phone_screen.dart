import 'package:baat_cheet_app/views/screens/login/email_login_screen.dart';
import 'package:baat_cheet_app/views/screens/register/email_registration_screen.dart';
import 'package:baat_cheet_app/views/utils/colors.dart';
import 'package:baat_cheet_app/views/utils/extensions/context_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/int_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/widget_extensions.dart';
import 'package:baat_cheet_app/views/utils/widgets/background.dart';
import 'package:flutter/material.dart';
import '../register/registration_widgets.dart';
import 'optional_auth_view.dart';
import 'otp_screen.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
              children: [
                20.height,
                view.fieldView(
                    title: 'Phone', controller: TextEditingController()),
                40.height,
                view.getOtpButton(onPressed: () {
                  const OTPScreen().pushWithWidget(context: context);
                }),
                20.height,
                const Text("Login With").center(),
                OptionalAuthView(
                  onEmailTab: () {
                    const EmailLoginScreen().pushWithWidget(context: context);
                  },
                  onGoogleTab: () {},
                ),
                10.height,
                const Text("Don't have account?").center(),
                10.height,
                Row(
                  children: [
                    _button("assets/icons/email_image.png",onPressed: (){
                      const EmailRegistrationScreen().pushWithWidget(context: context);
                    }).expanded(),
                    10.width,
                    _button("assets/icons/google_image.png").expanded()
                  ],
                ),
              ],
            ),
          ).expanded(),
        ],
      )),
    );
  }

  Widget _button(String path,{void Function()? onPressed}) => ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          side: const BorderSide(width: 1.5,color: kPrimaryColor),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
      onPressed: onPressed,
      child: Row(
        children: [
          Image.asset(
            path,
            height: 50,
            width: 40,
          ).paddingAll(5),
          const Text(
            "Register",
            style: TextStyle(color: secondaryColor),
          )
        ],
      ));
}
