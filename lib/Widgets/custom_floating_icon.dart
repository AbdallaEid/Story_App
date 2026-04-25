import 'package:flutter/material.dart';
import 'package:story_app/constants.dart';

class CustomFloatingIcon extends StatelessWidget {
  const CustomFloatingIcon({super.key, this.onTap, required this.text});
  final void Function()? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 55,
          decoration: BoxDecoration(
            color: Constants.mainColor,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Center(child: Text(text, style: Constants.normalTextStyle)),
        ),
      ),
    );
  }
}
