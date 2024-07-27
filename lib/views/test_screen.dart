// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
//
// class CameraScreen extends StatefulWidget {
//   @override
//   _CameraScreenState createState() => _CameraScreenState();
// }
//
// class _CameraScreenState extends State<CameraScreen> {
//   CameraController? _controller;
//   late Future<void> _initializeControllerFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeControllerFuture = initializeCamera();
//   }
//
//   Future<void> initializeCamera() async {
//     final cameras = await availableCameras();
//     _controller = CameraController(cameras[0], ResolutionPreset.high);
//     await _controller?.initialize();
//     setState(() {});
//   }
//
//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (!_controller!.value.isInitialized) {
//       return Center(child: CircularProgressIndicator());
//     }
//
//     return Scaffold(
//       appBar: AppBar(title: Text('Take a Picture or Video')),
//       body: Column(
//         children: [
//           AspectRatio(
//             aspectRatio: _controller!.value.aspectRatio,
//             child: CameraPreview(_controller!),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               FloatingActionButton(
//                 onPressed: () async {
//                   try {
//                     await _initializeControllerFuture;
//                     // final path = join(
//                     //   (await getTemporaryDirectory()).path,
//                     //   '${DateTime.now()}.png',
//                     // );
//                     await _controller?.takePicture();
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Picture saved at ')));
//                   } catch (e) {
//                     print(e);
//                   }
//                 },
//                 child: Icon(Icons.camera_alt),
//               ),
//               FloatingActionButton(
//                 onPressed: () async {
//                   if (_controller!.value.isRecordingVideo) {
//                     final videoFile = await _controller?.stopVideoRecording();
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Video saved at ${videoFile?.path}')));
//                   } else {
//                     try {
//                       await _initializeControllerFuture;
//                       // final path = join(
//                       //   (await getTemporaryDirectory()).path,
//                       //   '${DateTime.now()}.mp4',
//                       // );
//                       await _controller?.startVideoRecording();
//                     } catch (e) {
//                       print(e);
//                     }
//                   }
//                   setState(() {});
//                 },
//                 child: Icon(_controller!.value.isRecordingVideo ? Icons.stop : Icons.videocam),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MediaPickerScreen extends StatefulWidget {
  @override
  _MediaPickerScreenState createState() => _MediaPickerScreenState();
}

class _MediaPickerScreenState extends State<MediaPickerScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile _image = XFile("");
  XFile _video = XFile("");

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if(image != null) _image = _image;
    setState(() {});
  }

  Future<void> _pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
    if(video != null) _video  = video;
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pick Image or Video')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_image != null)
            Image.file(
              File(_image.path),
              height: 200,
            ),
          if (_video != null)
            Container(
              height: 200,
              child: Center(child: Text('Video captured: ${_video.path}')),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: Icon(Icons.camera_alt),
                label: Text('Capture Image'),
              ),
              ElevatedButton.icon(
                onPressed: _pickVideo,
                icon: Icon(Icons.videocam),
                label: Text('Capture Video'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
