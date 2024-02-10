import 'package:baat_cheet_app/views/screens/register/optional_auth_view.dart';
import 'package:baat_cheet_app/views/screens/register/registration_widgets.dart';
import 'package:baat_cheet_app/views/utils/extensions/context_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/int_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/widget_extensions.dart';
import 'package:baat_cheet_app/views/utils/widgets/background.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController phoneController = TextEditingController();
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
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 40),
                  children: [
                    view.fieldView(title: 'Name', controller: phoneController),
                    10.height,
                    view.fieldView(title: 'Phone', controller: phoneController),
                    60.height,
                    view.getOtpButton(),
                    50.height,
                    OptionalAuthView()
                  ],
                ),
              ).expanded(),
            ],
          )),
    );
  }

}
