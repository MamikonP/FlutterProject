import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../data/constants.dart';
import '../utils/utilities.dart';

class ProfileService {
  Future<File> loadImage(ImageSource imageSource) async {
    final XFile? file = await ImagePicker().pickImage(source: imageSource);
    if (file == null) {
      throw NullThrownError();
    }
    return File(file.path);
  }

  Future<bool> sendEmail() async {
    final Utilities utilities = Utilities();
    final Uri uri = Uri(
      scheme: 'mailto',
      path: AppConstants.SUPPORT_EMAIL,
      queryParameters: utilities.encodeQueryParameters(
        <String, dynamic>{
          'subject': 'Feedback',
        },
      ),
    );
    return utilities.openLink(uri);
  }
}
