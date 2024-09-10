import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const CustomFormField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: AppColors.tileColor,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white70,
        ),
      ),
      style: const TextStyle(
        color: Colors.white,
      ),
      maxLines: 1,
    );
  }
}
