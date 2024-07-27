import 'dart:io';
import 'package:baat_cheet_app/views/screens/chats/media/widgets/media_widgets.dart';
import 'package:baat_cheet_app/views/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../controllers/media/media_controller.dart';
import '../../../../../controllers/permissions/permissions_controller.dart';

class MultipleImageScreen extends StatefulWidget {
  List<File> imageFiles;

  MultipleImageScreen({super.key, required this.imageFiles});

  @override
  State<MultipleImageScreen> createState() => _MultipleImageScreenState();
}

class _MultipleImageScreenState extends State<MultipleImageScreen> {
  var captionController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var mediaProvider = Get.put(MediaController());
    var view = MediaWidgets(context: context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.fullWidth,60),
        child: view.mediaAppBarView("Multiple Picture", onPressed: () async {
          if (await PermissionsController.checkPermission(
              Permission.camera)) {
            mediaProvider.takeMultipleImageFromGallery();
          }
        })),
      body: Column(
        children: [
          Expanded(child: Obx(()=>view.multiImageView(mediaProvider.getGalleryImageFiles))),
          view.addCaptionView(captionController)
        ],
      ),
    );
  }
}
