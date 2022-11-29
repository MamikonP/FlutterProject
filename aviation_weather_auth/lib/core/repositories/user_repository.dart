import 'package:image_picker/image_picker.dart';

abstract class IUserRepository {
  Future<XFile> pickImage(ImageSource imageSource);
  Future<bool> sendEmail();
}
