import 'package:baat_cheet_app/firebase_options.dart';
import 'package:baat_cheet_app/views/screens/notifications/notification_screen.dart';
import 'package:baat_cheet_app/views/screens/notifications/notification_services.dart';
import 'package:baat_cheet_app/views/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  NotificationServices().initNotificationPlugin();
  FirebaseMessaging.onBackgroundMessage(onBackGroundNotificationHandler);
  NotificationServices().onForegroundMessageHandler();
  NotificationServices().getNotificationToken();
  NotificationServices().onTerminatedMessageHandler();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme().getAppTheme(),
      home: NotificationScreen(),
    );
  }
}

