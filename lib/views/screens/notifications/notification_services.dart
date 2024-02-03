import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class NotificationServices {
  var localNotificationPlugin = FlutterLocalNotificationsPlugin();

  initNotificationPlugin() {
    localNotificationPlugin.initialize(const InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher")));
  }

  showDemoNotification(RemoteMessage message) {
    localNotificationPlugin.show(
        hashCode,
        message.notification?.title??"No title",
        message.notification?.body??"",
        const NotificationDetails(
            android: AndroidNotificationDetails("channelId", "channelName")));
  }

  // firebase messaging
var fcmInstance = FirebaseMessaging.instance;
  getNotificationToken()async{
    var token = await fcmInstance.getToken();
    print("notification token: $token");
    return token;
  }

  // if application getting up from terminated state

  onTerminatedMessageHandler()async{
    var message = await fcmInstance.getInitialMessage();
    if(message !=null){
      showDemoNotification(message);
    }
  }

  // on foreground notification handler
  onForegroundMessageHandler()async{
    FirebaseMessaging.onMessage.listen((event) {
      showDemoNotification(event);
        });
  }

  // push notification
 Future<bool> pushNotificationWithApi(String title,String reqBody)async{
    var resResult = false;
    var url = Uri.parse("https://fcm.googleapis.com/fcm/send");
    var headers = {
      "Authorization":"key=AAAA7jtxn74:APA91bGSn1tPomYaBwpmk-YL4Gp3i8YSoMTwoYbXLm3WY2isK4FL5PgFMRlOs773agdaSICVYn617Oo4Uf8hMNG1NCe6b8b_XHOdyOr8asnnMTlpENNkIYsK8VVVTBd9PpYz97y-p__4"
    };
    var body =
      {
        "to": "dEXCatrWQZyrH8qN9lkVZ7:APA91bEc4Pvf_mOOr9oFSLNBlkyOJCKfwLWW1slpyPmWDf749bEhugQ3xBtvcAqmtlh47yAl3ilVPBqPxAWXagUPWcNG4dsKxbe2ZborDOogaLQHbVoU9XJsZ4_oaAwoUXiB8Znm9DRy",
        "notification": {
          "title": title,
          "body": reqBody,
          "mutable_content": true,
          "sound": "Tri-tone"
        }

//    "data": {
//     "url": "<url of media image>",
//     "dl": "<deeplink action on tap of notification>"
//       }
      };
    var res = await http.post(url,headers: headers,body: jsonEncode(body));
    if(res.statusCode == 200){
      resResult = true;
    }else{
      resResult = false;
    }
    return resResult;
  }
}

// on back ground message handler
// @pragma('vm:entry-point')
Future<void> onBackGroundNotificationHandler(RemoteMessage? message)async{
  if(message !=null){
    print("background Message:${message.notification?.title}${message.notification?.body}");
    NotificationServices().showDemoNotification(message);
  }
}
