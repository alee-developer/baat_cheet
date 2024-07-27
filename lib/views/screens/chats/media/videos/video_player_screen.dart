import 'dart:io';
import 'package:baat_cheet_app/controllers/media/media_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final File videoFile;
  const VideoPlayerScreen({super.key, required this.videoFile});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  var mediaController = Get.put(MediaController());

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.videoFile)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(
        margin: const EdgeInsets.all(10),
        child: Stack(
          children: [
            _controller.value.isInitialized?VideoPlayer(_controller):Container(),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Card(
                  child: IconButton(onPressed: (){
                    if(_controller.value.isPlaying){
                      _controller.pause();
                    }else{
                      _controller.play();
                    }
                    setState(() {

                    });
                  }, icon: Icon(_controller.value.isPlaying?Icons.pause:Icons.play_arrow)),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

}
