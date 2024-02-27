import 'package:baat_cheet_app/controllers/users/users_controller.dart';
import 'package:baat_cheet_app/models/chat/chat_data_model.dart';
import 'package:baat_cheet_app/views/utils/builders/shimmer_builder.dart';
import 'package:baat_cheet_app/views/utils/colors.dart';
import 'package:baat_cheet_app/views/utils/extensions/context_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/int_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatDetailsWidgets {
  BuildContext context;

  ChatDetailsWidgets({required this.context});

  Widget chatItemView(ChatDataModel chat) {
    return SizedBox(
      width: context.fullWidth / 1.4,
      child: Card(
        color: UsersController().getUserId == chat.senderId
            ? Colors.transparent
            : secondaryColor,
        child: InkWell(
          onLongPress: (){
            Fluttertoast.showToast(msg: "Long item pressed");
          },
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                chat.text ?? "NA",
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.normal),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  chat.time.toString(),
                  style: const TextStyle(fontSize: 10, color: Colors.black),
                ),
              )
            ],
          ).paddingAll(10),
        ),
      ),
    );
  }

  Widget sendMessageView(bool showSendMessage, TextEditingController controller,
      {void Function()? onPressed, void Function(String)? onChanged}) {
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
            radius: 25,
            backgroundColor: secondaryColor,
            child: showSendMessage
                ? IconButton(
                    onPressed: onPressed,
                    icon: const Icon(
                      Icons.send_outlined,
                      color: Colors.white,
                      size: 25,
                    ))
                : IconButton(
                    onPressed: onPressed,
                    icon: const Icon(
                      Icons.mic_none,
                      color: Colors.white,
                      size: 25,
                    )),
          ),
        )
      ],
    );
  }

  Widget chatShimmerView() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      itemCount: 16,
      itemBuilder: (c, index) {
        return Align(
          alignment: index%2==0?Alignment.topLeft:Alignment.topRight,
          child: ShimmerBuilder().showRectangularShimmer(
              height: 50,
              width: context.fullWidth/1.2,
              baseColor: Colors.grey.shade300),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return 10.height;
      },
    );
  }

}
