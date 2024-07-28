import 'package:flutter/material.dart';

class AuthWidgets {
  BuildContext context;

  AuthWidgets({required this.context});

  Widget authFieldView(TextEditingController controller, String label) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          validator: (text) {
            return text == null ? "Field is required" : null;
          },
          decoration: InputDecoration(
              labelText: label,
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        ),
      );

  Widget authButtonView(String title, {required void Function()? onPressed}) {
    return ElevatedButton(onPressed: onPressed, child: Text(title));
  }
}
