import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:story_app/models/story_model.dart';

import '../../constants.dart';

part 'story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  StoryCubit() : super(StoryInitial());

  final storyBox = Hive.box<StoryModel>(Constants.kStoryBoxKey);

  Future<void> addStory(StoryModel story) async {
    emit(AddStoryLoading());
    try {
      var storyBox = Hive.box<StoryModel>(Constants.kStoryBoxKey);
      await storyBox.add(story);
      emit(AddStorySuccess());
    } on Exception catch (e) {
      emit(AddStoryFailure(e.toString()));
    }
  }

  Future<String?> pickImage() async {
    emit(PickImageLoadingState());
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      emit(PickImageSuccessState());
      return pickedImage.path;
    } else {
      emit(PickImageFailureState());
      return null;
    }
  }

  List<StoryModel>? fetchAllStory() {
    final story = storyBox.values.toList();
    story.sort((a, b) => b.date.compareTo(a.date));
    emit(StorySuccess());
    return story;
  }

  List<StoryModel>? fetchAllFavoriteStory() {
    final story = storyBox.values
        .toList()
        .where((story) => story.isFavorite == true)
        .toList();
    story.sort((a, b) => b.date.compareTo(a.date));
    emit(FavoriteStorySuccess());
    return story;
  }

  Future<void> deleteStory({required StoryModel story}) async {
    emit(DeleteStorySuccess());
    await storyBox.delete(story.key);
    fetchAllStory();
  }

  Future<void> editStory({
    required StoryModel story,
    required int oldStoryKey,
  }) async {
    try {
      await storyBox.put(oldStoryKey, story);
      emit(UpdateStorySuccess());
      fetchAllStory();
    } catch (e) {
      emit(UpdateStoryFailure());
    }
  }

  Future<void> toggleFavorite({required StoryModel story}) async {
    try {
      story.isFavorite = !(story.isFavorite ?? false);
      await story.save();
      fetchAllStory();
      fetchAllFavoriteStory();
    } catch (e) {
      print("Error toggling favorite: $e");
    }
  }

  String formattedDate({required DateTime date}) {
    var formattedDate = DateFormat.yMMMMd().format(date);
    return formattedDate;
  }
}
