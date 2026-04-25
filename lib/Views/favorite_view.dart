import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/Widgets/story_list_view.dart';
import 'package:story_app/cubits/story_cubit/story_cubit.dart';
import 'package:story_app/models/story_model.dart';

import '../Widgets/custom_app_bar.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  List<StoryModel> stories = [];

  @override
  void initState() {
    final cubit = BlocProvider.of<StoryCubit>(context);
    stories = cubit.fetchAllFavoriteStory() ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoryCubit, StoryState>(
      listener: (context, state) {
        final cubit = BlocProvider.of<StoryCubit>(context);

        if (state is FavoriteStorySuccess) {
          setState(() {
            stories = cubit.fetchAllStory() ?? [];
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              CustomAppBar(title: 'favorite', isBack: true),
              StoryListView(stories: stories),
            ],
          ),
        );
      },
    );
  }
}
