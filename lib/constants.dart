import 'package:flutter/material.dart';

class Constants {
  /// KEYS
  static const kStoryBoxKey = 'story_box';

  /// Colors
  static const mainColor = Colors.teal;
  static const secondaryColor = Colors.orangeAccent;
  static const mainTextColor = Colors.white;
  static const blackColor = Colors.black38;

  static const errorColor = Colors.red;
  static const successColor = Colors.green;
  static const warningColor = Colors.orange;

  /// text style

  static const titleTextStyle = TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.bold,
    color: Constants.mainTextColor,
    fontFamily: 'LuckiestGuy',
  );
  static const normalTextStyle = TextStyle(
    color: Constants.mainTextColor,
    fontSize: 20,
    fontFamily: 'Baloo2',
  );
  static const hintTextStyle = TextStyle(
    color: Constants.blackColor,
    fontSize: 11,
    height: 2,
  );
}
