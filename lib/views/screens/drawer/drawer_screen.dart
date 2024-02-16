import 'package:baat_cheet_app/controllers/users/users_controller.dart';
import 'package:baat_cheet_app/models/users/user_details_model.dart';
import 'package:baat_cheet_app/views/screens/profile/profile_screen.dart';
import 'package:baat_cheet_app/views/utils/extensions/context_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/int_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../login/email_login_screen.dart';
import '../profile/profile_widgets.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  var userData = UserDetailsModel();
  String imagePath = "";
  bool hasImagePath = false;

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  getUserDetails() async {
    userData = await UsersController().getUserDetails();
    setState(() {});
    if (userData.imageUrl != null && userData.imageUrl != "") {
      imagePath = userData.imageUrl ?? "";
      hasImagePath = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var view = ProfileWidgets(context: context);
    return Drawer(
      width: context.fullWidth / 1.6,
      child: ListView(
        children: [
          DrawerHeader(
              child: Column(
                children: [
                  view.userImageView(imagePath, hasImagePath,
                      size: 100, showIcon: false,onPressed: (){

                      }),
                  5.height,
                  Text(userData.name??"NA")
                ],
              )),
          drawerItemView("Profile", onTap: () {
            context.onBackPressed;
            const ProfileScreen().pushWithWidget(context: context);
          }, icon: Icons.person_outline_outlined),
          const Divider(),
          drawerItemView("Chats", onTap: () {
            context.onBackPressed;
          }, icon: Icons.message_outlined),
          const Divider(),
          drawerItemView("Logout", onTap: () async {
            await UsersController().userLogout();
            if (UsersController().firebaseAuth.currentUser == null) {
              const EmailLoginScreen().pushWithRemoveUntil(context: context);
            } else {
              Fluttertoast.showToast(msg: "Logout failed");
            }
          }, icon: Icons.logout),
          const Divider()
        ],
      ),
    );
  }

  Widget drawerItemView(String title,
      {void Function()? onTap, IconData? icon}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
