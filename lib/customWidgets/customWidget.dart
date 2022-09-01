import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  bool obscure;
  TextWidget(this.controller, this.hintText, this.obscure);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
            onPressed: () {
              controller.clear();
            },
            icon: const Icon(Icons.clear)),
      ),
    );
  }
}
