import 'dart:io';

import 'package:baat_cheet_app/views/utils/extensions/context_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

class MediaWidgets {
  BuildContext context;

  MediaWidgets({required this.context});

  AppBar mediaAppBarView(String title, {required void Function()? onPressed}) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.flip_camera_ios_outlined,
              color: Colors.white,
            ))
      ],
    );
  }

  Widget imageView(File file, {void Function()? onRemove}) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: primaryColor, width: 2)),
      height: context.fullHeight / 1.5,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: file.path != ""
                ? Image.file(
                    file,
                    fit: BoxFit.cover,
                    width: double.maxFinite,
                    height: double.maxFinite,
                  )
                : Center(child: Image.asset("assets/images/No-image-found.png")),
          ),
          Positioned(
              top: 5,
              right: 5,
              child: IconButton(
                  onPressed: onRemove,
                  icon: file.path != ""
                      ? const Icon(
                          Icons.delete_outline,
                          color: Colors.white,
                        )
                      : Container()))
        ],
      ),
    );
  }

  Widget multiImageView(List<File> files) {
    return files.isNotEmpty
        ? GridView.builder(
            itemCount: files.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (_, index) {
              return StatefulBuilder(
                builder: (BuildContext context,
                    void Function(void Function()) setState) {
                  return imageView(files[index], onRemove: () {
                    setState(() {
                      files.removeAt(index);
                    });
                  });
                },
              );
            })
        : noImageFoundView();
  }

  Widget noImageFoundView() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/No-image-found.png"),
          const Text(
            "Please choose image",
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }

  Widget addCaptionView(TextEditingController captionController) {
    return Row(
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: TextFormField(
            controller: captionController,
            decoration: InputDecoration(
                hintText: "Add Caption...",
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
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send_outlined,
                    color: Colors.white,
                    size: 25,
                  ))),
        )
      ],
    );
  }
}
