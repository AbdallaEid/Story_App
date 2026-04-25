import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/cubits/story_cubit/story_cubit.dart';
import 'package:story_app/models/story_model.dart';

import 'story_card_item.dart';

class StoryListView extends StatefulWidget {
  const StoryListView({super.key, required this.stories});
  final List<StoryModel> stories;
  @override
  State<StoryListView> createState() => _StoryListViewState();
}

class _StoryListViewState extends State<StoryListView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoryCubit, StoryState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.stories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: StoryCardItem(story: widget.stories[index]),
              );
            },
          ),
        );
      },
    );
  }
}
