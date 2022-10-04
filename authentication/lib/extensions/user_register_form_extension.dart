import 'package:flutter/material.dart';

enum FormKey{firstName, lastName, email, password, confirmPassword}

extension UserRegisterFormExtension on FormKey {
	GlobalKey<FormState> get key => GlobalKey<FormState>();
}
