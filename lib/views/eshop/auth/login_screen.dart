import 'package:baat_cheet_app/views/eshop/auth/auth_widgets.dart';
import 'package:baat_cheet_app/views/eshop/auth/register_screen.dart';
import 'package:baat_cheet_app/views/eshop/controllers/auth_controller.dart';
import 'package:baat_cheet_app/views/eshop/controllers/product_controller.dart';
import 'package:baat_cheet_app/views/eshop/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../firebase_options.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
    create: (_) => ProductController(),
    child: MaterialApp(
      theme: ThemeData(primaryColor: Color(0xff0c54be), useMaterial3: false),
      home: MyApplication(),
    ),
  ));
}

class MyApplication extends StatefulWidget {
  const MyApplication({super.key});

  @override
  State<MyApplication> createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3),(){
      isUserLogin();
    });
  }
  isUserLogin()async{
    var user = FirebaseAuth.instance.currentUser;
    if(user != null){
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
              (_) => false);
    }else{
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
              (_) => false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlutterLogo(size: 150,),
    );
  }
}


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var view = AuthWidgets(context: context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Form(
        key: loginKey,
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            view.authFieldView(emailController, "Email Address"),
            view.authFieldView(passwordController, "Password"),
            const SizedBox(
              height: 30,
            ),
            view.authButtonView("Login", onPressed: () async {
              if (loginKey.currentState!.validate()) {
                var user = await AuthController().login(
                    emailController.text.trim(),
                    passwordController.text.trim());
                if (user != null) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                      (_) => false);
                  Fluttertoast.showToast(msg: "Login Successful");
                } else {
                  Fluttertoast.showToast(msg: "Try Again");
                }
              }
            }),
            Row(
              children: [
                const Text("Don't have account?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => RegisterScreen()));
                    },
                    child: Text("Register")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
