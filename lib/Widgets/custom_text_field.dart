import 'package:flutter/material.dart';
import 'package:story_app/constants.dart';

class Customtextfield extends StatelessWidget {
  const Customtextfield({
    super.key,
    required this.hint,
    this.maxLines = 1,
    this.onSaved,
    this.onChanged,
  });

  final String hint;
  final int maxLines;

  final void Function(String?)? onSaved;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: TextFormField(
        onSaved: onSaved,
        onChanged: onChanged,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'Field is required';
          } else {
            return null;
          }
        },
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: Constants.hintTextStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
