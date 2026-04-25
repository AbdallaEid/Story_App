import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:story_app/Views/view_story_view.dart';
import 'package:story_app/constants.dart';
import 'package:story_app/cubits/story_cubit/story_cubit.dart';
import 'package:story_app/models/story_model.dart';

class StoryCardItem extends StatelessWidget {
  const StoryCardItem({super.key, required this.story});

  final StoryModel story;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<StoryCubit>(context);
    final date = cubit.formattedDate(date: story.date);
    return SwipeActionCell(
      key: ValueKey(story.key),
      trailingActions: <SwipeAction>[
        SwipeAction(
          backgroundRadius: 16,
          icon: Icon(Icons.delete, color: Colors.white, size: 30),
          onTap: (CompletionHandler handler) async {
            await handler(true); // 👈 يعمل animation الاختفاء
            await cubit.deleteStory(story: story); // 👈 يمسح من الداتا
          },
          color: Colors.red,
        ),
      ],
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return StoryViewScreen(story: story);
              },
            ),
          );
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.only(top: 110),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 25,
                spreadRadius: 3,
                offset: Offset(0, 6),
              ),
            ],
            color: Constants.secondaryColor,
            image: story.imagePath != null
                ? DecorationImage(
                    image: Image.file(File(story.imagePath!)).image,
                    fit: BoxFit.cover,
                  )
                : DecorationImage(
                    image: Image.asset(
                      'assets/images/def.jpg',
                      fit: BoxFit.contain,
                    ).image,
                    fit: BoxFit.cover,
                  ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black.withOpacity(0.5),
            ),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  story.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Constants.mainTextColor,
                    fontFamily: 'LuckiestGuy',
                  ),
                ),

                // Pushes the Column to the far right
                Spacer(),

                // Use a Column to stack the text vertically
                Column(
                  mainAxisSize:
                      MainAxisSize.min, // Takes up only the space it needs
                  crossAxisAlignment:
                      CrossAxisAlignment.end, // Aligns text to the right
                  children: [
                    Text(
                      "< Swipe to delete",
                      style: Constants.hintTextStyle.copyWith(height: 1),
                    ),
                    Text(
                      date,
                      style: Constants.hintTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
