import 'package:flutter/material.dart';

enum FormKey{email, password}

extension UserLoginFormExtension on FormKey {
	GlobalKey<FormState> get key => GlobalKey<FormState>();
}
