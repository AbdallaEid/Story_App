import 'dart:io';

import 'package:flutter/material.dart';
import 'package:story_app/models/story_model.dart';

import '../Widgets/custom_icon.dart';
import '../Widgets/view_app_bar.dart';
import '../constants.dart';
import 'edit_story_screen.dart';

class StoryViewScreen extends StatefulWidget {
  const StoryViewScreen({super.key, required this.story});

  final StoryModel story;

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              if (widget.story.imagePath != null)
                SizedBox(
                  height: height * 0.35,
                  width: double.infinity,
                  child: Image.file(
                    File(widget.story.imagePath!),
                    fit: BoxFit.cover,
                  ),
                ),
              ViewAppBar(
                story: widget.story,
                withBackground: widget.story.imagePath != null ? false : true,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Text(
                  widget.story.subTitle,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
