part of 'story_cubit.dart';

@immutable
sealed class StoryState {}

// get story
final class StoryInitial extends StoryState {}

final class StorySuccess extends StoryState {}

final class FavoriteStorySuccess extends StoryState {}

// delete story
final class DeleteStorySuccess extends StoryState {}

// add story
final class AddStoryInitial extends StoryState {}

final class AddStoryLoading extends StoryState {}

final class AddStorySuccess extends StoryState {}

final class AddStoryFailure extends StoryState {
  final String errMessage;

  AddStoryFailure(this.errMessage);
}
// update

final class UpdateStorySuccess extends StoryState {}

final class UpdateStoryFailure extends StoryState {}

// image
final class PickImageLoadingState extends StoryState {}

final class PickImageSuccessState extends StoryState {}

final class PickImageFailureState extends StoryState {}

// Empty State

final class StoryEmpty extends StoryState {}
