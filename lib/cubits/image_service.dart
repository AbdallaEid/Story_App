import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageService {
  final ImagePicker _picker = ImagePicker();

  Future<String?> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    return image?.path;
  }

  Future<String> saveImage(String path) async {
    final directory = await getApplicationDocumentsDirectory();

    final name = path.split('/').last;
    final newImage = File('${directory.path}/$name');

    final copiedImage = await File(path).copy(newImage.path);

    return copiedImage.path;
  }
}
