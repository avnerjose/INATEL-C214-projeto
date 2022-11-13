import 'package:books_app/core/app_colors.dart';
import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  const FormInput(
      {Key? key,
      required this.hintText,
      required this.icon,
      required this.controller,
      this.obscureText = false})
      : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
        obscureText: obscureText,
        controller: controller,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
            hintText: hintText,
            hintStyle: const TextStyle(color: AppColors.lightGray),
            filled: true,
            fillColor: AppColors.background,
            prefixIcon: Icon(
              icon,
              color: AppColors.lightGray,
            )));
  }
}
