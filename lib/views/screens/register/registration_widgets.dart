import 'package:baat_cheet_app/views/utils/colors.dart';
import 'package:baat_cheet_app/views/utils/extensions/context_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/int_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/outline_boader_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class RegistrationWidgets {
  BuildContext context;

  RegistrationWidgets({required this.context});

  Widget fieldView(
          {required String title,
          required TextEditingController controller,
          TextInputType keyType = TextInputType.text,
          String? Function(String?)? validator}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          5.height,
          TextFormField(
            controller: controller,
            keyboardType: keyType,
            validator: validator,
            decoration: InputDecoration(
                counterText: "",
                hintText: "Enter $title",
                border: const OutlineInputBorder().textFieldBorder,
                errorBorder: const OutlineInputBorder().textFieldErrorBorder,
                focusedBorder: const OutlineInputBorder().textFieldFocusBorder,
                enabledBorder: const OutlineInputBorder().textFieldFocusBorder),
          ),
        ],
      );

  Widget passwordFieldView(
      {required String title,
        required TextEditingController controller,
        TextInputType keyType = TextInputType.text,
        String? Function(String?)? validator,
        bool showToggle = true,
        void Function()? onShowToggle}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          5.height,
          TextFormField(
            controller: controller,
            keyboardType: keyType,
            validator: validator,
            obscureText: !showToggle,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    showToggle ? Icons.visibility : Icons.visibility_off,
                    color: secondaryColor,
                  ),
                  onPressed: onShowToggle,
                ),
                counterText: "",
                hintText: "Enter $title",
                border: const OutlineInputBorder().textFieldBorder,
                errorBorder: const OutlineInputBorder().textFieldErrorBorder,
                focusedBorder: const OutlineInputBorder().textFieldFocusBorder,
                enabledBorder: const OutlineInputBorder().textFieldFocusBorder),
          ),
        ],
      );

  Widget otpDescription(String number) =>
      Text("We have sent 6 digit OTP on $number");

  Widget resentOtpView() =>
      TextButton(onPressed: () {}, child: const Text("Resent OTP"));

  Widget otpFieldView(
          {required String title, void Function(String)? onChanged}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          10.height,
          OTPTextField(
            onChanged: onChanged,
            length: 6,
            width: context.fullWidth,
            fieldWidth: 50,
            otpFieldStyle: OtpFieldStyle(
                borderColor: secondaryColor,
                enabledBorderColor: secondaryColor,
                focusBorderColor: secondaryColor),
            keyboardType: TextInputType.number,
            fieldStyle: FieldStyle.box,
          ).withHeight(50),
        ],
      );

  Widget submitButton(String title, {void Function()? onPressed}) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 10, fixedSize: const Size.fromHeight(50)),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
        ));
  }
}
