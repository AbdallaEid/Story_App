import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/Views/add_story_view.dart';
import 'package:story_app/Widgets/custom_botton.dart';
import 'package:story_app/Widgets/story_list_view.dart';
import 'package:story_app/cubits/story_cubit/story_cubit.dart';

import '../Widgets/custom_app_bar.dart';
import '../Widgets/empty_state.dart';
import '../constants.dart';
import '../models/story_model.dart';
import 'favorite_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<StoryModel> stories = [];

  @override
  void initState() {
    final cubit = BlocProvider.of<StoryCubit>(context);
    stories = cubit.fetchAllStory() ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoryCubit, StoryState>(
      listener: (context, state) {
        final cubit = BlocProvider.of<StoryCubit>(context);

        if (state is AddStorySuccess ||
            state is DeleteStorySuccess ||
            state is UpdateStorySuccess) {
          setState(() {
            stories = cubit.fetchAllStory() ?? [];
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              CustomAppBar(title: 'Your Stories'),
              Expanded(
                child: stories.isEmpty
                    ? const EmptyState()
                    : StoryListView(stories: stories),
              ),
              CustomButton(
                text: 'Add Story',
                isSmallButton: true,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddStoryView()),
                  );
                },
              ),
            ],
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 3.5),
            child: FloatingActionButton(
              backgroundColor: Constants.mainColor,
              elevation: 0,
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => FavoriteView()));
              },
              child: Icon(Icons.favorite, color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
