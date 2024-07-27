import 'dart:io';

import 'package:baat_cheet_app/controllers/media/media_controller.dart';
import 'package:baat_cheet_app/views/screens/chats/media/videos/video_player_screen.dart';
import 'package:baat_cheet_app/views/screens/chats/media/widgets/media_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultipleVideoScreen extends StatefulWidget {
  const MultipleVideoScreen({super.key});

  @override
  State<MultipleVideoScreen> createState() => _MultipleVideoScreenState();
}

class _MultipleVideoScreenState extends State<MultipleVideoScreen> {
  var mediaController = Get.put(MediaController());
  var videoFiles = <File>[];

  @override
  Widget build(BuildContext context) {
    var view = MediaWidgets(context: context);
    return Scaffold(
      appBar: view.mediaAppBarView("Multiple Videos", onPressed: () async {
         await mediaController.takeMultipleVideoFiles();
      }),
      body: Obx(() => GridView.builder(
          itemCount: mediaController.getVideoFiles.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (_, index) {
            return VideoPlayerScreen(videoFile: mediaController.getVideoFiles[index]);
          })),
    );
  }
}
