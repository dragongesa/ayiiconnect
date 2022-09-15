import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration outlined({
    String? hintText,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      isDense: true,
      hintText: hintText,
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
