import 'package:baat_cheet_app/views/screens/splash/splash_screen.dart';
import 'package:baat_cheet_app/views/utils/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme().getAppTheme(),
      home: SplashScreen(),
    );
  }
}

