import 'package:baat_cheet_app/views/screens/chats/chat_details_screen.dart';
import 'package:baat_cheet_app/views/utils/colors.dart';
import 'package:baat_cheet_app/views/utils/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';

class ChatsWidgets {
  BuildContext context;

  ChatsWidgets({required this.context});

  Widget chatItemView() {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
      tileColor: secondaryColor.withOpacity(.5),
      onTap: () {
        const ChatDetailsScreen().pushWithWidget(context: context);
      },
      leading: _imageView("assets/icons/google_image.png"),
      title: const Text("User Name"),
      subtitle: const Text("recent message"),
      trailing: PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                child: Text("Profile"),
              ),const PopupMenuItem(
                child: Text("Delete"),
              )
            ];
          },
          icon: const Icon(Icons.more_vert)),
    );
  }

  _imageView(String path) {
    return CircleAvatar(
      radius: 40,
      backgroundColor: Colors.white,
      child: Image.asset(path),
    );
  }
}
