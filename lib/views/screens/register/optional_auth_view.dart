import 'package:baat_cheet_app/views/utils/extensions/widget_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionalAuthView extends StatefulWidget {
  const OptionalAuthView({super.key});

  @override
  State<OptionalAuthView> createState() => _OptionalAuthViewState();
}

class _OptionalAuthViewState extends State<OptionalAuthView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _circleView("assets/icons/email_image.png",10),
        _circleView("assets/icons/google_image.png",20)
      ],
    );
  }

  _circleView(String image,double padding){
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50)
      ),
      child: SizedBox(
        height: 80,
        width: 80,
        child: Image.asset(image,height: 60,).paddingAll(padding),
      ),
    );
  }


}
