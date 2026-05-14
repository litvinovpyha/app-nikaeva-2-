import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String title;
  final bool obscureText;
  final TextEditingController? controller;

  const MyTextField({
    super.key,
    required this.title,
    this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        hintText: title, // подсказка внутри поля
        border: const OutlineInputBorder(), // рамка вокруг поля
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
      ),
    );
  }
}
