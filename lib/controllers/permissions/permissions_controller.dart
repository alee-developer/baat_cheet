import 'package:permission_handler/permission_handler.dart';

class PermissionsController{


  static Future<bool> checkPermission(Permission permission)async{
    var isGranted = false;
    if(await permission.isGranted){
      isGranted = true;
    }if (await permission.isPermanentlyDenied){
      openAppSettings();
      if(await permission.isDenied){
        await checkPermission(permission);
      }
    }else{
      await permission.request();
      if(await permission.isDenied){
        await checkPermission(permission);
      }
    }
    return isGranted;
  }

}