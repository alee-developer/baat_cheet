import 'package:baat_cheet_app/controllers/users/users_controller.dart';
import 'package:baat_cheet_app/views/screens/profile/profile_screen.dart';
import 'package:baat_cheet_app/views/utils/extensions/context_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/int_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../login/email_login_screen.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: context.fullWidth / 1.6,
      child: ListView(
        children: [
          DrawerHeader(child: _drawerHeaderView()),
          drawerItemView("Profile", onTap: () {
            context.onBackPressed;
            const ProfileScreen().pushWithWidget(context: context);
          }, icon: Icons.person_outline_outlined),
          const Divider(),
          drawerItemView("Chats", onTap: () {
            // context.onBackPressed;
          }, icon: Icons.message_outlined),
          const Divider(),
          drawerItemView("Logout", onTap: () async{
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

  Widget drawerItemView(String title, {void Function()? onTap, IconData? icon}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  _drawerHeaderView() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          child: Image.asset("assets/icons/email_image.png"),
        ),
        10.height,
        const Text("Name")
      ],
    );
  }
}
