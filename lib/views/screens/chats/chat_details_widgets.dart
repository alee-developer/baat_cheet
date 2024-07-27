import 'dart:io';
import 'package:baat_cheet_app/controllers/media/media_controller.dart';
import 'package:baat_cheet_app/controllers/permissions/permissions_controller.dart';
import 'package:baat_cheet_app/controllers/users/users_controller.dart';
import 'package:baat_cheet_app/models/chat/chat_data_model.dart';
import 'package:baat_cheet_app/views/screens/chats/media/images/single_image_screen.dart';
import 'package:baat_cheet_app/views/screens/chats/media/videos/single_video_screen.dart';
import 'package:baat_cheet_app/views/utils/builders/shimmer_builder.dart';
import 'package:baat_cheet_app/views/utils/colors.dart';
import 'package:baat_cheet_app/views/utils/extensions/context_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/int_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatDetailsWidgets {
  BuildContext context;

  ChatDetailsWidgets({required this.context});

  var mediaProvider = Get.put(MediaController());

  Widget chatItemView(ChatDataModel chat) {
    return SizedBox(
      width: context.fullWidth / 1.4,
      child: Card(
        color: UsersController().getUserId == chat.senderId
            ? Colors.transparent
            : secondaryColor,
        child: InkWell(
          onLongPress: () {
            Fluttertoast.showToast(msg: "Long item pressed");
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Text(
                  chat.text ?? "NA",
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.normal),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    chat.time.toString(),
                    style: const TextStyle(fontSize: 10, color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sendMessageView(bool showSendMessage, TextEditingController controller,
      {void Function()? onPressed, void Function(String)? onChanged}) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              showMediaViewDialog();
            },
            icon: const Icon(Icons.attach_file)),
        IconButton(
            onPressed: () {
              showCameraViewDialog();
            },
            icon: const Icon(Icons.camera_alt_outlined)),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
                hintText: "Message...",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide:
                        const BorderSide(width: 2, color: secondaryColor))),
          ),
        ).expanded(),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: CircleAvatar(
            radius: 25,
            backgroundColor: secondaryColor,
            child: showSendMessage
                ? IconButton(
                    onPressed: onPressed,
                    icon: const Icon(
                      Icons.send_outlined,
                      color: Colors.white,
                      size: 25,
                    ))
                : IconButton(
                    onPressed: onPressed,
                    icon: const Icon(
                      Icons.mic_none,
                      color: Colors.white,
                      size: 25,
                    )),
          ),
        )
      ],
    );
  }

  Widget chatShimmerView() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      itemCount: 16,
      itemBuilder: (c, index) {
        return Align(
          alignment: index % 2 == 0 ? Alignment.topLeft : Alignment.topRight,
          child: ShimmerBuilder().showRectangularShimmer(
              height: 50,
              width: context.fullWidth / 1.2,
              baseColor: Colors.grey.shade300),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return 10.height;
      },
    );
  }

  showCameraViewDialog() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return SizedBox(
            height: context.fullHeight / 4,
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Camera",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ).center().expanded(),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: IconButton(
                          onPressed: () {
                            context.onBackPressed;
                          },
                          icon: const Icon(
                            Icons.clear,
                            size: 30,
                          )),
                    )
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _mediaCardView(Icons.videocam_outlined, onTap: () async {
                      if (await PermissionsController.checkPermission(
                          Permission.camera)) {
                        var imageFile =
                            await mediaProvider.takeVideoFromCamera();
                        if (imageFile != null) {
                          context.gotoNext(
                              page: SingleVideoScreen(
                                  videoFile: File(imageFile.path)));
                        }
                      }
                    }),
                    10.width,
                    _mediaCardView(Icons.image_outlined, onTap: () async {
                      if (await PermissionsController.checkPermission(
                          Permission.camera)) {
                        var imageFile =
                            await mediaProvider.takeImageFromCamera();
                        if (imageFile != null) {
                          context.gotoNext(page: SingleImageScreen(
                              imageFile: File(imageFile.path)));
                        }
                      }
                    })
                  ],
                )
              ],
            ),
          );
        });
  }

  showMediaViewDialog() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return SizedBox(
            height: context.fullHeight / 2,
            child: Column(
              children: [
                Row(
                  children: [
                    Container().center().expanded(),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: IconButton(
                          onPressed: () {
                            context.onBackPressed;
                          },
                          icon: const Icon(
                            Icons.clear,
                            size: 30,
                          )),
                    )
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _mediaCardView(Icons.videocam_outlined, onTap: () async {
                      if (await PermissionsController.checkPermission(
                          Permission.camera)) {
                        // var imageFile =
                        //     await MediaController.takeVideoFromCamera();
                      }
                    }),
                    10.width,
                    _mediaCardView(Icons.file_copy_outlined, onTap: () async {
                      if (await PermissionsController.checkPermission(
                          Permission.camera)) {
                        // var imageFile =
                        //     await mediaProvider.getSingleImage();
                      }
                    })
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _mediaCardView(Icons.video_library_outlined,
                        onTap: () async {
                      if (await PermissionsController.checkPermission(
                          Permission.mediaLibrary)) {
                        var imageFile =
                            await mediaProvider.takeMultipleImageFromGallery();
                      }
                    }),
                    10.width,
                    _mediaCardView(Icons.image_outlined, onTap: () async {
                      if (await PermissionsController.checkPermission(
                          Permission.camera)) {
                        // var imageFile =
                        //     await mediaProvider.getSingleImage();
                      }
                    })
                  ],
                )
              ],
            ),
          );
        });
  }

  Widget _mediaCardView(IconData icon, {void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: context.fullHeight / 8,
        width: context.fullWidth / 3,
        child: Card(
          shape: const CircleBorder(
              // borderRadius: BorderRadius.circular(8),
              side: BorderSide(width: 1, color: Colors.black)),
          child: Icon(
            icon,
            size: 40,
          ),
        ),
      ),
    );
  }
}
