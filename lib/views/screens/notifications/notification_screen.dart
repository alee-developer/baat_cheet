import 'package:baat_cheet_app/views/screens/notifications/notification_services.dart';
import 'package:baat_cheet_app/views/utils/helpers/permission_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    PermissionHelper().checkNotificationPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  NotificationServices().showDemoNotification(
                      const RemoteMessage(
                          notification: RemoteNotification(
                              title: "this is a title only",
                              body: "This is just a body")));
                },
                child: const Text("Send Local notification")),
            ElevatedButton(
                onPressed: () {
                  NotificationServices().pushNotificationWithApi(
                      "this is title form mobile", "this is body from mobile");
                },
                child: const Text("Push notification"))
          ],
        ),
      ),
    );
  }
}
