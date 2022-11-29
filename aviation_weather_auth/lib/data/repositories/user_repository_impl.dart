import 'package:image_picker/image_picker.dart';

import '../../core/repositories/user_repository.dart';
import '../../utils/utilities.dart';
import '../constants.dart';

class UserRepository implements IUserRepository {
  @override
  Future<XFile> pickImage(ImageSource imageSource) async {
    final XFile? file = await ImagePicker().pickImage(source: imageSource);
    if (file == null) {
      throw NullThrownError();
    }
    return file;
  }

  @override
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
