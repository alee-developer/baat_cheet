import 'package:baat_cheet_app/firebase_options.dart';
import 'package:baat_cheet_app/views/eshop/auth/login_screen.dart';
import 'package:baat_cheet_app/views/screens/splash/splash_screen.dart';

import 'package:baat_cheet_app/views/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Baat Cheet',
        theme: AppTheme().getAppTheme(),
        home: const LoginScreen());
  }
}
