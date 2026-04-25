import 'package:flutter/material.dart';
import 'package:story_app/Widgets/custom_icon.dart';
import 'package:story_app/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.icon,
    this.isBack,
    required this.title,
    this.onPressed,
    this.height = 150,
  });

  final IconData? icon;
  final bool? isBack;
  final String title;
  final void Function()? onPressed;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.only(top: 50, bottom: 20, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Constants.mainColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isBack ?? false)
            CustomIcon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icons.arrow_back,
            ),
          Expanded(
            child: Center(child: Text(title, style: Constants.titleTextStyle)),
          ),
          if (icon != null) CustomIcon(onPressed: onPressed, icon: icon),
        ],
      ),
    );
  }
}
