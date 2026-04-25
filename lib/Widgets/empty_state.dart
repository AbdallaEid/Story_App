import 'package:flutter/material.dart';

import '../constants.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

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
            "No stories yet",
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
