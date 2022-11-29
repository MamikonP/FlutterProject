import 'dart:io';

import 'package:image_picker/image_picker.dart';

class GalleryService {
  Future<File> loadImage(ImageSource imageSource) async {
    final XFile? file = await ImagePicker().pickImage(source: imageSource);
    if (file == null) {
      throw NullThrownError();
    }
    return File(file.path);
  }
}
