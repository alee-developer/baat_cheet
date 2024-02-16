import 'dart:io';
import 'package:baat_cheet_app/views/utils/builders/shimmer_builder.dart';
import 'package:baat_cheet_app/views/utils/extensions/context_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/int_extensions.dart';
import 'package:baat_cheet_app/views/utils/colors.dart';
import 'package:baat_cheet_app/views/utils/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';

class ProfileWidgets extends ShimmerBuilder {
  BuildContext context;

  ProfileWidgets({required this.context});

  Widget userImageView(String imagePath, bool isNetwork,
      {void Function()? onPressed}) {
    return SizedBox(
      height: 180,
      width: 150,
      child: Stack(
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: secondaryColor),
                borderRadius: BorderRadius.circular(75)),
            child: isNetwork
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(75),
                    child: Image.network(
                      imagePath,
                      height: 150,
                      width: 150,
                      fit: BoxFit.fill,
                    ),
                  )
                : imagePath != ""
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(75),
                        child: Image.file(
                          File(imagePath),
                          height: 150,
                          width: 150,
                          fit: BoxFit.fill,
                        ),
                      )
                    : const Icon(
                        Icons.person_outline_outlined,
                        color: secondaryColor,
                        size: 80,
                      ),
          ).center(),
          Positioned(
              bottom: 10,
              right: 10,
              child: CircleAvatar(
                backgroundColor: secondaryColor,
                child: IconButton(
                  onPressed: onPressed,
                  icon: const Icon(Icons.edit),
                  color: Colors.white,
                ),
              ))
        ],
      ),
    ).center();
  }

  Widget itemView(TextEditingController controller,
      {void Function()? onPressed, bool canEdit = false}) {
    return _itemDecoration(Row(
      children: [
        TextFormField(
          enabled: canEdit,
          readOnly: !canEdit,
          autofocus: !canEdit,
          focusNode: FocusNode(canRequestFocus: true),
          cursorColor: Colors.black,
          controller: controller,
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              border: InputBorder.none),
        ).expanded(),
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.edit,
              color: canEdit ? Colors.black : secondaryColor,
            ))
      ],
    ));
  }

  Widget _itemDecoration(Widget child) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1)),
      child: child,
    );
  }

  Widget itemButton({void Function()? onPressed, bool enabled = false}) {
    return ElevatedButton(
        onPressed: enabled ? onPressed : null,
        child: Text(
          "Update",
          style: TextStyle(color: enabled ? Colors.white : Colors.black),
        ));
  }

  Widget profileShimmerView() {
    // var shimmer = ShimmerBuilder();
    return Column(
      children: [
        showCircularShimmer(size: 150, baseColor: Colors.grey.shade200)
            .center(),
        20.height,
        showRectangularShimmer(
            width: context.fullWidth,
            height: 55,
            baseColor: Colors.grey.shade400),
        16.height,
        showRectangularShimmer(
            width: context.fullWidth,
            height: 55,
            baseColor: Colors.grey.shade400),
        16.height,
        showRectangularShimmer(
            width: context.fullWidth,
            height: 55,
            baseColor: Colors.grey.shade400),
        40.height,
        showRectangularShimmer(
            width: context.fullWidth,
            height: 55,
            radius: 25,
            baseColor: Colors.grey.shade400),
      ],
    ).paddingAll(20);
  }
}
