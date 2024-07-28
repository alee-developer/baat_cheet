import 'package:baat_cheet_app/views/eshop/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../controllers/auth_controller.dart';
import '../home/home_screen.dart';
import 'auth_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var registerKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var view = AuthWidgets(context: context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Form(
        key: registerKey,
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            view.authFieldView(nameController, "Name"),
            view.authFieldView(emailController, "Email Address"),
            view.authFieldView(passwordController, "Password"),
            const SizedBox(
              height: 30,
            ),
            view.authButtonView("Register", onPressed: () async {
              if(registerKey.currentState!.validate()){
                var user = await AuthController().register(
                    emailController.text.trim(), passwordController.text.trim());
                if (user != null) {
                  AuthController()
                      .addUserData(
                      nameController.text.trim(),
                      emailController.text.trim(),
                      passwordController.text.trim(),
                      user.uid)
                      .then((a) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => HomeScreen()),
                            (_) => false);
                    Fluttertoast.showToast(msg: "Login Successful");
                  });
                } else {
                  Fluttertoast.showToast(msg: "Try Again");
                }
              }
            }),
            Row(
              children: [
                const Text("Already have account?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()));
                    },
                    child: const Text("Login")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
