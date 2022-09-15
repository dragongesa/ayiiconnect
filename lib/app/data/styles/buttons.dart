import 'package:flutter/material.dart';

class Buttons {
  static primaryButton({Color? backgroundColor, Color? foregroundColor}) {
    return ButtonStyle(
      elevation: MaterialStateProperty.all(0),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 36,
        ),
      ),
      backgroundColor:
          MaterialStateProperty.all(backgroundColor ?? const Color(0xFF00cccc)),
      foregroundColor:
          MaterialStateProperty.all(foregroundColor ?? Colors.white),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
