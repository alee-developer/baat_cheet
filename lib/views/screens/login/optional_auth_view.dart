import 'package:baat_cheet_app/views/utils/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';

class OptionalAuthView extends StatelessWidget {
 final void Function()? onEmailTab;
  final void Function()? onGoogleTab;
   const OptionalAuthView({super.key,required this.onEmailTab,required this.onGoogleTab});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: onEmailTab,
            child: _circleView("assets/icons/email_image.png",10)),
        InkWell(
          onTap:onGoogleTab,
            child: _circleView("assets/icons/google_image.png",10))
      ],
    );
  }

  Widget _circleView(String image,double padding){
    return Card(
      elevation: 10,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50)
      ),
      child: SizedBox(
        height: 50,
        width: 180,
        child: Image.asset(image,).paddingAll(padding),
      ),
    );
  }
}
