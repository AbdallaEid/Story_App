import 'package:flutter/material.dart';

void customSnackBar({
  required String message,
  required Color backgroundColor,
  required BuildContext context,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
    ),
    snackBarAnimationStyle: AnimationStyle(duration: Duration(seconds: 1)),
  );
}
