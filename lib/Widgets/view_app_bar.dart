import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/cubits/story_cubit/story_cubit.dart';

import '../Views/edit_story_screen.dart';
import '../constants.dart';
import '../models/story_model.dart';
import 'custom_icon.dart';

class ViewAppBar extends StatefulWidget {
  const ViewAppBar({super.key, required this.story, this.withBackground});

  final StoryModel story;
  final bool? withBackground;

  @override
  State<ViewAppBar> createState() => _ViewAppBarState();
}

class _ViewAppBarState extends State<ViewAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: widget.withBackground ?? true ? Constants.mainColor : null,
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomIcon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icons.arrow_back,
            withBorder: false,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              widget.story.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Constants.mainTextColor,
                fontFamily: 'LuckiestGuy',
              ),
            ),
          ),

          BlocBuilder<StoryCubit, StoryState>(
            builder: (context, state) {
              return CustomIcon(
                onPressed: () {
                  context.read<StoryCubit>().toggleFavorite(
                    story: widget.story,
                  );
                },
                icon: widget.story.isFavorite ?? false
                    ? Icons.favorite
                    : Icons.favorite_border,
                withBorder: false,
              );
            },
          ),

          // TODO: change this CustomIcon
          CustomIcon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditStoryScreen(story: widget.story),
                ),
              );
            },
            withBorder: false,
            icon: Icons.edit,
          ),
        ],
      ),
    );
  }
}
