import 'package:baat_cheet_app/views/utils/colors.dart';
import 'package:baat_cheet_app/views/utils/extensions/int_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/text_style_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';

class SplashWidgets {
  BuildContext context;

  SplashWidgets({required this.context});

  Widget imageAndTitleView() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            color: secondaryColor,
            shape: RoundedRectangleBorder(borderRadius: 100.circularRadius),
            child: const Text(
              "B-CH",
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ).center().withSize(width: 200, height: 200),
          ),
          Text(
            "Baat Cheet App",
            style: const TextStyle().blackTextStyle,
          )
        ],
      );
}
