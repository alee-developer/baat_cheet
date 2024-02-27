import 'package:baat_cheet_app/controllers/chats/chat_controllers.dart';
import 'package:baat_cheet_app/models/chat/chat_data_model.dart';
import 'package:baat_cheet_app/models/users/user_details_model.dart';
import 'package:baat_cheet_app/views/screens/chats/chat_details_widgets.dart';
import 'package:baat_cheet_app/views/utils/extensions/date_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/int_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/text_style_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';

import '../../../controllers/users/users_controller.dart';
import '../profile/profile_widgets.dart';

class ChatDetailsScreen extends StatefulWidget {
  final UserDetailsModel userData;

  const ChatDetailsScreen({super.key, required this.userData});

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  TextEditingController messageController = TextEditingController();

  bool sendMessageValue = false;
  ScrollController scrollController = ScrollController();

  onNewItemAddedScroll() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
    setState(() {});
  }

  String chatId = "";

  @override
  void initState() {
    super.initState();
    createChatId();
    // onNewItemAddedScroll();
  }

  createChatId() async {
    var data = await UsersController().getUserDetails();
    if (data.createdAt != null && data.createdAt != null) {
      var a = data.createdAt!.millisecondsSinceEpoch;
      var b = widget.userData.createdAt!.millisecondsSinceEpoch;
      chatId = (a + b).toString();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var view = ChatDetailsWidgets(context: context);
    var profileView = ProfileWidgets(context: context);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.call,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.videocam,
                color: Colors.white,
              )),
          10.height,
        ],
        title: Row(
          children: [
            profileView.userImageView(
                widget.userData.imageUrl ?? "",
                widget.userData.imageUrl == null
                    ? false
                    : widget.userData.imageUrl != ""
                        ? true
                        : false,
                size: 45,
                showIcon: false,
                borderColor: Colors.white),
            5.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userData.name ?? "User Name",
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
      ),
      body: Column(
        children: [
          StreamBuilder(
              stream: ChatControllers().getDate(chatId),
              builder: (c, snap) {
                var data = snap.data?.snapshot.children;
                var messages = List<ChatDataModel>.empty();
                if (snap.hasData) {
                  var chats = data?.map((e) => e.value).toList();
                  messages = chats
                          ?.map((e) => ChatDataModel.fromJson(
                              e as Map<dynamic, dynamic>))
                          .toList()
                          .reversed
                          .toList() ??
                      messages;
                  return ListView.builder(
                      reverse: true,
                      controller: scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) => Align(
                            alignment: messages[index].senderId ==
                                    UsersController().getUserId
                                ? Alignment.topLeft
                                : Alignment.topRight,
                            child: view.chatItemView(messages[index]),
                          ));
                } else {
                  return view.chatShimmerView();
                }
              }).expanded(),
          view.sendMessageView(sendMessageValue, messageController,
              onPressed: () {
            var chat = ChatDataModel(
                text: messageController.text,
                senderId: widget.userData.userId,
                date: DateTime.now().dateWithHalfMonthName,
                time: DateTime.now().toTimeOnly);
            ChatControllers().sendDataMessage(chatId, chat);
            // onNewItemAddedScroll();
            messageController.clear();
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
          }).withHeight(60),
        ],
      ),
    );
  }
}
