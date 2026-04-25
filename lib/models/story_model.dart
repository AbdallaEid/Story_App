import 'package:hive/hive.dart';
part 'story_model.g.dart';

//generate model
// The generated file will have the same name as this file but with '.g.dart'
@HiveType(typeId: 0)
class StoryModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String subTitle;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  String? imagePath;
  @HiveField(4)
  bool? isFavorite;

  StoryModel({
    required this.title,
    required this.subTitle,
    required this.date,
    this.imagePath,
    this.isFavorite = false,
  });
}
