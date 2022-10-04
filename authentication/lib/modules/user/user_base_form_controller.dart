import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UserBaseFormController extends GetxController{
	final TextEditingController email = TextEditingController();
	final TextEditingController password = TextEditingController();
	final TextEditingController pinCodeController = TextEditingController();
	final RxBool obscure = true.obs;
	final RxString _responseError = ''.obs;
	late WebViewController? webViewController;
	GlobalKey<FormState>? firstNameKey;
	GlobalKey<FormState>? lastNameKey;
	GlobalKey<FormState>? emailKey;
	GlobalKey<FormState>? passwordKey;
	GlobalKey<FormState>? confirmPasswordKey;

	set responseError(String error) => _responseError.value = error;
	String get responseError => _responseError.value;
}
