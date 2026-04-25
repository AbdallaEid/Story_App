import 'package:flutter/material.dart';
import 'package:story_app/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    required this.text,
    this.isSmallButton,
  });
  final void Function()? onTap;
  final String text;
  final bool? isSmallButton;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: isSmallButton ?? false
              ? MediaQuery.of(context).size.width * 0.5
              : MediaQuery.of(context).size.width,
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
