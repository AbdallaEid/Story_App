import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_app/Widgets/custom_app_bar.dart';
import 'package:story_app/models/story_model.dart';
import '../cubits/story_cubit/story_cubit.dart';

class EditStoryScreen extends StatefulWidget {
  const EditStoryScreen({super.key, required this.story});

  final StoryModel story;

  @override
  State<EditStoryScreen> createState() => _EditStoryScreenState();
}

class _EditStoryScreenState extends State<EditStoryScreen> {
  late TextEditingController titleController;
  late TextEditingController storyController;

  String? newImagePath;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.story.title);
    storyController = TextEditingController(text: widget.story.subTitle);
  }

  @override
  void dispose() {
    titleController.dispose();
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final cubit = BlocProvider.of<StoryCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                //  Clickable Image Section
                GestureDetector(
                  onTap: () async {
                    final path = await cubit.pickImage();
                    if (path != null) {
                      setState(() {
                        newImagePath = path;
                      });
                    }
                  },
                  child: SizedBox(
                    height: height * 0.5,
                    width: double.infinity,
                    child: _buildImageDisplay(),
                  ),
                ),

                // App Bar with Save Logic
                CustomAppBar(
                  title: "Edit Story",
                  icon: Icons.check,
                  isBack: true,
                  onPressed: () async {
                    // 1. Validation Logic
                    final title = titleController.text.trim();
                    final subTitle = storyController.text.trim();

                    if (title.isEmpty || subTitle.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Title and Story content cannot be empty!",
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return; // Stop the function here
                    }

                    // 2. Prepare the updated model
                    final updatedStory = StoryModel(
                      title: title,
                      subTitle: subTitle,
                      date:
                          DateTime.now(), // Or keep widget.story.date if preferred
                      imagePath: newImagePath ?? widget.story.imagePath,
                    );

                    // 3. Save via Cubit
                    await cubit.editStory(
                      story: updatedStory,
                      oldStoryKey: widget.story.key,
                    );

                    // 4. Return to Home
                    if (context.mounted) {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            //  Title Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: titleController,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                  labelText: 'Story Title',
                  hintText: 'Enter title',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            const SizedBox(height: 20),

            //  Story Content Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: storyController,
                maxLines: null, // Allows the field to grow
                minLines: 5, // Sets a decent starting size
                decoration: const InputDecoration(
                  labelText: 'Story Content',
                  hintText: 'Write your story...',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Helper to decide which image to show
  Widget _buildImageDisplay() {
    if (newImagePath != null) {
      return Image.file(File(newImagePath!), fit: BoxFit.cover);
    } else if (widget.story.imagePath != null &&
        widget.story.imagePath!.isNotEmpty) {
      return Image.file(File(widget.story.imagePath!), fit: BoxFit.cover);
    } else {
      return Padding(
        padding: const EdgeInsets.all(100.0),
        child: Image.asset('assets/images/noimage.jpg', fit: BoxFit.contain),
      );
    }
  }
}
