import 'package:baat_cheet_app/views/screens/chats/chats_widgets.dart';
import 'package:baat_cheet_app/views/utils/extensions/int_extensions.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var view = ChatsWidgets(context: context);
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text("Edu Messangers"),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.white,))
        ],
      ),
      body: ListView.separated(
        // padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        itemCount: 10,
        itemBuilder: (context, index) => view.chatItemView(),
        separatorBuilder: (BuildContext context, int index) {
          return  1.height;
        },
      ),
    );
  }
}
