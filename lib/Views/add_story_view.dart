import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/Widgets/custom_app_bar.dart';
import 'package:story_app/Widgets/add_story_form.dart';
import 'package:story_app/cubits/story_cubit/story_cubit.dart';

class AddStoryView extends StatelessWidget {
  const AddStoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          CustomAppBar(title: 'Add Story', isBack: true),
          SingleChildScrollView(
            child: BlocConsumer<StoryCubit, StoryState>(
              listener: (context, state) {
                if (state is AddStoryFailure) {}
                if (state is AddStorySuccess) {
                  BlocProvider.of<StoryCubit>(context).fetchAllStory();
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return AddStoryForm();
              },
            ),
          ),
        ],
      ),
    );
  }
}
