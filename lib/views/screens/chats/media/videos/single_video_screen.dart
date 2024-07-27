import 'dart:io';

import 'package:baat_cheet_app/controllers/media/media_controller.dart';
import 'package:baat_cheet_app/views/screens/chats/media/videos/video_player_screen.dart';
import 'package:baat_cheet_app/views/screens/chats/media/widgets/media_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleVideoScreen extends StatefulWidget {
  final File videoFile;
  const SingleVideoScreen({super.key, required this.videoFile});

  @override
  State<SingleVideoScreen> createState() => _SingleVideoScreenState();
}

class _SingleVideoScreenState extends State<SingleVideoScreen> {
  var mediaController = Get.put(MediaController());
  @override
  Widget build(BuildContext context) {
    var view = MediaWidgets(context: context);
    return Scaffold(
      appBar: view.mediaAppBarView("Video", onPressed: (){
        mediaController.takeVideoFiles();
      }),
      body: Obx(()=>VideoPlayerScreen(videoFile: widget.videoFile)),
    );
  }
}
