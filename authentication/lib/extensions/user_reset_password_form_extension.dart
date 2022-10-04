import 'package:flutter/material.dart';

enum FormKey{email, password, confirmPassword}

extension UserResetPasswordFormExtension on FormKey {
	GlobalKey<FormState> get key => GlobalKey<FormState>();
}
