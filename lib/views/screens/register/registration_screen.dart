import 'package:baat_cheet_app/views/screens/splash/splash_widgets.dart';
import 'package:baat_cheet_app/views/utils/colors.dart';
import 'package:baat_cheet_app/views/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(100))),
                child: Container(
                  height: context.fullHeight / 1.22,
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(20),topLeft:  Radius.circular(20)),
                      color: primaryColor,
                      shape: BoxShape.rectangle),
                  // ),
                ),
              )),
          Positioned(
              top: 10,
              left: context.fullWidth / 1.5,
              right: context.fullWidth/1.5,
              child: SplashWidgets(context: context).imageAndTitleView()),
        ],
      ),
    );
  }
}
