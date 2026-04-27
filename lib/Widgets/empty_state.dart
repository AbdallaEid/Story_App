import 'package:flutter/material.dart';

import '../constants.dart';

class EmptyState extends StatelessWidget {
  const EmptyState(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    // test
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/Empty.jpg', fit: BoxFit.contain),
          const SizedBox(height: 20),
          Text(
            title,
            style: Constants.normalTextStyle.copyWith(
              fontSize: 20,
              color: Constants.mainColor,
            ),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
