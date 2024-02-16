import 'package:baat_cheet_app/controllers/auth/auth_controller.dart';
import 'package:baat_cheet_app/views/screens/chats/chats_screen.dart';
import 'package:baat_cheet_app/views/screens/register/email_registration_screen.dart';
import 'package:baat_cheet_app/views/utils/builders/loader_builder.dart';
import 'package:baat_cheet_app/views/utils/colors.dart';
import 'package:baat_cheet_app/views/utils/extensions/context_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/int_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/string_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';
import '../../../controllers/users/users_controller.dart';
import '../../../models/users/add_user_model.dart';
import '../../utils/widgets/background.dart';
import '../register/registration_widgets.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  var loginKey = GlobalKey<FormState>();

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
            child: Form(
              key: loginKey,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                children: [
                  view.fieldView(
                      validator: (text) => text.emailFieldValidator(),
                      title: 'Email',
                      controller: emailController),
                  10.height,
                  view.passwordFieldView(
                      showToggle: showPassword,
                      validator: (text) => text.defaultFieldValidator(),
                      title: 'Password',
                      controller: passwordController,
                      onShowToggle: () {
                        showPassword = !showPassword;
                        setState(() {});
                      }),
                  30.height,
                  view.submitButton("Login", onPressed: () {
                    if (loginKey.currentState!.validate()) {
                      LoaderBuilder(context: context).showLoader();
                      AuthControllers()
                          .loginWithEmailAndPassword(
                              emailController.text, passwordController.text)
                          .then((value) => {
                                LoaderBuilder(context: context).dismissLoader(),
                                if (value["user"] != null)
                                  {
                                    const ChatsScreen()
                                        .pushWithRemoveUntil(context: context)
                                  }
                                else
                                  {value['message'].showToast()}
                              });
                    }
                  }),
                  20.height,
                  _otherButtonView("assets/icons/google_image.png", "Google",
                      onPressed: () async {
                    var user = await UsersController().signInWithGoogle();
                    if (user.user != null) {
                      var date = DateTime.now();
                      var data = AddUserModel(
                          userId: user.user?.uid,
                          email: emailController.text,
                          updatedAt: date,
                          name: user.user?.displayName,
                          createdAt: date);
                      UsersController().addNewUser(data).then((value) {
                        const ChatsScreen()
                            .pushWithRemoveUntil(context: context);
                      });
                    }
                  }),
                  20.height,
                  const Text("Don't Have Account?").center(),
                  10.height,
                  _otherButtonView(
                      "assets/icons/email_image.png", "Email Registration",
                      onPressed: () {
                    const EmailRegistrationScreen()
                        .pushWithWidget(context: context);
                  })
                ],
              ),
            ),
          ).expanded(),
        ],
      )),
    );
  }

  _otherButtonView(String imagePath, String title,
      {void Function()? onPressed}) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            side: const BorderSide(width: 1, color: secondaryColor),
            backgroundColor: Colors.transparent,
            fixedSize: const Size(150, 45)),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 30,
              height: 30,
            ),
            10.width,
            Text(
              title,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            )
          ],
        ));
  }
}
