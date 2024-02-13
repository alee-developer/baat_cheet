import 'package:baat_cheet_app/models/chat/chat_message_model.dart';
import 'package:baat_cheet_app/views/screens/chats/chat_details_widgets.dart';
import 'package:baat_cheet_app/views/utils/colors.dart';
import 'package:baat_cheet_app/views/utils/extensions/int_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/text_style_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';

class ChatDetailsScreen extends StatefulWidget {
  const ChatDetailsScreen({super.key});

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  var chats = ChatMessageModel.messages();

  TextEditingController messageController = TextEditingController();

  bool sendMessageValue = false;
  ScrollController scrollController  = ScrollController();
  onNewItemAddedScroll(){
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    var view = ChatDetailsWidgets(context: context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: const BackButton(
          color: Colors.white,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.call,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.videocam,
                color: Colors.white,
              )),
          10.height,
        ],
        title: Row(
          children: [
            _imageView("assets/icons/google_image.png"),
            5.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "User Name",
                  style: const TextStyle().whiteTitleTextStyle,
                ),
                const Text(
                  "Online",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                )
              ],
            )
          ],
        ),
        // leading: _imageView("assets/icons/google_image.png"),
      ),
      body: Column(
        children: [
          ListView.builder(
           controller: scrollController,
              itemCount: chats.length,
              itemBuilder: (context, index) => Align(
                    alignment: chats[index].isCurrentUser == true
                        ? Alignment.topLeft
                        : Alignment.topRight,
                    child: view.chatItemView(chats[index]),
                  )).expanded(),
          view.sendMessageView(sendMessageValue, messageController,
              onPressed: () {
            chats.add(ChatMessageModel(
                updatedAt: DateTime.now(),
                messageAt: DateTime.now(),
                isCurrentUser: true,
                message: messageController.text));
            setState(() {
              onNewItemAddedScroll();
            });
          }, onChanged: (String message) {
            if (message.isNotEmpty && message != '') {
              setState(() {
                sendMessageValue = true;
              });
            } else {
              setState(() {
                sendMessageValue = false;
              });
            }
          }),
        ],
      ),
    );
  }

  _imageView(String path) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.white,
      child: Image.asset(path),
    );
  }
}
