import 'dart:io';

import 'package:baat_cheet_app/views/screens/chats/media/widgets/media_widgets.dart';
import 'package:baat_cheet_app/views/utils/colors.dart';
import 'package:baat_cheet_app/views/utils/extensions/context_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../controllers/media/media_controller.dart';
import '../../../../../controllers/permissions/permissions_controller.dart';

class SingleImageScreen extends StatefulWidget {
  File imageFile;

  SingleImageScreen({super.key, required this.imageFile});

  @override
  State<SingleImageScreen> createState() => _SingleImageScreenState();
}

class _SingleImageScreenState extends State<SingleImageScreen> {
  var captionController = TextEditingController();
  var mediaProvider = Get.put(MediaController());

  @override
  Widget build(BuildContext context) {
    var view = MediaWidgets(context: context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.fullWidth, 60),
        child: view.mediaAppBarView("Picture", onPressed: () async {
          if (await PermissionsController.checkPermission(Permission.camera)) {
            await mediaProvider.takeImageFromCamera();
          }
        }),
      ),
      body: Column(
        children: [
          Expanded(
              child: Obx(() => view.imageView(
                  mediaProvider.getCameraImageFile.value,
                  onRemove: () {
                    mediaProvider.getCameraImageFile.value = File("");
                  }))),
          view.addCaptionView(captionController)
        ],
      ),
    );
  }
}
