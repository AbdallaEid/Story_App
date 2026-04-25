import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:story_app/Widgets/custom_snackbar.dart';
import 'package:story_app/constants.dart';
import 'package:story_app/cubits/story_cubit/story_cubit.dart';
import 'package:story_app/models/story_model.dart';
import 'custom_botton.dart';
import 'custom_text_field.dart';

class AddStoryForm extends StatefulWidget {
  const AddStoryForm({super.key});

  @override
  State<AddStoryForm> createState() => _AddStoryFormState();
}

class _AddStoryFormState extends State<AddStoryForm> {
  final GlobalKey<FormState> formKey = GlobalKey();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  String? title, subTitle, imagePath;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoryCubit, StoryState>(
      listener: (context, state) {
        if (state is AddStoryFailure) {
          customSnackBar(
            message: "Sorry we can't save your story now",
            backgroundColor: Constants.errorColor,
            context: context,
          );
        }

        if (state is PickImageFailureState) {
          customSnackBar(
            message: "Please select an image",
            backgroundColor: Constants.errorColor,
            context: context,
          );
        }

        if (state is PickImageSuccessState) {
          customSnackBar(
            message: "Image Saved",
            backgroundColor: Constants.successColor,
            context: context,
          );
        }
      },
      builder: (context, state) {
        final cubit = BlocProvider.of<StoryCubit>(context);
        return Form(
          key: formKey,
          autovalidateMode: autoValidateMode,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              children: [
                Customtextfield(
                  onSaved: (value) {
                    setState(() {
                      title = value;
                    });
                  },
                  hint: 'title',
                ),
                Customtextfield(
                  onSaved: (value) {
                    setState(() {
                      subTitle = value;
                    });
                  },
                  hint: 'content',
                  maxLines: 5,
                ),
                GestureDetector(
                  onTap: () async {
                    imagePath = await cubit.pickImage();
                    setState(() {
                      // to refresh the image path
                    });
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          state is PickImageSuccessState
                              ? Icons.check
                              : Icons.image,
                          size: 50,
                          color: Constants.mainColor,
                        ),
                        Text('Add Image', style: Constants.hintTextStyle),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      var storyModel = StoryModel(
                        title: title!,
                        subTitle: subTitle!,
                        date: DateTime.now(),
                        imagePath: imagePath,
                      );
                      await cubit.addStory(storyModel);
                    } else {
                      autoValidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                  text: 'Save',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
