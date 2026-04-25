import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    super.key,
    required this.icon,
    this.onPressed,
    this.withBorder = true,
  });

  final void Function()? onPressed;
  final IconData? icon;
  final bool withBorder;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: withBorder
          ? ButtonStyle(
              side: WidgetStatePropertyAll(
                BorderSide(color: Colors.white, width: 1),
              ),
            )
          : null,
      onPressed: onPressed,
      icon: Icon(icon, size: 28, color: Colors.white),
    );
  }
}
