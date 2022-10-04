import 'package:get/get.dart';

import 'user_login_controller.dart';
import 'user_register_controller.dart';
import 'user_reset_password_controller.dart';

class UserAuthorizationBinding implements Bindings {
	@override
	void dependencies() {
		Get.create<UserLoginController>(() => UserLoginController());
		Get.create<UserRegisterController>(() => UserRegisterController());
		Get.create<UserResetPasswordController>(() => UserResetPasswordController());
	}
}
