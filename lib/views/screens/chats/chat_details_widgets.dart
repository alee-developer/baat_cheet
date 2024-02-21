import 'package:baat_cheet_app/controllers/users/users_controller.dart';
import 'package:baat_cheet_app/models/chat/chat_message_model.dart';
import 'package:baat_cheet_app/views/utils/colors.dart';
import 'package:baat_cheet_app/views/utils/extensions/context_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/date_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';

class ChatDetailsWidgets {
  BuildContext context;

  ChatDetailsWidgets({required this.context});

  Widget chatItemView(ChatMessageModel chat) {
    return SizedBox(
      width: context.fullWidth/1.4,
      child: Card(
        color: UsersController().getUserId != chat.from?Colors.transparent:secondaryColor,
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              chat.message ?? "NA",
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.normal),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                chat.date.toTimeOnly,
                style: const TextStyle(fontSize: 10, color: Colors.black),
              ),
            )
          ],
        ).paddingAll(10),
      ),
    );
  }

  Widget sendMessageView(bool showSendMessage,TextEditingController controller,{void Function()? onPressed,void Function(String)? onChanged}) {
    return Row(
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
                hintText: "Message...",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide:
                        const BorderSide(width: 2, color: secondaryColor))),
          ),
        ).expanded(),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: CircleAvatar(
            radius: 35,
            backgroundColor: secondaryColor,
            child: showSendMessage
                ? IconButton(
                    onPressed: onPressed,
                    icon: const Icon(
                      Icons.send_outlined,
                      color: Colors.white,
                      size: 30,
                    ))
                : IconButton(
                    onPressed: onPressed,
                    icon: const Icon(
                      Icons.mic_none,
                      color: Colors.white,
                      size: 30,
                    )),
          ),
        )
      ],
    );
  }
}
