
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper{

  checkNotificationPermissions()async{
    await Permission.notification.isDenied.then((value){
      if(value){
        Permission.notification.request();
        print("Noti permission: denied");
      }else{
        print("Noti permission: granted");
      }
    });
  }

}