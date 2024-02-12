import 'package:baat_cheet_app/views/utils/extensions/int_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/text_style_extensions.dart';
import 'package:flutter/material.dart';

class ChatDetailsScreen extends StatelessWidget {
  const ChatDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white,),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.call,color: Colors.white,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.videocam,color: Colors.white,)),
          10.height,
        ],
        title: Row(
          children: [
            _imageView("assets/icons/google_image.png"),
            5.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("User Name",style: const TextStyle().whiteTitleTextStyle,),
                const Text("Online",style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),)
              ],
            )
          ],
        ),
        // leading: _imageView("assets/icons/google_image.png"),
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
