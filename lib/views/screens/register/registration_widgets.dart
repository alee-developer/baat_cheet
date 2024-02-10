import 'package:baat_cheet_app/views/screens/login/login_screen.dart';
import 'package:baat_cheet_app/views/utils/colors.dart';
import 'package:baat_cheet_app/views/utils/extensions/context_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/int_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class RegistrationWidgets {
  BuildContext context;

  RegistrationWidgets({required this.context});

  Widget fieldView(
          {required String title, required TextEditingController controller}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "Enter $title"),
          ).withHeight(50),
        ],
      );

  Widget otpDescription(String number)=>Text("We have sent 6 digit OTP on $number");
  Widget resentOtpView()=>TextButton(onPressed: (){}, child: const Text("Resent OTP"));

  Widget otpFieldView({
    required String title,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          10.height,
          OTPTextField(
            length: 6,
            width: context.fullWidth,
            fieldWidth: 50,
            otpFieldStyle: OtpFieldStyle(
              borderColor: secondaryColor,
              enabledBorderColor: secondaryColor,
              focusBorderColor: secondaryColor
            ),
            keyboardType: TextInputType.number,
            fieldStyle: FieldStyle.box,
          ).withHeight(50),
        ],
      );

  Widget getOtpButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 10, fixedSize: const Size.fromHeight(50)),
        onPressed: () {
          LoginScreen().pushWithWidget(context: context);
        },
        child: const Text(
          "Get OTP",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
        ));
  }
}
