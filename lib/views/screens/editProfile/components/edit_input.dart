import 'package:books_app/core/app_colors.dart';
import 'package:flutter/material.dart';

class EditInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const EditInput({Key? key, required this.label, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.lightGray),
        focusColor: AppColors.green,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightGray),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.green),
        ),
      ),
    );
  }
}
