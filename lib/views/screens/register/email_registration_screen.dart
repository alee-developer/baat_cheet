import 'package:baat_cheet_app/controllers/auth/auth_controller.dart';
import 'package:baat_cheet_app/controllers/users/users_controller.dart';
import 'package:baat_cheet_app/models/users/add_user_model.dart';
import 'package:baat_cheet_app/views/screens/chats/chats_screen.dart';
import 'package:baat_cheet_app/views/screens/login/email_login_screen.dart';
import 'package:baat_cheet_app/views/screens/register/registration_widgets.dart';
import 'package:baat_cheet_app/views/utils/builders/loader_builder.dart';
import 'package:baat_cheet_app/views/utils/extensions/context_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/int_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/string_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/widget_extensions.dart';
import 'package:baat_cheet_app/views/utils/widgets/background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../login/optional_auth_view.dart';

class EmailRegistrationScreen extends StatefulWidget {
  const EmailRegistrationScreen({super.key});

  @override
  State<EmailRegistrationScreen> createState() =>
      _EmailRegistrationScreenState();
}

class _EmailRegistrationScreenState extends State<EmailRegistrationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var registerKey = GlobalKey<FormState>();
  bool showPassword = false;

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
            child: Form(
              key: registerKey,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                children: [
                  view.fieldView(
                      title: 'Name',
                      controller: nameController,
                      validator: (text) => text.defaultFieldValidator()),
                  10.height,
                  view.fieldView(
                      title: 'Email',
                      controller: emailController,
                      validator: (text) => text.emailFieldValidator()),
                  10.height,
                  view.passwordFieldView(
                      showToggle: showPassword,
                      title: 'Password',
                      controller: passwordController,
                      validator: (text) => text.defaultFieldValidator(),
                      onShowToggle: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      }),
                  30.height,
                  view.submitButton("Register", onPressed: () async {
                    if (registerKey.currentState!.validate()) {
                      Map response = await AuthControllers()
                          .createUserByEmailAndPassword(
                              emailController.text, passwordController.text);
                      LoaderBuilder(context: context).dismissLoader();
                      if (response['status'] == true) {
                        var date = DateTime.now();
                        User user = response['user'];
                        var data = AddUserModel(
                            userId: user.uid,
                            email: emailController.text,
                            updatedAt: date,
                            name: nameController.text,
                            createdAt: date);
                        UsersController().addNewUser(data).then((value) {
                          const ChatsScreen()
                              .pushWithRemoveUntil(context: context);
                        });
                        Fluttertoast.showToast(msg: response['message']);
                      } else {
                        Fluttertoast.showToast(msg: response['message']);
                      }
                    }
                  }),
                  20.height,
                  const Text("Already have account?").center(),
                  20.height,
                  OptionalAuthView(
                    onEmailTab: () {
                      const EmailLoginScreen().pushWithWidget(context: context);
                    },
                    onGoogleTab: () async {
                      var user = await UsersController().signInWithGoogle();
                      if (user.user != null) {
                        var date = DateTime.now();
                        var data = AddUserModel(
                            userId: user.user?.uid,
                            email: emailController.text,
                            updatedAt: date,
                            name: nameController.text,
                            createdAt: date);
                        UsersController().addNewUser(data).then((value) {
                          const ChatsScreen()
                              .pushWithRemoveUntil(context: context);
                        });
                      }
                    },
                  )
                ],
              ),
            ),
          ).expanded(),
        ],
      )),
    );
  }
}
